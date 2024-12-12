<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
    <link rel="stylesheet" href="{{ asset('css/style.order.css') }}">
    <script src="{{ asset('js/script.order.js') }}"></script>
</head>
<body>
    <div class="container">
        <h1>Quản lý Đơn Hàng</h1>
        <div class="order-list">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Name</th>
                        <th>Phone Number</th>
                        <th>Address</th>
                        <th>Ordered Items</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>The Huy</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Minh Phuong</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Huong Giang</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>Duc Viet</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>Duc Vinh</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>Thanh Huong</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr><tr>
                        <td>7</td>
                        <td>Duc Khai</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr><tr>
                        <td>8</td>
                        <td>My Hanh</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr><tr>
                        <td>9</td>
                        <td>Thuy</td>
                        <td>0987654321</td>
                        <td>Phenikaa, Yen Nghia, Ha Dong</td>
                        <td>Bún chả, Bún cá, Bún riêu cua</td>
                        <td>Pending</td>
                        <td>
                            <button class="view-button">View</button>
                            <button class="confirm-button">Confirm</button>
                            <button class="cancel-button">Cancel</button>
                            <button class="deliver-button">Deliver</button>
                        </td>
                    </tr>
                    <!-- Repeat rows for other orders as needed -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal for Order Details -->
    <div class="modal" id="modal">
        <div class="modal-content">
            <span class="close-button">&times;</span>
            <h2>Order Details</h2>
            <p><strong>Customer:</strong> John Doe</p>
            <p><strong>Phone Number:</strong> 123-456-7890</p>
            <p><strong>Address:</strong> 123 Main St, City</p>
            <p><strong>Status:</strong> Pending</p>
            <p><strong>Ordered Items:</strong></p>
            <ul>
                <li>Beef Pho - 2 servings</li>
                <li>Bun Cha - 1 serving</li>
                <li>Spring Rolls - 3 servings</li>
            </ul>
        </div>
    </div>

</body>
</html>
