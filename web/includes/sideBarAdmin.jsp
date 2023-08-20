
<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="../../index3.html" class="brand-link">
        <img src="dist/img/seeker.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">The Jobs</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">

        <!-- SidebarSearch Form -->
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
                     with font-awesome or any other icon font library -->
                <li class="nav-item">
                    <a href="#" class="nav-link">

                        <i class="nav-icon fa-solid fa-user-tie"></i>
                        <p>
                            Consultants
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="consultant.jsp" class="nav-link <%= request.getRequestURI().endsWith("consultant.jsp") ? "active" : "" %>">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Manage consultants</p>
                            </a>
                        </li>

                    </ul>
                </li>
                
                 <li class="nav-item">
                    <a href="#" class="nav-link">

                        <i class="nav-icon fa-regular fa-user"></i>
                        <p>
                            Receptionist
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="receptionist.jsp" class="nav-link <%= request.getRequestURI().endsWith("receptionist.jsp") ? "active" : "" %>">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Manage Receptionist</p>
                            </a>
                        </li>

                    </ul>
                </li>
                
                <li class="nav-item">
                    <a href="#" class="nav-link">

                        <i class="nav-icon fa-regular fa-file"></i>
                        <p>
                            Reports
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Report 1</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Report 2</p>
                            </a>
                        </li>

                    </ul>
                </li>
                
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
