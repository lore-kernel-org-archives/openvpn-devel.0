MIME-Version: 1.0
In-Reply-To: <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <CAKuzo_hC11dM1t5sPY9MV1AVzXLr+ZxD+BF3EFQv4e4o87BxGg@...278...>
 <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 7 Mar 2018 10:47:58 -0500
Message-ID: <CAKuzo_gO3-+Au9SJg6n8uD-mbFeyCMUANux6St0kbTznUPOcJw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,


On Wed, Mar 7, 2018 at 6:52 AM, Arne Schwabe <arne@...1227...> wrote:
> Am 06.03.18 um 22:04 schrieb Selva Nair:
>
..

>> I want to stress this point: when the server sends back AUTH_FAILED,
>> the client does behave somewhat sanely, but not otherwise. And on that
>> count this patch appears to be lacking. It teaches the client to forget the
>> token during SIGUSR1 restarts which is good, but does not teach the server
>> to send back AUTH_FAILED in all instances of auth failures.
>
>
> I think failed authentication during a renogiation is also a valid issue
> that this patch does not address and the behaviour is somewhat broken,
> also for non auth-token usage. I would prefer to fix that thing in a
> sperate patch. This patch mainly focuses on fixing auth-gen-token and
> client interaction as much as possible.

That is fine. In that case let's not pretend that an expiring
auth-token using auth-gen-token is a supported feature. Disable it in
the server until we have the ability to send AUTH_FAILED in such
cases.

>
>
>>>
>>> This patch changes the client behaviour:
>>>
>>> - Treat a failed auth when using an auth-token as a soft error (USR1)
>>>   and clean the auth-token falling back to the original auth method
>>
>> We could be more graceful here by not triggering USR1 -- clearing the
>> token is enough as that will automatically cause the client to fall
>> back to auth-user-pass prompting. I say graceful because some failures
>> do not need a restart, only a re-attempt to authenticate with
>> a valid username/password.
>>
>
> Currently this code is only triggered on inital connnection (as the
> server fails to send AUTH_FAILED as you noted before). I have not
> checked how easy it is for the client to send a second key_exchange message.

Agreed SIGUSR1 is appropriate for initial failure, but initial failure
happens with auth-token only because the client does not forget the
token during SIGUSR1/SIGHUP reconnects. Once it learns to do that (as
this patch does), there are no "initial failures" with auth-token
(more on that below).

>
>
>>>
>>> - Implement a new pushable option forget-token-reconnect that forces
>>>   to forget an auth-token when reconnecting
>>
>> I would have liked to see this as the default behaviour: IMO the "right"
>> way to use auth-token is to expire it on reconnect but if some
>> existing external scripts want it otherwise, fine...
>
> That is something we should discuss. I did here err on the side of
> caution and not break existing setups since currently the only working
> that that does not break on reconnect is one where auth-tokens are valid
> after reconnect and changing this default would break those scnearios
> and in the past we have most times erred on the side of caution and
> compatibility.

Agreed, if external scripts that implement auth-token without using
auth-gen-token wants to reuse the token, fine..

>
>
>
>>> -        switch (auth_retry_get())
>>> +    if (c->options.pull) {
>>> +        /* Before checking how to react on AUTH_FAILED, first check if the failed authed might be
>>> +         * the result of an expired auth-token */
>>> +        if (ssl_clean_auth_token())
>>>          {
>>
>> This is not going to work. The only time the server sends back
>> AUTH_FAILED is during the initial connection. See that
>> send_auth_failed() is called only during PUSH request processing[*].
>
> At least it fixes a client's behaviour with this patch with server that
> has the default auth-gen-token without expiry set. :)

Not really -- that gets fixed by forget-token-reconnect which is
pushed when auth-gen-token is set. So I think this code path will
never get exercised. As this patch will push forget-token-reconnect,
every restart will call ssl_clean_auth_token() from init.c so the
client will use the username/password, not any previously set token.
As AUTH_FAILED is received only during such first attempts, there is
no token to clean at that point and thus this will be skipped. It will
"mysteriously" start to get exercised if/when we later fix
AUTH_FAILED. So better leave it out of this patch. Or am I missing
something?

Selva

