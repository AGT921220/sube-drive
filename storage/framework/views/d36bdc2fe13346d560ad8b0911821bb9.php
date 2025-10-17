<?php $__env->startSection('content'); ?>
    <section class="content">
        <div class="row gap-2">
            <div class="col-md-3 settings_bar_gap">
                <div class="box box-info box_info">
                    <div class="">
                        <h4 class="all_settings f-18 mt-1" style="margin-left:15px;"> <?php echo e(trans('global.manage_settings')); ?>

                        </h4>
                        <?php echo $__env->make('admin.generalSettings.general-setting-links.links', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title"><?php echo e(trans('global.general_title_singular')); ?></h3><span class="email_status"
                            style="display: none;">(<span class="text-green"><i class="fa fa-check"
                                    aria-hidden="true"></i>Verified</span>)</span>
                    </div>
                    <form id="general_form" method="post" action="<?php echo e(route('admin.add_configuration_wizard')); ?>"
                        class="form-horizontal" enctype="multipart/form-data" novalidate="novalidate">
                        <?php echo e(csrf_field()); ?>

                        <div class="box-body">
                            <div class="form-group name">
                                <label for="inputEmail3" class="col-sm-3 control-label"><?php echo e(trans('global.name')); ?> <span
                                        class="text-danger">*</span></label>
                                <div class="col-sm-6">
                                    <input type="text" name="general_name" class="form-control" id="name"
                                        value=" <?php echo e($general_name->meta_value ?? ''); ?>" placeholder="Name">
                                    <span class="text-danger"></span>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div class="form-group name">
                                <label for="inputEmail3"
                                    class="col-sm-3 control-label"><?php echo e(trans('global.site_desciption')); ?> <span
                                        class="text-danger"></span></label>
                                <div class="col-sm-6">
                                    <input type="text" name="general_description" class="form-control"
                                        id="general_description" value=" <?php echo e($general_description->meta_value ?? ''); ?>"
                                        placeholder="general_description">
                                    <span class="text-danger"></span>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div class="form-group email">
                                <label for="inputEmail3" class="col-sm-3 control-label"><?php echo e(trans('global.email')); ?> <span
                                        class="text-danger">*</span></label>
                                <div class="col-sm-6">
                                    <input type="email" name="general_email" class="form-control" id="email"
                                        value=" <?php echo e($general_email->meta_value ?? ''); ?>" placeholder="Email">
                                    <span class="text-danger"></span>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div
                                class="form-group phone row <?php echo e($errors->has('general_default_phone_country') || $errors->has('general_phone') ? 'has-error' : ''); ?>">
                                <label for="phone_country"
                                    class="col-sm-3 control-label"><?php echo e(trans('global.phone_country')); ?><span
                                        class="text-danger">*</span></label>
                                <div class="col-sm-3">
                                    <select class="form-control" name="general_default_phone_country"
                                        id="general_default_phone_country" onchange="updateDefaultCountry()">
                                        <?php $__currentLoopData = config('countries'); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $country): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <option value="<?php echo e($country['dial_code']); ?>"
                                                data-country-code="<?php echo e($country['code']); ?>"
                                                <?php echo e(old('general_default_phone_country', $general_default_phone_country->meta_value ?? '') == $country['dial_code'] ? 'selected' : ''); ?>>
                                                <?php echo e($country['name']); ?> (<?php echo e($country['dial_code']); ?>)
                                            </option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    </select>
                                    <?php if($errors->has('general_default_phone_country')): ?>
                                        <span
                                            class="help-block text-danger"><?php echo e($errors->first('general_default_phone_country')); ?></span>
                                    <?php endif; ?>
                                </div>
                                <div class="col-sm-3">
                                    <input class="form-control" type="text" name="general_phone" id="phone"
                                        value="<?php echo e($general_phone->meta_value ?? ''); ?>" required>
                                    <?php if($errors->has('general_phone')): ?>
                                        <span class="help-block text-danger"><?php echo e($errors->first('general_phone')); ?></span>
                                    <?php endif; ?>
                                </div>
                            </div>
                            <div class="form-group" style="display: none;">
                                <label for="default_country"><?php echo e(trans('global.default_country')); ?></label>
                                <input class="form-control" type="text" name="general_default_country_code"
                                    id="general_default_country_code"
                                    value="<?php echo e(old('general_default_country_code', '')); ?>">
                                <?php if($errors->has('general_default_country_code')): ?>
                                    <span
                                        class="help-block text-danger"><?php echo e($errors->first('general_default_country_code')); ?></span>
                                <?php endif; ?>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-3 control-label"><?php echo e(trans('global.logo')); ?></label>
                                <div class="col-sm-6">
                                    <input type="file" name="general_logo" class="form-control" id="photos[logo]"
                                        value="" placeholder="Logo">
                                    <span class="text-danger"></span>
                                    <?php if(!empty($general_logo->meta_value)): ?>
                                        <br><img class="file-img" src="<?php echo e('/storage/' . $general_logo->meta_value); ?>"
                                            width="150" alt="Logo">
                                    <?php endif; ?>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail3"
                                    class="col-sm-3 control-label"><?php echo e(trans('global.favicon')); ?></label>
                                <div class="col-sm-6">
                                    <input type="file" name="general_favicon" class="form-control validate_field"
                                        id="photos[favicon]" value="" placeholder="Favicon">
                                    <span class="text-danger"></span>
                                    <?php if(!empty($general_favicon->meta_value)): ?>
                                        <br>
                                        <img class="file-img" src="<?php echo e('/storage/' . $general_favicon->meta_value); ?>"
                                            height="25" alt="Favicon">
                                    <?php endif; ?>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div class="form-group default_currency" style="display: none;">
                                <label for="inputEmail3"
                                    class="col-sm-3 control-label"><?php echo e(trans('global.default_currency')); ?></label>
                                <div class="col-sm-6">
                                    <select class="form-control validate_field" id="default_currency"
                                        name="general_default_currency">
                                        <?php $__currentLoopData = $allcurrency; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $currency): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <option value="<?php echo e($currency->currency_code); ?>"
                                                <?php if(($general_default_currency->meta_value ?? null) == $currency->currency_code): ?> selected <?php endif; ?>>
                                                <?php echo e($currency->currency_name); ?>

                                            </option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div class="form-group default_language">
                                <label for="inputEmail3"
                                    class="col-sm-3 control-label"><?php echo e(trans('global.default_language')); ?></label>
                                <div class="col-sm-6">
                                    <select class="form-control validate_field" id="default_language"
                                        name="general_default_language">
                                        <?php $__currentLoopData = $languagedata; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $language): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <option value="<?php echo e($language->short_name); ?>"
                                                <?php if($language->short_name == $general_default_language->meta_value): ?> selected <?php endif; ?>><?php echo e($language->name); ?>

                                            </option>
                                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                    </select>
                                    <span class="text-danger"></span>
                                </div>
                                <div class="col-sm-3">
                                    <small></small>
                                </div>
                            </div>
                            <div class="text-center" id="error-message"></div>
                        </div>
                        <div class="box-footer">
                            <button type="submit" class="btn btn-info btn-space"> <?php echo e(trans('global.save')); ?></button>
                            <a class="btn btn-danger" href="<?php echo e(route('admin.settings')); ?>">
                                <?php echo e(trans('global.cancel')); ?></a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
<?php $__env->stopSection(); ?>
<?php $__env->startSection('scripts'); ?>
    <script>
        function updateDefaultCountry() {
            const phoneCountryDropdown = document.getElementById('general_default_phone_country');
            const defaultCountryField = document.getElementById('general_default_country_code');
            const selectedDialCode = phoneCountryDropdown.value;
            const selectedOption = phoneCountryDropdown.querySelector(`option[value="${selectedDialCode}"]`);
            const countryCode = selectedOption ? selectedOption.getAttribute('data-country-code') : '';
            defaultCountryField.value = countryCode;
        }
        document.addEventListener("DOMContentLoaded", function() {
            updateDefaultCountry();
        });
    </script>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.admin', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH /home/unibooker-rideon-code/htdocs/rideon-code.unibooker.app/resources/views/admin/generalSettings/general/basic-configuration-form.blade.php ENDPATH**/ ?>