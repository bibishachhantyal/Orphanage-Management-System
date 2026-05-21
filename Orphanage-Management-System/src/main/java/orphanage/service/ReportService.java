package orphanage.service;

import orphanage.dao.DonationDAO;
import orphanage.dao.OrphanDAO;
import orphanage.dao.VolunteerApplicationDAO;
import orphanage.dao.VolunteerDAO;
import orphanage.model.Donation;

import java.util.List;
import java.util.Map;

public class ReportService {
    private final DonationDAO donationDAO = new DonationDAO();
    private final OrphanDAO orphanDAO = new OrphanDAO();
    private final VolunteerDAO volunteerDAO = new VolunteerDAO();
    private final VolunteerApplicationDAO applicationDAO = new VolunteerApplicationDAO();

    public double getTotalDonationAmount() {
        return donationDAO.getTotalAmount();
    }

    public int getTotalDonationCount() {
        return donationDAO.getTotalCount();
    }

    public Map<String, Double> getDonationByPaymentMethod() {
        return donationDAO.getAmountByPaymentMethod();
    }

    public List<Donation> getRecentDonations(int limit) {
        return donationDAO.getRecentDonations(limit);
    }

    public Map<String, Integer> getOrphanStatusCounts() {
        return orphanDAO.getCountByStatus();
    }

    public int getOrphanTotal() {
        Map<String, Integer> counts = orphanDAO.getCountByStatus();
        return counts.values().stream().mapToInt(Integer::intValue).sum();
    }

    public Map<String, Integer> getVolunteerStatusCounts() {
        return volunteerDAO.getCountByStatus();
    }

    public int getPendingVolunteerApplications() {
        return applicationDAO.findPending().size();
    }

    public int chartMax(Map<String, ? extends Number> values) {
        int max = 1;
        for (Number n : values.values()) {
            max = Math.max(max, n.intValue());
        }
        return max;
    }
}
