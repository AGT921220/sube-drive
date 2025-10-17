<ul class="nav navbar-pills nav-tabs nav-stacked no-margin" role="tablist">
    <li class="<?php echo e(request()->routeIs('admin.settings') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.settings')); ?>" data-group="profile"><?php echo e(trans('global.general_title')); ?></a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.project_setup') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.project_setup')); ?>" data-group="profile"><?php echo e(trans('global.project_setup')); ?></a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.preferences') ? 'active' : ''); ?>" style=" display: none ">
        <a href="<?php echo e(route('admin.preferences')); ?>" data-group="profile"><?php echo e(trans('global.preferences_title')); ?></a>
    </li>
    <li
        class="<?php echo e(request()->routeIs('admin.smssetting') || request()->routeIs('admin.msg91') || request()->routeIs('admin.twilliosetting') || request()->routeIs('admin.nexmosetting') || request()->routeIs('admin.twofactor') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.smssetting')); ?>" data-group="sms"><?php echo e(trans('global.smssettings_title')); ?></a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.settings.app.show') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.settings.app.show')); ?>" data-group="sms"><?php echo e(trans('global.app_settings')); ?></a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.email') ? 'active' : ''); ?>" style=" display: none ">
        <a href="<?php echo e(route('admin.email')); ?>" data-group="sms"><?php echo e(trans('global.emailSettings_title')); ?></a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.currencySetting') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.currencySetting')); ?>" data-group="sms">Currency Settings</a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.pushnotification') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.pushnotification')); ?>"
            data-group="sms"><?php echo e(trans('global.push_notification_setting')); ?></a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.api-informations') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.api-informations')); ?>" data-group="sms"><?php echo e(trans('global.apiCredentials_title')); ?>

        </a>
    </li>
    <li class="<?php echo e(request()->routeIs('admin.payment_methods.index') ? 'active' : ''); ?>">
        <a href="<?php echo e(route('admin.payment_methods.index', 'paypal')); ?>" data-group="sms">
            <?php echo e(trans('global.paymentMethods_title')); ?>

        </a>
    </li>
</ul>
<?php /**PATH /home/unibooker-rideon-code/htdocs/rideon-code.unibooker.app/resources/views/admin/generalSettings/general-setting-links/links.blade.php ENDPATH**/ ?>