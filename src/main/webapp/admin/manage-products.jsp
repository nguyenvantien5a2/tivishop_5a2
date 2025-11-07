<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@include file="headeradmin.jsp"%>
<html>
<head>
    <title>Quản lý Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="../css/admin-style.css" rel="stylesheet">
    <style>
        .thumbnail-img {
            width: auto;
            height: 60px;
            object-fit: cover;
            margin-right: 5px;
            border-radius: 5px;
        }
        .image-preview {
            width: auto;
            height: 86px;
            margin: 5px;
            border-radius: 5px;
        }
        .images-container {
            display: flex;
            flex-wrap: wrap;
        }
        .modal-content {
            background-color: #fff;
            border-radius: 0.3rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .modal-backdrop {
            opacity: 0.5 !important;
        }
        body.modal-open {
            overflow: auto !important;
            padding-right: 0 !important;
        }
        .table th, .table td { text-align: center; }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-5" style="color: #007bff;"><i class="fa-solid fa-tv"></i> Quản lý Sản phẩm</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#productModal" onclick="resetForm()">
            <i class="fas fa-plus me-1"></i> Thêm Sản phẩm
        </button>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr><th>ID</th><th>Tên sản phẩm</th><th>Hình ảnh</th><th>Giá gốc</th><th>Giá sau giảm</th><th>TH</th><th>SL</th><th>Thao tác</th></tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.name}</td>
                        <td>
                            <img src="${pageContext.request.contextPath}/images/${p.image}" class="thumbnail-img" alt="${p.name}" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                            <button class="btn btn-sm btn-info" data-bs-toggle="modal"
                                    data-bs-target="#imageModal${p.id}">
                                <i class="fas fa-images"></i> Xem
                            </button>
                            <div class="modal fade" id="imageModal${p.id}" tabindex="-1" aria-labelledby="imageModalLabel${p.id}" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="imageModalLabel${p.id}">Hình ảnh của ${p.name}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="images-container">
                                                <img src="${pageContext.request.contextPath}/images/${p.image}" class="image-preview" alt="Main Image" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                                                <c:forEach var="img" items="${p.images}">
                                                    <img src="${pageContext.request.contextPath}/images/${img}" class="image-preview" alt="Additional Image" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg'">
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td><fmt:formatNumber value="${p.originalPrice}" pattern="#,##0" /> VND</td>
                        <td><fmt:formatNumber value="${p.price}" pattern="#,##0" /> VND</td>
                        <td>${p.brand}</td>
                        <td>${p.quantity}</td>
                        <td>
                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#productModal"
                                    onclick="fillEditForm(${p.id}, '${p.name.replace("'", "\\'")}', ${p.price}, ${p.originalPrice}, '${p.description != null ? p.description.replace("'", "\\'") : ''}', '${p.image != null ? p.image.replace("'", "\\'") : ''}', '${p.imagesString != null ? p.imagesString.replace("'", "\\'") : ''}', ${p.quantity}, '${p.brand != null ? p.brand.replace("'", "\\'") : ''}')">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <form action="${pageContext.request.contextPath}/admin/productss" method="post" class="d-inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="btn btn-sm btn-danger"
                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm ${p.name.replace("'", "\\'")}?')">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="productModalLabel">Thêm Sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="productForm" action="${pageContext.request.contextPath}/admin/productss" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" id="formAction" value="add">
                            <input type="hidden" name="id" id="productId">
                            <div class="mb-3">
                                <label class="form-label">Tên</label>
                                <input type="text" class="form-control" name="name" id="name" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá gốc</label>
                                <input type="number" class="form-control" name="originalPrice" id="originalPrice" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá sau giảm</label>
                                <input type="number" class="form-control" name="price" id="price" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" id="description"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Hình ảnh chính</label>
                                <input type="file" class="form-control" name="image" id="image" accept="image/jpeg,image/png" onchange="previewImage(event, 'imagePreview')">
                                <img id="imagePreview" class="image-preview mt-2" style="display:none;">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Danh sách hình ảnh phụ</label>
                                <input type="file" class="form-control" name="images" id="images" accept="image/jpeg,image/png" multiple onchange="previewImages(event, 'imagesPreview')">
                                <div id="imagesPreview" class="images-container mt-2"></div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tồn kho</label>
                                <input type="number" class="form-control" name="quantity" id="quantity" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Thương hiệu</label>
                                <input type="text" class="form-control" name="brand" id="brand">
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function fillEditForm(id, name, price, originalPrice, description, image, images, quantity, brand) {
            document.getElementById('productModalLabel').innerText = 'Sửa Sản phẩm';
            document.getElementById('formAction').value = 'update';
            document.getElementById('productId').value = id;
            document.getElementById('name').value = name;
            document.getElementById('price').value = price;
            document.getElementById('originalPrice').value = originalPrice;
            document.getElementById('description').value = description;
            document.getElementById('image').value = '';
            document.getElementById('imagePreview').src = '${pageContext.request.contextPath}/images/' + image;
            document.getElementById('imagePreview').style.display = 'block';
            document.getElementById('images').value = '';
            const imagesPreview = document.getElementById('imagesPreview');
            imagesPreview.innerHTML = '';
            images.split(',').forEach(img => {
                if (img) {
                    const imgElement = document.createElement('img');
                    imgElement.src = '${pageContext.request.contextPath}/images/' + img;
                    imgElement.className = 'image-preview';
                    imagesPreview.appendChild(imgElement);
                }
            });
            document.getElementById('quantity').value = quantity;
            document.getElementById('brand').value = brand;
            new bootstrap.Modal(document.getElementById('productModal')).show();
        }
        function resetForm() {
            document.getElementById('productModalLabel').innerText = 'Thêm Sản phẩm';
            document.getElementById('formAction').value = 'add';
            document.getElementById('productForm').reset();
            document.getElementById('productId').value = '';
            document.getElementById('imagePreview').style.display = 'none';
            document.getElementById('imagePreview').src = '';
            document.getElementById('imagesPreview').innerHTML = '';
        }
        function previewImage(event, previewId) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById(previewId);
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        }
        function previewImages(event, previewId) {
            const files = event.target.files;
            const previewContainer = document.getElementById(previewId);
            previewContainer.innerHTML = '';
            for (let file of files) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.className = 'image-preview';
                    previewContainer.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        }
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            modal.addEventListener('hidden.bs.modal', function () {
                document.querySelectorAll('.modal-backdrop').forEach(backdrop => backdrop.remove());
                document.body.classList.remove('modal-open');
                document.body.style.overflow = '';
                document.body.style.paddingRight = '';
            });
        });
    </script>
</body>
</html>