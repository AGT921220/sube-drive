

<?php $__env->startSection('content'); ?>
    <?php $currentDate = date('Y-m-d'); ?>
    <div class="content dashboard-content">
        <div class="container-fluid">
            <?php if(session('status')): ?>
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <?php echo e(session('status')); ?>

                </div>
            <?php endif; ?>

            <?php
                $metricIcons = [
                    'total_drivers' => 'ion-model-s',
                    'total_requested_drivers' => 'ion-person-add',
                    'total_active_drivers' => 'ion-checkmark-round',
                    'total_riders' => 'ion-person-stalker',
                    'today_new_riders' => 'ion-person-add',
                    'total_income' => 'ion-cash',
                    'total_revenue' => 'ion-social-usd',
                    'today_revenue' => 'ion-social-usd-outline',
                    'today_running_rides' => 'ion-android-bicycle',
                    'today_completed_rides' => 'ion-checkmark-circled',
                    'running_rides' => 'ion-load-d',
                    'completed_rides' => 'ion-checkmark-circled',
                    'cancelled_rides' => 'ion-close-circled',
                    'rejected_rides' => 'ion-close',
                ];
            ?>
            <div class="row">
                <?php $__currentLoopData = ['total_drivers', 'total_requested_drivers']; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $key): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>

                    <?php

                        $queryParams = match ($key) {
                            'total_active_drivers' => ['status' => '1'],
                            'total_requested_drivers' => ['host_status' => '2'],
                            default => [],
                        };
                    ?>
                    <div class="col-sm-6 col-md-3">
                        <div class="dashboard-card drivers-card text-center">
                            <i class="icon <?php echo e($metricIcons[$key] ?? 'ion-ios-analytics'); ?> fs-30"></i>
                            <h4><?php echo e(number_format($metrics[$key]['total_number'])); ?></h4>
                            <p><?php echo e(trans('dashboard.' . $key)); ?></p>
                            <a href="<?php echo e(route('admin.drivers.index', $queryParams)); ?>" class="card-link">
                                <?php echo e(trans('global.moreInfo')); ?> <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>


                <?php $__currentLoopData = ['total_riders']; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $key): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>

                    <?php
                        $queryParams = match ($key) {
                            'total_active_riders' => ['status' => '1'],
                            'today_new_riders' => ['from' => $currentDate, 'to' => $currentDate],
                            default => [],
                        };
                    ?>
                    <div class="col-sm-6 col-md-3">
                        <div class="dashboard-card drivers-card">
                            <i class="icon <?php echo e($metricIcons[$key] ?? 'ion-ios-analytics'); ?> fs-30"></i>
                            <h4><?php echo e(number_format($metrics[$key]['total_number'])); ?></h4>
                            <p><?php echo e(trans('dashboard.' . $key)); ?> </p>
                            <a href="<?php echo e(route('admin.app-users.index', $queryParams)); ?>" class="card-link">
                                <?php echo e(trans('global.moreInfo')); ?> <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                <?php $__currentLoopData = ['today_running_rides', 'today_completed_rides']; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $key): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                    <?php
                        $queryParams = match ($key) {
                            'completed_rides' => ['status' => 'completed'],
                            'running_rides' => ['status' => 'ongoing'],
                            'cancelled_rides' => ['status' => 'cancelled'],
                            'rejected_rides' => ['status' => 'rejected'],
                            'today_running_rides' => ['from' => $currentDate, 'to' => $currentDate],
                            'today_completed_rides' => ['from' => $currentDate, 'to' => $currentDate]
                        };
                    ?>
                    <div class="col-sm-6 col-md-3">
                        <div class="dashboard-card drivers-card">
                            <i class="icon <?php echo e($metricIcons[$key] ?? 'ion-ios-analytics'); ?> fs-30"></i>
                            <h4><?php echo e(number_format($metrics[$key]['total_number'])); ?></h4>
                            <p><?php echo e(trans('dashboard.' . $key)); ?></p>

                            <a href="<?php echo e(route('admin.bookings.index', $queryParams)); ?>" class="card-link">
                                <?php echo e(trans('global.moreInfo')); ?> <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                <?php $__currentLoopData = ['total_income', 'total_revenue', 'today_revenue']; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $key): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                    <?php
                        $queryParams = match ($key) {
                            'total_revenue' => [],
                            'today_revenue' => ['from' => $currentDate, 'to' => $currentDate],
                            'total_income' => [],
                        };
                    ?>
                    <div class="col-sm-6 col-md-3">
                        <div class="dashboard-card drivers-card">
                            <i class="icon <?php echo e($metricIcons[$key] ?? 'ion-ios-analytics'); ?> fs-30"></i>
                            <h4><?php echo e(number_format($metrics[$key]['total_number'], 2)); ?> <?php echo e(($currency->meta_value ?? '')); ?></h4>
                            <p><?php echo e(trans('dashboard.' . $key)); ?></p>

                            <a href="<?php echo e(route('admin.finance', $queryParams)); ?>" class="card-link">
                                <?php echo e(trans('global.moreInfo')); ?> <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div>
                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>


            </div>



            <div class="row">

                <div class="col-md-12">
                    <div class="panel panel-default dashboard-panel">
                        <div class="panel-heading clearfix">
                            <h4 class="pull-left"><?php echo e(trans('dashboard.latest_rides')); ?></h4>
                            <a href="<?php echo e(route('admin.bookings.index')); ?>" class="btn btn-sm btn-primary pull-right">
                                <?php echo e(__('See All')); ?>

                            </a>
                        </div>

                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped dashboard-table">
                                    <thead>
                                        <tr>
                                            <th><?php echo e(trans('dashboard.id')); ?></th>


                                            <th><?php echo e(trans('dashboard.ride_date')); ?></th>
                                            <th><?php echo e(trans('dashboard.driver')); ?></th>
                                            <th><?php echo e(trans('dashboard.rider')); ?></th>

                                            <th><?php echo e(trans('dashboard.total')); ?></th>
                                            <th><?php echo e(trans('dashboard.status')); ?></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $__empty_1 = true; $__currentLoopData = $latestBookings; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $entry): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
                                                                        <tr>
                                                                            <td>
                                                                                <a
                                                                                    href="<?php echo e(route('admin.bookings.show', $entry->id)); ?>"><?php echo e($entry->token); ?></a>
                                                                            </td>

                                                                            <td><?php echo e($entry->created_at ?? 'N/A'); ?></td>
                                                                            <td>


                                                                                <?php if($entry->host): ?>
                                                                                    <a target="_blank"
                                                                                        href="<?php echo e(route('admin.driver.profile', ['driver_id' => $entry->host->id])); ?>">
                                                                                        <?php if($entry->host->profile_image): ?>
                                                                                            <img src="<?php echo e($entry->host->profile_image->getUrl('thumb')); ?>"
                                                                                                alt="Profile Image" class="img-circle">
                                                                                        <?php else: ?>
                                                                                            <img src="<?php echo e(asset('images/icon/userdefault.jpg')); ?>" class="img-circle"
                                                                                                alt="Default Image" style="display: inline-block;">
                                                                                        <?php endif; ?>
                                                                                        <?php echo e($entry->host->first_name); ?> <?php echo e($entry->host->last_name); ?>

                                                                                    </a>
                                                                                <?php else: ?>
                                                                                    <span>--</span>
                                                                                <?php endif; ?>
                                                                            </td>
                                                                            <td>
                                                                                <?php if($entry->user): ?>
                                                                                    <a target="_blank"
                                                                                        href="<?php echo e(route('admin.app-users.show', $entry->user->id)); ?>">
                                                                                        <?php if($entry->user->profile_image): ?>
                                                                                            <img src="<?php echo e($entry->user->profile_image->getUrl('thumb')); ?>"
                                                                                                class="img-circle">
                                                                                        <?php else: ?>
                                                                                            <img src="<?php echo e(asset('images/icon/userdefault.jpg')); ?>"
                                                                                                alt="Default Image" style="display: inline-block;">
                                                                                        <?php endif; ?>
                                                                                        <?php echo e($entry->user->first_name ?? ''); ?>

                                                                                        <?php echo e($entry->user->last_name ?? ''); ?>

                                                                                    </a>
                                                                                <?php else: ?>
                                                                                    <span>--</span>
                                                                                <?php endif; ?>
                                                                            </td>
                                                                            <td><?php echo e(($currency->meta_value ?? '') . ' ' . ($entry->total ?? 'N/A')); ?></td>
                                                                            <td>
                                                                                <span class="badge
                                                                                                                                                                                                                                            <?php echo e($entry->status === 'Pending' ? 'badge-primary' :
                                            ($entry->status === 'Cancelled' ? 'badge-danger' :
                                                ($entry->status === 'Approved' ? 'badge-success' :
                                                    ($entry->status === 'Declined' ? 'badge-warning' :
                                                        ($entry->status === 'deps' ? 'admin' : 'badge-info'))))); ?>">
                                                                                    <?php echo e($entry->status ?? 'N/A'); ?>

                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
                                            <tr>
                                                <td colspan="6"><?php echo e(__('No entries found')); ?></td>
                                            </tr>
                                        <?php endif; ?>
                                    </tbody>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="row">
                <!-- Charts -->
                <div class="col-md-6">
                    <div class="panel panel-default dashboard-panel">
                        <div class="panel-heading">
                            <h4><?php echo e(trans('dashboard.latestUsers')); ?></h4>
                        </div>
                        <div class="panel-body">
                            <canvas id="chBarUsers" class="chart-canvas"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default dashboard-panel">
                        <div class="panel-heading">
                            <h4><?php echo e(trans('dashboard.latestBookings')); ?></h4>
                        </div>
                        <div class="panel-body">
                            <canvas id="chLine" class="chart-canvas"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<?php $__env->stopSection(); ?>



