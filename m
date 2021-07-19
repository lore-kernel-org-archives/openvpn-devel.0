References: <20210520151148.2565578-7-arne@...1227...>
 <20210713122550.3310818-1-arne@...1227...>
 <0d3e330a-7a14-2597-4b6b-cbf6848ea436@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a3ece15b-ea8f-b661-2b91-d957baf29feb@...1227...>
Date: Mon, 19 Jul 2021 14:33:45 +0200
MIME-Version: 1.0
In-Reply-To: <0d3e330a-7a14-2597-4b6b-cbf6848ea436@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5] Cleanup handling of initial auth
 token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


>>          /*
>>           * reuse the same session id and timestamp and null terminate it at
>>           * for base64 decode it only decodes the session id part of it
>>           */
> 
> This comment above does not make much sense to me, but since it has been
> there since "ever", I'd suggest to fix it in a follow-up patch.
> (This patch is not changing the logic that the comment is trying to explain)
> 
> On top of that, this function makes huge assumptions about the length of
> the token and later it moves pointers across this buffer without
> checking boundaries.
> I am pretty sure that this code works well because the token has a
> static and predictable length, but it might be good to make this
> assumptions explicit by adding at least some comments.


The underlying assumption is that that the token in
multi->auth_token/initial_auth_token is always verified and is safe to
use because otherwise we screwed up elsewhere.

> 
> Anyway, for a follow up patch too.
> 
>> -        char *old_sessid = multi->auth_token + strlen(SESSION_ID_PREFIX);
>> +        char *old_sessid = initial_token_copy + strlen(SESSION_ID_PREFIX);
>>          char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
>>  
>>          old_tsamp_initial[12] = '\0';


This is the line the comment above refers to. We null terminate the
session token part of the token to make it a shorter string to feed into


>> @@ -343,7 +353,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>>      }
>>      else
>>      {
>> -        msg(M_WARN, "--auth-token-gen: HMAC on token from client failed (%s)",
>> +        msg(M_WARN, "--auth-gen-token: HMAC on token from client failed (%s)",
> 
> totally unrelated to this patch :-) I let Gert decide if we can keep it
> here or not.

Yeah. I noticed that I swapped the name around on accident.

> 
>>              up->username);
>>          return 0;
>>      }
>> @@ -353,13 +363,7 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>>      bool in_renog_time = now >= timestamp
>>                           && now < timestamp + 2 * session->opt->renegotiate_seconds;
>>  
>> -    /* We could still have a client that does not update
>> -     * its auth-token, so also allow the initial auth-token */
>> -    bool initialtoken = multi->auth_token_initial
>> -                        && memcmp_constant_time(up->password, multi->auth_token_initial,
>> -                                                strlen(multi->auth_token_initial)) == 0;
>> -
>> -    if (!in_renog_time && !initialtoken)
>> +    if (!in_renog_time)
> 
> uhm, was this always supposed to be "in_reneg_time" ? maybe we can fix
> it while at it..

Sure can do that as cleanup

> 
>>      {
>>          ret |= AUTH_TOKEN_EXPIRED;
>>      }
>> @@ -383,7 +387,19 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
>>      {
>>          /* Tell client that the session token is expired */
>>          auth_set_client_reason(multi, "SESSION: token expired");
>> -        msg(M_INFO, "--auth-token-gen: auth-token from client expired");
>> +        msg(M_INFO, "--auth-gen-token: auth-token from client expired");
>> +    }
>> +
>> +    /* Check that we do have the same session ID in the token and the session
>> +     * did not change, this also compares the prefix and session part of the
> 
> Regarding the sentence above, is it possible that we have the same
> session ID and the sessions are not the same? From the comment it seems
> it could be possible, but I am not sure this can be the case.

Will rewrite it.


> 
>> +     * tokens, which should be identical if the session stayed the same */
>> +    if (multi->auth_token_initial
>> +        && memcmp_constant_time(multi->auth_token_initial, up->password,
>> +                                strlen(SESSION_ID_PREFIX) + AUTH_TOKEN_SESSION_ID_LEN * 8 / 6))
> 
> Is this hunk actually fixing a problematic behaviour?
> It seems before this patch we were missing this specific check? or
> wasn't it needed?
> 
> 
> Cosmetic note:
> AUTH_TOKEN_SESSION_ID_LEN * 8 / 6 << this constant is used in several
> places in the code.
> Can we rather define another constant with a name that makes it clear
> what it is? IIRC this "* 8 / 6" is used to compute the expected length
> in base64, right?

I will replace it with a define

>> +
>> +void
>> +resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session)
>> +{
>> +    /*
>> +     * Auth token already sent to client, update auth-token on client.
>> +     * The initial auth-token is sent as part of the push message, for this
>> +     * update we need to schedule an extra push message.
>> +     *
>> +     * Otherwise the auth-token get pushed out as part of the "normal"
>> +     * push-reply
>> +     */
>> +    bool is_renegotiation = session->key[KS_PRIMARY].key_id != 0;
>> +
>> +    if (multi->auth_token_initial && is_renegotiation)
>> +    {
>> +        /*
>> +         * We do not explicitly reschedule the sending of the
>> +         * control message here. This might delay this reply
>> +         * a few seconds until but this message is not time critical
> 
> until .. ? is something missing? or "until" was supposed to be removed?

Yes the old moved function had an actually wrong part after the util.



>>      if (session->opt->auth_token_generate && is_auth_token(up->password))
>>      {
>>          ks->auth_token_state_flags = verify_auth_token(up, multi, session);
>> +
>> +        /* If this is the first time we see an auth-token in this session, save
>> +         * it as initial auth token so to continue using the same session ID
>> +         * and timestamp in updates */
>> +        if (!multi->auth_token_initial)
>> +        {
>> +            multi->auth_token_initial = strdup(up->password);
>> +        }
>> +
> 
> We have the very same code in generate_auth_token(), why do we need it
> here too? I had thought that the auth-token-initial is saved only upon
> first token generation.
> 
> What use case are we covering here in verify_user_pass()?

Client authenticates with an auth-token and we want to keep the session
ID and initial token time in all tokens we push later to the client.

>>
> 
> 
> The rest looks good. I like seeing more auth-token logic being moved to
> auth-token.c, in the proper functions.
> 
> In any case, will still wait for Arne to clarify my doubts, as expressed
> above.
> 
> [note: I am still testing..]

