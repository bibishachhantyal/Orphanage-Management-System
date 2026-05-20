<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Donation Report</title><link rel="stylesheet" href="../css/styles.css"></head>
<body>
<div class="container">
    <h2>Donation Summary Report</h2>
    <p><strong>Total Donations:</strong> ${totalDonations}</p>
    <p><strong>Total Amount:</strong> NRs. ${totalAmount}</p>
    <a href="${pageContext.request.contextPath}/donation/list">Back to Donations</a>
</div>
</body>
</html>