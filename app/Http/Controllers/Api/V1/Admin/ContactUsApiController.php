<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Traits\MediaUploadingTrait;
use App\Http\Controllers\Traits\MiscellaneousTrait;
use App\Http\Controllers\Traits\ResponseTrait;
use App\Models\Contact;
use Illuminate\Http\Request;
use Validator;

class ContactUsApiController extends Controller
{
    use MediaUploadingTrait, MiscellaneousTrait, ResponseTrait;

    /**
     * Get featured items with front image, pagination, and offset.
     *
     * @return \Illuminate\Http\Response
     */
    public function contactUs(Request $request)
    {
        try {

            $validator = Validator::make($request->all(), [

                'token' => 'required',
                'tittle' => 'required',
                'description' => 'required',

            ]);

            if ($validator->fails()) {
                return $this->errorComputing($validator);
            }

            $user_id = $this->checkUserByToken($request->token);

            if (! $user_id) {
                return $this->addErrorResponse(500, trans('global.token_not_match'), '');
            }

            if ($user_id) {
                $contact = new Contact;
                $contact->tittle = $request->tittle;
                $contact->description = $request->description;
                $contact->user = $user_id;
                $contact->status = 1;
                $contact->save();

                return $this->addSuccessResponse(200, trans('global.feedback_added'), ['ContactUs' => $contact]);
            }
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }
}
