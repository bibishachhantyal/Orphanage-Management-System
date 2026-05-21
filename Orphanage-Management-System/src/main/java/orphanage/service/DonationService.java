package orphanage.service;

import orphanage.dao.DonationDAO;
import orphanage.dao.DonorDAO;
import orphanage.dao.OrphanDAO;
import orphanage.model.Donation;
import orphanage.model.Donor;
import orphanage.model.Orphan;


import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public class DonationService {
    private final DonationDAO donationDAO = new DonationDAO();
    private final DonorDAO donorDAO = new DonorDAO();
    private final OrphanDAO orphanDAO = new OrphanDAO();

    public ServiceResult<String> processPublicDonation(String name, String email, String phone,
                                                       String amountStr, String purpose,
                                                       String payment, String orphanParam) {
        if (name == null || name.isBlank() || email == null || email.isBlank()
                || amountStr == null || amountStr.isBlank()) {
            return ServiceResult.fail("Please enter your name, email, and donation amount.");
        }

        double amount;
        try {
            amount = Double.parseDouble(amountStr.trim());
            if (amount <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            return ServiceResult.fail("Please enter a valid donation amount.");
        }

        Donor donor = donorDAO.findByEmail(email.trim());
        if (donor == null) {
            donor = new Donor();
            donor.setFull_name(name.trim());
            donor.setEmail(email.trim());
            donor.setPhone(phone == null ? "" : phone.trim());
            donor.setAddress("");
            donor.setDonor_type("Individual");
            int id = donorDAO.addDonorReturningId(donor);
            if (id < 0) {
                return ServiceResult.fail("Could not save your details. Please try again.");
            }
            donor.setId(id);
        }

        Donation d = new Donation();
        d.setDonor_id(donor.getId());
        d.setOrphan_id(parseOrphanId(orphanParam));
        d.setAmount(amount);
        d.setDonation_date(LocalDate.now().toString());
        d.setPayment_method(payment == null || payment.isBlank() ? "Online" : payment.trim());
        d.setPurpose(purpose == null || purpose.isBlank() ? "General orphanage support" : purpose.trim());
        donationDAO.addDonation(d);
        return ServiceResult.ok(name.trim());
    }

    public double getTotalAmount() {
        return donationDAO.getTotalAmount();
    }

    public int getTotalCount() {
        return donationDAO.getTotalCount();
    }

    public Map<String, Double> getAmountByPaymentMethod() {
        return donationDAO.getAmountByPaymentMethod();
    }

    public List<Donation> getRecentDonations(int limit) {
        return donationDAO.getRecentDonations(limit);
    }

    public List<Orphan> getActiveOrphansForDonateForm() {
        return orphanDAO.getActiveOrphansForPublic();
    }

    private static int parseOrphanId(String orphanParam) {
        if (orphanParam == null || orphanParam.isBlank()) {
            return 0;
        }
        try {
            return Integer.parseInt(orphanParam.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
