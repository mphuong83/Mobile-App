// Show order details modal
document.querySelectorAll(".view-button").forEach(button => {
    button.addEventListener("click", function() {
        document.getElementById("modal").style.display = "block";
    });
});

// Close the modal
document.querySelector(".close-button").addEventListener("click", function() {
    document.getElementById("modal").style.display = "none";
});

// Close the modal when clicking outside of it
window.onclick = function(event) {
    if (event.target == document.getElementById("modal")) {
        document.getElementById("modal").style.display = "none";
    }
};

// Confirm order
document.querySelectorAll(".confirm-button").forEach(button => {
    button.addEventListener("click", function() {
        alert("Order has been confirmed! Status updated to 'Processing'.");
        // Code to update order status here
    });
});

// Cancel order
document.querySelectorAll(".cancel-button").forEach(button => {
    button.addEventListener("click", function() {
        if (confirm("Are you sure you want to cancel this order?")) {
            alert("Order has been canceled! Status updated to 'Canceled'.");
            // Code to update order status here
        }
    });
});

// Deliver order
document.querySelectorAll(".deliver-button").forEach(button => {
    button.addEventListener("click", function() {
        alert("Order is marked for delivery! Status updated to 'Delivering'.");
        // Code to update order status here
    });
});