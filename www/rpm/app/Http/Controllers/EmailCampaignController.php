<?php

namespace App\Http\Controllers;

use App\Models\Campaign;
use App\Models\Registration;
use Brevo\Client\Api\TransactionalEmailsApi;
use Brevo\Client\ApiException;
use Brevo\Client\Configuration;
use Brevo\Client\Model\SendSmtpEmail;
use Brevo\Client\Model\SendSmtpEmailTo;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class EmailCampaignController extends Controller
{
    public function sendEmailToRegistrations()
    {
        // #region agent log
        file_put_contents('d:\REGTIX\.cursor\debug.log', json_encode(['sessionId'=>'debug-session','runId'=>'run1','hypothesisId'=>'A','location'=>'EmailCampaignController.php:21','message'=>'Campaign query before execution','data'=>['query'=>'where status=active'],'timestamp'=>time()*1000])."\n", FILE_APPEND);
        // #endregion
        $campaign = Campaign::where('status','active')->first();
        // #region agent log
        file_put_contents('d:\REGTIX\.cursor\debug.log', json_encode(['sessionId'=>'debug-session','runId'=>'run1','hypothesisId'=>'A','location'=>'EmailCampaignController.php:23','message'=>'Campaign query result','data'=>['campaign_id'=>$campaign?->id,'campaign_exists'=>!is_null($campaign)],'timestamp'=>time()*1000])."\n", FILE_APPEND);
        // #endregion
        if (!$campaign) {
            // #region agent log
            file_put_contents('d:\REGTIX\.cursor\debug.log', json_encode(['sessionId'=>'debug-session','runId'=>'run1','hypothesisId'=>'A','location'=>'EmailCampaignController.php:26','message'=>'Campaign is null, returning early','data'=>[],'timestamp'=>time()*1000])."\n", FILE_APPEND);
            // #endregion
            return;
        }
        $registrations = Registration::whereDoesntHave('campaigns', function ($query) use ($campaign) {
            $query->where('campaign_id', $campaign->id);
        })->take(10)->get();

        foreach ($registrations as $registration) {
            Log::info($registration);
            
            $this->sendEmail($campaign, $registration);
            if ($campaign->registrations()->where('registration_id', $registration->id)->exists()) {
                // Jika pivot sudah ada, update status
                $campaign->registrations()->updateExistingPivot($registration->id, ['status' => 'sent']);
            } else {
                // Jika pivot belum ada, tambahkan data pivot baru
                $campaign->registrations()->attach($registration->id, ['status' => 'sent']);
            }
        }        
    }

    private function sendEmail($campaign, $registration)
    {
        try {
            $config = Configuration::getDefaultConfiguration()->setApiKey('api-key', env('BREVO_API_KEY'));
            
            $apiInstance = new TransactionalEmailsApi(
                new Client(),
                $config
            );

            // #region agent log
            file_put_contents('d:\REGTIX\.cursor\debug.log', json_encode(['sessionId'=>'debug-session','runId'=>'run1','hypothesisId'=>'B','location'=>'EmailCampaignController.php:52','message'=>'Before accessing event property','data'=>['registration_id'=>$registration->id,'has_category_ticket_type'=>!is_null($registration->category_ticket_type_id),'event_exists'=>!is_null($registration->event)],'timestamp'=>time()*1000])."\n", FILE_APPEND);
            // #endregion
            $params = [
                'name' => $registration->full_name,
                'reg_id' => $registration->event?->code_prefix.$registration->reg_id
            ];
            $sendSmtpEmail = new SendSmtpEmail([
                'subject' => $campaign->subject,
                'sender' => ['name' => 'RegTix | '.$registration->event?->name, 'email' => 'info@regtix.id'],
                'replyTo' => ['name' => 'RegTix | '.$registration->event?->name, 'email' => 'info@regtix.id'],
                'to' => [new SendSmtpEmailTo(['email' => $registration->email])], // TODO : Ganti ini
                'htmlContent' => $campaign->html_template,
                'params' => $params
            ]);

            $result = $apiInstance->sendTransacEmail($sendSmtpEmail);
            Log::info($result);
        } catch (ApiException $e){
            Log::error($e->getMessage());
        }
    }

}
