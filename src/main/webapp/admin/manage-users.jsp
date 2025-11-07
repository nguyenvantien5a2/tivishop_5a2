<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@include file="headeradmin.jsp"%>
<html>
<head>
    <title>Quản lý Người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="../css/admin-style.css" rel="stylesheet">
    <style>
        .role-admin { color: #dc3545 !important; font-weight: bold; }
        .role-user { color: #007bff !important; font-weight: bold; }
        .password-toggle { position: relative; }
        .password-toggle .toggle-icon { 
            position: absolute; 
            right: 10px; 
            top: 73%; 
            transform: translateY(-50%); 
            cursor: pointer; 
        }
        .table th,.table td{text-align:center;}
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-5" style="color: #007bff;"><i class="fas fa-users me-1"></i> Quản lý Người dùng</h1>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#userModal" onclick="resetForm()">
            <i class="fas fa-plus me-1"></i> Thêm Người dùng
        </button>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr><th>ID</th><th>Username</th><th>Email</th><th>Họ tên</th><th>Quyền</th><th>Thao tác</th></tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.username}</td>
                        <td>${u.email}</td>
                        <td>${u.fullName}</td>
                        <td class="role-${u.role.toLowerCase().trim()}">${u.role}</td>
                        <td>
                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#userModal"
                                    onclick="fillEditForm(${u.id}, '${u.username}', '${u.email}', '${u.fullName}', '${u.role}', '${u.password}')">
                                <i class="fas fa-edit"></i> Sửa
                            </button>
                            <form action="${pageContext.request.contextPath}/admin/userss" method="post" class="d-inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${u.id}">
                                <button type="submit" class="btn btn-sm btn-danger" 
                                        onclick="return confirm('Bạn có chắc muốn xóa người dùng ${u.username}?')">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Modal for Add/Edit User -->
        <div class="modal fade" id="userModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">Thêm Người dùng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="userForm" action="${pageContext.request.contextPath}/admin/userss" method="post">
                            <input type="hidden" name="action" id="formAction" value="add">
                            <input type="hidden" name="id" id="userId">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="username" id="username" required>
                            </div>
                            <div class="mb-3 password-toggle">
                                <label class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" name="password" id="password" required>
                                <i class="fas fa-eye toggle-icon" id="togglePassword"></i>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" id="email" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Họ tên</label>
                                <input type="text" class="form-control" name="fullName" id="fullName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Quyền</label>
                                <select class="form-select" name="role" id="role">
                                    <option value="USER">Người dùng</option>
                                    <option value="ADMIN">Quản trị viên</option>
                                </select>
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
        function resetForm() {
            document.getElementById('modalTitle').innerText = 'Thêm Người dùng';
            document.getElementById('formAction').value = 'add';
            document.getElementById('userForm').reset();
            document.getElementById('userId').value = '';
            document.getElementById('password').setAttribute('required', 'required');
            document.getElementById('togglePassword').classList.remove('fa-eye-slash');
            document.getElementById('togglePassword').classList.add('fa-eye');
        }

        function fillEditForm(id, username, email, fullName, role, password) {
            document.getElementById('modalTitle').innerText = 'Sửa Người dùng';
            document.getElementById('formAction').value = 'update';
            document.getElementById('userId').value = id;
            document.getElementById('username').value = username;
            document.getElementById('email').value = email;
            document.getElementById('fullName').value = fullName;
            document.getElementById('role').value = role;
            document.getElementById('password').value = password || '';
            document.getElementById('password').removeAttribute('required');
            document.getElementById('togglePassword').classList.remove('fa-eye-slash');
            document.getElementById('togglePassword').classList.add('fa-eye');
        }

        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const icon = this;
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    </script>
</body>
</html>