<?php $__env->startSection('scripts'); ?>
    <?php echo \Illuminate\View\Factory::parentPlaceholder('scripts'); ?>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <script>
        // Black family color palette
        const colors = {
            black: '#000000',
            darkGray: '#333333',
            gray: '#666666',
            lightGray: '#999999',
            gridLine: '#cccccc',
            backgroundLight: 'rgba(0, 0, 0, 0.05)',
            pointBackground: '#000000'
        };

        const latestUsersData = <?php echo json_encode($latestUsersData, 15, 512) ?>;
        const latestBookingsData = <?php echo json_encode($latestBookingsData, 15, 512) ?>;

        const labelsUsers = latestUsersData.map(record => record.date);
        const dataUsers = latestUsersData.map(record => record.count);

        const labelsBookings = latestBookingsData.map(record => record.date);
        const dataBookings = latestBookingsData.map(record => record.count);

        /* Bar chart for users */
        const chBarUsers = document.getElementById("chBarUsers");
        if (chBarUsers) {
            new Chart(chBarUsers, {
                type: 'bar',
                data: {
                    labels: labelsUsers,
                    datasets: [{
                        label: 'Users',
                        data: dataUsers,
                        backgroundColor: colors.darkGray,
                        borderColor: colors.black,
                        borderWidth: 1
                    }]
                },
                options: {
                    legend: { display: false },
                    scales: {
                        xAxes: [{
                            barPercentage: 0.4,
                            categoryPercentage: 0.5,
                            gridLines: { display: false },
                            ticks: { fontColor: colors.darkGray }
                        }],
                        yAxes: [{
                            ticks: { beginAtZero: true, fontColor: colors.darkGray },
                            gridLines: { color: colors.gridLine }
                        }]
                    },
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }

        /* Line chart for bookings */
        const chLine = document.getElementById("chLine");
        if (chLine) {
            new Chart(chLine, {
                type: 'line',
                data: {
                    labels: labelsBookings,
                    datasets: [{
                        data: dataBookings,
                        backgroundColor: colors.backgroundLight,
                        borderColor: colors.black,
                        borderWidth: 2,
                        pointBackgroundColor: colors.black,
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2
                    }]
                },
                options: {
                    legend: { display: false },
                    scales: {
                        xAxes: [{
                            gridLines: { display: false },
                            ticks: { fontColor: colors.darkGray }
                        }],
                        yAxes: [{
                            ticks: { beginAtZero: true, fontColor: colors.darkGray },
                            gridLines: { color: colors.gridLine }
                        }]
                    },
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }

        /* Status toggle AJAX */
        $('.statusdata').change(function () {
            const status = $(this).prop('checked') ? 1 : 0;
            const id = $(this).data('id');
            const $toggle = $(this);
            const requestData = {
                status: status,
                pid: id,
                _token: $('meta[name="csrf-token"]').attr('content')
            };

            $.ajax({
                type: "POST",
                dataType: "json",
                url: '/admin/update-item-status',
                data: requestData,
                success: function (response) {
                    if (response.status === 200) {
                        toastr.success(response.message, '<?php echo e(trans("global.success")); ?>', {
                            CloseButton: true,
                            ProgressBar: true,
                            positionClass: "toast-bottom-right"
                        });
                    } else {
                        toastr.error(response.message, 'Cannot update', {
                            CloseButton: true,
                            ProgressBar: true,
                            positionClass: "toast-bottom-right"
                        });
                        $toggle.prop('checked', !status);
                    }
                },
                error: function () {
                    toastr.error('Something went wrong. Please try again.', '<?php echo e(trans("global.error")); ?>', {
                        CloseButton: true,
                        ProgressBar: true,
                        positionClass: "toast-bottom-right"
                    });
                    $toggle.prop('checked', !status);
                }
            });
        });
    </script>
    
      <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            }
        }
    </script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layouts.admin', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/unibooker-rideon-code/htdocs/rideon-code.unibooker.app/resources/views/home.blade.php ENDPATH**/ ?>