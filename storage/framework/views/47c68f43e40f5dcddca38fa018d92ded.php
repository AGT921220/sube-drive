<aside class="main-sidebar">
    <section class="sidebar" style="height: auto;">
        <ul class="sidebar-menu tree" data-widget="tree">
            <li class="<?php echo e(request()->is('admin') ? 'active' : ''); ?>">
                <a href="<?php echo e(route('admin.home')); ?>">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span> <?php echo e(trans('menu.dashboard')); ?> </span>
                </a>
            </li>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('user_management_access')): ?>
                <li class="treeview">
                    <a href="#">
                        <i class="fa-fw fas fa-users"></i>
                        <span> <?php echo e(trans('menu.adminManagement')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('permission_access')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/permissions') || request()->is('admin/permissions/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.permissions.index')); ?>">
                                    <i class="fa-fw fas fa-unlock-alt"></i>
                                    <span><?php echo e(trans('menu.permission_title')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('role_access')): ?>
                            <li class="<?php echo e(request()->is('admin/roles') || request()->is('admin/roles/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.roles.index')); ?>">
                                    <i class="fa-fw fas fa-briefcase"></i>
                                    <span><?php echo e(trans('menu.role_title')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('user_access')): ?>
                            <li class="<?php echo e(request()->is('admin/users') || request()->is('admin/users/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.users.index')); ?>">
                                    <i class="fa-fw fas fa-user"></i>
                                    <span><?php echo e(trans('menu.user_title')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </li>
            <?php endif; ?>
            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vehicle_setting_access')): ?>
                <li class="treeview">
                    <a href="#">
                        <i class="fa-fw fas fa-car"></i>
                        <span><?php echo e(trans('menu.platform_setup')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">

                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vehicle_type_access')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/vehicle-type') || request()->is('admin/vehicle-type/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.vehicle-type.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.vehicle_type')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>

                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vehicle_location_access')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/vehicle-location') || request()->is('admin/vehicle-location/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.vehicle-location.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.vehicle_location')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>

                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('vehicle_makes_access')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/vehicle-makes') || request()->is('admin/vehicle-makes/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.vehicle-makes.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.vehicle_makes')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>


                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('cancellation_access')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/cancellation') || request()->is('admin/cancellation /*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.cancellation.index')); ?>">
                                    <i class='fas fa-dot-circle'></i>
                                    <span><?php echo e(trans('menu.cancellationReason_title')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('item_rule')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/item-rule') || request()->is('admin/item-rule/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.item-rule.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.item_rule')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </li>

            <?php endif; ?>
            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('front_management_access')): ?>
                <li class="treeview">
                    <a href="#">
                        <i class="fa-fw fas fa-users"></i>
                        <span><?php echo e(trans('menu.driverManagement')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('app_user_access')): ?>
                            <li
                                class="<?php echo e((request()->is('admin/drivers') || request()->is('admin/driver/*') || request()->is('admin/drivers/*')) && !request()->has('status') && !request()->has('host_status') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.drivers.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.driver')); ?> <?php echo e(trans('menu.list')); ?></span>
                                </a>
                            </li>

                            <li
                                class="<?php echo e((request()->is('admin/drivers') || request()->is('admin/drivers/*')) && request()->input('status') === '1' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.drivers.index', ['status' => '1'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.active')); ?> <?php echo e(trans('menu.drivers')); ?></span>
                                </a>
                            </li>

                            <li
                                class="<?php echo e((request()->is('admin/drivers') || request()->is('admin/drivers/*')) && request()->input('status') === '0' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.drivers.index', ['status' => '0'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.inactive')); ?> <?php echo e(trans('menu.drivers')); ?></span>
                                </a>
                            </li>

                            <li
                                class="<?php echo e((request()->is('admin/drivers') || request()->is('admin/drivers/*')) && request()->input('host_status') === '2' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.drivers.index', ['host_status' => '2'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.requested')); ?> <?php echo e(trans('menu.drivers')); ?></span>
                                </a>
                            </li>

                        <?php endif; ?>
                    </ul>
                </li>
            <?php endif; ?>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('front_management_access')): ?>
                <li class="treeview">
                    <a href="#">
                        <i class="fa-fw fas fa-users"></i>
                        <span><?php echo e(trans('menu.riderManagement')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('app_user_access')): ?>
                            <li
                                class="<?php echo e((request()->is('admin/app-users') || request()->is('admin/app-users/*')) ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.app-users.index', ['user_type' => 'user'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.riders')); ?> <?php echo e(trans('menu.list')); ?></span>
                                </a>
                            </li>
                            <li
                                class="<?php echo e(request()->is('admin/app-users') && request()->input('status') == '1' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.app-users.index', ['user_type' => 'user', 'status' => '1'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.active')); ?> <?php echo e(trans('menu.riders')); ?></span>
                                </a>
                            </li>
                            <li
                                class="<?php echo e(request()->is('admin/app-users') && request()->input('status') == '0' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.app-users.index', ['user_type' => 'user', 'status' => '0'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.inactive')); ?> <?php echo e(trans('menu.riders')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </li>
            <?php endif; ?>



            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('booking_access')): ?>
                <li class="treeview <?php echo e(request()->is('admin/bookings*') ? 'active' : ''); ?>">
                    <a href="#">
                        <i class="far fa-calendar-alt"></i>
                        <span><?php echo e(trans('menu.manage_rides')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <li class="<?php echo e(request()->is('admin/bookings') && !request()->query('status') ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.index')); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_list')); ?></span>
                            </a>
                        </li>

                        <li
                            class="<?php echo e(request()->is('admin/bookings') && request()->query('status') === 'accepted' ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.index', ['status' => 'accepted'])); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_accepted')); ?> </span>
                            </a>
                        </li>

                        <li
                            class="<?php echo e(request()->is('admin/bookings') && request()->query('status') === 'ongoing' ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.index', ['status' => 'ongoing'])); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_running')); ?></span>
                            </a>
                        </li>

                        <li
                            class="<?php echo e(request()->is('admin/bookings') && request()->query('status') === 'cancelled' ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.index', ['status' => 'cancelled'])); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_cancelled')); ?></span>
                            </a>
                        </li>

                        <li
                            class="<?php echo e(request()->is('admin/bookings') && request()->query('status') === 'rejected' ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.index', ['status' => 'rejected'])); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_rejected')); ?></span>
                            </a>
                        </li>

                        <li
                            class="<?php echo e(request()->is('admin/bookings') && request()->query('status') === 'completed' ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.index', ['status' => 'completed'])); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_completed')); ?></span>
                            </a>
                        </li>

                        <li class="<?php echo e(request()->routeIs('admin.bookings.trash') ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.bookings.trash')); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.booking_trash')); ?></span>
                            </a>
                        </li>
                    </ul>
                </li>
            <?php endif; ?>



            <!-- <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('package_access')): ?>
                <li class="treeview">
                    <a href="#">
                        <i class="fa-fw fas fa-gift"></i>
                        <span><?php echo e(trans('menu.package_title')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('all_package_access')): ?>
                            <li class="<?php echo e(request()->is('admin/all-packages/create') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.all-packages.create')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.add')); ?> <?php echo e(trans('menu.allPackage_title_singular')); ?></span>
                                </a>
                            </li>
                            <li class="<?php echo e(request()->is('admin/all-packages') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.all-packages.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.allPackage_title')); ?> <?php echo e(trans('menu.list')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </li>
            <?php endif; ?>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('coupon_access')): ?>
                <li class="treeview">
                    <a href="#">
                        <i class="fa-fw fas fa-ticket-alt"></i>
                        <span><?php echo e(trans('menu.coupon_title')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('add_coupon_access')): ?>
                            <li class="<?php echo e(request()->is('admin/add-coupons/create') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.add-coupons.create')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.add')); ?> <?php echo e(trans('menu.addCoupon_title')); ?></span>
                                </a>
                            </li>
                            <li class="<?php echo e(request()->is('admin/add-coupons') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.add-coupons.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.addCoupon_title')); ?> <?php echo e(trans('menu.list')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                    </ul>
                </li>
            <?php endif; ?>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('contact_access')): ?>
                <li class="<?php echo e(request()->is('admin/contacts') || request()->is('admin/contacts/*') ? 'active' : ''); ?>">
                    <a href="<?php echo e(route('admin.contacts.index')); ?>">
                        <i class="fa-fw far fa-calendar-check"></i>
                        <span><?php echo e(trans('menu.contactus_title')); ?></span>
                    </a>
                </li>
            <?php endif; ?>
 -->





            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('transactions_reports_access')): ?>
                <li
                    class="treeview <?php echo e(request()->is('admin/payouts*') || request()->is('admin/finance*') ? 'active' : ''); ?>">
                    <a href="#">
                        <i class="fa-fw fas fa-users"></i>
                        <span><?php echo e(trans('menu.transactions_reports')); ?></span>
                        <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                    </a>
                    <ul class="treeview-menu">
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('finance_access')): ?>
                            <li class="<?php echo e(request()->is('admin/finance') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.finance')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.finance')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>

                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('payout_access')): ?>
                            <li
                                class="<?php echo e(request()->is('admin/payouts') || request()->is('admin/payouts/*') ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.payouts.index')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.all_withdrawals')); ?></span>
                                </a>
                            </li>
                            <li class="<?php echo e(request('status') === 'Success' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.payouts.index', ['status' => 'Success'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.approved_withdrawals')); ?></span>
                                </a>
                            </li>

                            <li class="<?php echo e(request('status') === 'Pending' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.payouts.index', ['status' => 'Pending'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.pending_withdrawals')); ?></span>
                                </a>
                            </li>

                            <li class="<?php echo e(request('status') === 'Rejected' ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.payouts.index', ['status' => 'Rejected'])); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.rejected_withdrawals')); ?></span>
                                </a>
                            </li>

                        <?php endif; ?>
                    </ul>
                </li>
            <?php endif; ?>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('review_access')): ?>
                <li class="<?php echo e(request()->is('admin/reviews') || request()->is('admin/reviews/*') ? 'active' : ''); ?>">
                    <a href="<?php echo e(route('admin.reviews.index')); ?>">
                        <i class="fa-fw fas fa-eye-dropper"></i>
                        <span><?php echo e(trans('menu.review_title')); ?></span>
                    </a>
                </li>
            <?php endif; ?>

            <!-- Settings -->
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-list-alt"></i>
                    <span><?php echo e(trans('menu.settings')); ?></span>
                    <span class="pull-right-container"><i class="fa fa-fw fa-angle-left pull-right"></i></span>
                </a>
                <ul class="treeview-menu">
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('all_general_setting_access')): ?>
                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('general_setting_access')): ?>
                            <?php
                                $settingsRoutes = [
                                    'admin.settings',
                                    'admin.sms',
                                    'admin.email',
                                    'admin.pushnotification',
                                    'admin.fees',
                                    'admin.api-informations',
                                    'admin.paypal',
                                    'admin.social-logins',
                                    'admin.twillio',
                                    'admin.stripe',
                                    'admin.payment-methods',
                                ];
                                $isActive = in_array(Route::currentRouteName(), $settingsRoutes) || request()->is('admin/general-settings/*');
                            ?>
                            <li class="<?php echo e($isActive ? 'active' : ''); ?>">
                                <a href="<?php echo e(route('admin.settings')); ?>">
                                    <i class="fas fa-dot-circle"></i>
                                    <span><?php echo e(trans('menu.generalSetting_title')); ?></span>
                                </a>
                            </li>
                        <?php endif; ?>
                    <?php endif; ?>
                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('sliders_access')): ?>
                        <li class="<?php echo e(request()->is('admin/sliders') ? 'active' : ''); ?>" style="display: none;">
                            <a href="<?php echo e(route('admin.sliders.index')); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.slider_title')); ?></span>
                            </a>
                        </li>
                    <?php endif; ?>

                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('static_page_access')): ?>
                        <li
                            class="<?php echo e(request()->is('admin/static-pages') || request()->is('admin/static-pages/*') ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.static-pages.index')); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.staticPage_title')); ?></span>
                            </a>
                        </li>
                    <?php endif; ?>

                    <!-- <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('currency_access')): ?>
                        <li
                            class="<?php echo e(request()->is('admin/currency') || request()->is('admin/currency/*') ? 'active' : ''); ?>">
                            <a href="<?php echo e(route('admin.currency')); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span>Currency</span>
                            </a>
                        </li>
                    <?php endif; ?> -->

                    <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('email_access')): ?>
                        <li
                            class="<?php echo e(request()->is('user/email-templates') || request()->is('user/email-templates/*') ? 'active' : ''); ?>">

                            <a href="<?php echo e(route('user.email-templates', ['id' => 1])); ?>">
                                <i class="fas fa-dot-circle"></i>
                                <span><?php echo e(trans('menu.emailTemplate_title')); ?></span>
                            </a>
                        </li>
                    <?php endif; ?>
                </ul>
            </li>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('support_ticket')): ?>
                <li class="<?php echo e(request()->is('admin/ticket') || request()->is('admin/ticket /*') ? 'active' : ''); ?>">
                    <a href="<?php echo e(route('admin.ticket.index', ['status' => 1])); ?>" style="display: none;">
                        <i class="fa fa-ticket" aria-hidden="true"></i>
                        <span><?php echo e(trans('menu.tickets_title')); ?></span>
                    </a>
                </li>
            <?php endif; ?>

            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('reports_access')): ?>
                <li style="display:none"
                    class="<?php echo e(request()->is('admin/report-page') || request()->is('admin/report-page/*') ? 'active' : ''); ?>">
                    <a href="<?php echo e(route('admin.report-page.index')); ?>">
                        <i class="fa fa-file" aria-hidden="true"></i>
                        <span>Reports</span>
                    </a>
                </li>
            <?php endif; ?>

            <?php if(file_exists(app_path('Http/Controllers/Auth/ChangePasswordController.php'))): ?>
                <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('profile_password_edit')): ?>
                    <li class="<?php echo e(request()->is('profile/password') || request()->is('profile/password/*') ? 'active' : ''); ?>">
                        <a href="<?php echo e(route('profile.password.edit')); ?>">
                            <i class="fa-fw fas fa-key"></i>
                            <span><?php echo e(trans('menu.change_password')); ?></span>
                        </a>
                    </li>
                <?php endif; ?>
            <?php endif; ?>

            <li>
                <a href="#" onclick="event.preventDefault(); document.getElementById('logoutform').submit();">
                    <i class="fas fa-fw fa-sign-out-alt"></i>
                    <span><?php echo e(trans('menu.logout')); ?></span>
                </a>
            </li>
        </ul>
    </section>
</aside><?php /**PATH /home/unibooker-rideon-code/htdocs/rideon-code.unibooker.app/resources/views/partials/menu.blade.php ENDPATH**/ ?>