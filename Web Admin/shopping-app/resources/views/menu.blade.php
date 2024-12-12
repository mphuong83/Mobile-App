<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý thực đơn</title>
    <link rel="stylesheet" href="{{ asset('css/style.css') }}">
<script src="{{ asset('js/script.js') }}"></script>
</head>
<body>
    <div class="container">
        <h1>Quản lý thực đơn</h1>
        <div class="actions">
            <button class="add-button">+ Add Dish</button>
            <button class="export-button">Export</button>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Dish ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Sold Quantity</th> <!-- Thêm tiêu đề cột Số lượng đã bán -->
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Example dish entry -->
                <tr>
                    <td><input type="checkbox"></td>
                    <td>1</td>
                    <td>Phở Bò</td>
                    <td>Delicious Vietnamese beef noodle soup</td>
                    <td>40.00₫</td>
                    <td>20</td>
                    <td>15</td> <!-- Thêm số lượng đã bán -->
                    <td>
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>2</td>
                    <td>Bún đậu mắm tôm</td>
                    <td>Flavorful Vietnamese vermicelli with fried tofu, herbs, and shrimp paste.</td>
                    <td>30.00₫</td>
                    <td>10</td>
                    <td>5</td> <!-- Thêm số lượng đã bán -->
                    <td>
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>1</td>
                    <td>Bún cá</td>
                    <td>Light and savory Vietnamese fish noodle soup with fresh herbs.</td>
                    <td>35.00₫</td>
                    <td>30</td>
                    <td>20</td>
                    <td>
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>1</td>
                    <td>Bún riêu cua</td>
                    <td>Tangy Vietnamese crab noodle soup with tomato and herbs.</td>
                    <td>40.00₫</td>
                    <td>10</td>
                     <td>5</td>
                    <td>
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>1</td>
                    <td>Bún bò Huế</td>
                    <td>Spicy Vietnamese beef noodle soup from Hue, rich and aromatic.</td>
                    <td>35.00₫</td>
                    <td>5</td>
                     <td>45</td>
                    <td>
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox"></td>
                    <td>1</td>
                    <td>Bánh mì chảo</td>
                    <td>Sizzling Vietnamese pan bread with eggs, sausage, and meats.</td>
                    <td>20.00₫</td>
                    <td>8</td>
                     <td>52</td>
                    <td>
                        <button class="edit-button">Edit</button>
                        <button class="delete-button">Delete</button>
                    </td>
                </tr>
                <!-- Thêm các món ăn khác -->
            </tbody>
        </table>
    </div>

    <!-- Modal for Add/Edit Dish -->
    <div class="modal" id="modal">
        <div class="modal-content">
            <span class="close-button">&times;</span>
            <h2>Add/Edit Dish</h2>
            <form>
                <label for="name">Dish Name:</label>
                <input type="text" id="name" required>

                <label for="description">Description:</label>
                <textarea id="description" required></textarea>

                <label for="price">Price:</label>
                <input type="number" id="price" required>

                <label for="quantity">Stock Quantity:</label>
                <input type="number" id="quantity" required>

                <label for="soldQuantity">Sold Quantity:</label> <!-- Thêm trường nhập Số lượng đã bán -->
                <input type="number" id="soldQuantity" required>

                <button type="submit" class="save-button">Save</button>
            </form>
        </div>
    </div>
</body>
</html>
