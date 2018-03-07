References: <1520262951-1807-1-git-send-email-arne@...1227...>
 <1520265024-2129-1-git-send-email-arne@...1227...>
 <CAKuzo_hC11dM1t5sPY9MV1AVzXLr+ZxD+BF3EFQv4e4o87BxGg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b53bcb01-6a0b-be13-c2df-0a7f7bc848b5@...1227...>
Date: Wed, 7 Mar 2018 12:52:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hC11dM1t5sPY9MV1AVzXLr+ZxD+BF3EFQv4e4o87BxGg@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2] Rework OpenVPN auth-token support
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 06.03.18 um 22:04 schrieb Selva Nair:
> Hi,
> 
> Based on the commit message this appears to cover all that is wrong
> with current auth-token implementation. I haven't carefully reviewed the
> code or tested it, but some initial remarks that looks relevant.
> 
> On Mon, Mar 5, 2018 at 10:50 AM, Arne Schwabe <arne@...1227...> wrote:
>> Auth-token is documented as a token that the client will use instead
>> of a auth-token. When using an external auth-token script and OTP
>> authentication, it is useful to have this token survive on reconnect
>> (e.g. mobile device roaming).  On the other hand if the token does
>> expire, the client should fall back to the previous authentication
>> methd (e.g. user/pass) or ask for a OTP password again.
>>
>> Behaviour of OpenVPN client (prior to this patch) is to never fallback
>> to the previous authentication method. Depending on auth-retry it
>> either quit or tried endlessly with an expired token. Since
>> auth-gen-token tokens expire on reconnect, a client will not survive a
>> reconnect.
> 
> While this is mostly true, there is one point missing here. That being
> the main reason for this email, here goes:
> 
> While its true that, on SIGUSR1, the client does retry with auth-token
> it's only a minor nuisance:  it leads to an AUTH_FAILED and
> then the client does go back to prompting for username/password
> (assuming auth-retry is enabled). The real sticky problem is when
> authentication fails during a TLS reneg due to an expired auth-token.
> The client won't realize why the reneg did not complete and will
> repeatedly try to renegotiate using the expired (or invalid) token. The
> reason for this is that the server does not send back an AUTH_FAILED
> message in such cases.
> 
> I want to stress this point: when the server sends back AUTH_FAILED,
> the client does behave somewhat sanely, but not otherwise. And on that
> count this patch appears to be lacking. It teaches the client to forget the
> token during SIGUSR1 restarts which is good, but does not teach the server
> to send back AUTH_FAILED in all instances of auth failures.


I think failed authentication during a renogiation is also a valid issue
that this patch does not address and the behaviour is somewhat broken,
also for non auth-token usage. I would prefer to fix that thing in a
sperate patch. This patch mainly focuses on fixing auth-gen-token and
client interaction as much as possible.


>>
>> This patch changes the client behaviour:
>>
>> - Treat a failed auth when using an auth-token as a soft error (USR1)
>>   and clean the auth-token falling back to the original auth method
> 
> We could be more graceful here by not triggering USR1 -- clearing the
> token is enough as that will automatically cause the client to fall
> back to auth-user-pass prompting. I say graceful because some failures
> do not need a restart, only a re-attempt to authenticate with
> a valid username/password.
> 

Currently this code is only triggered on inital connnection (as the
server fails to send AUTH_FAILED as you noted before). I have not
checked how easy it is for the client to send a second key_exchange message.


>>
>> - Implement a new pushable option forget-token-reconnect that forces
>>   to forget an auth-token when reconnecting
> 
> I would have liked to see this as the default behaviour: IMO the "right"
> way to use auth-token is to expire it on reconnect but if some
> existing external scripts want it otherwise, fine...

That is something we should discuss. I did here err on the side of
caution and not break existing setups since currently the only working
that that does not break on reconnect is one where auth-tokens are valid
after reconnect and changing this default would break those scnearios
and in the past we have most times erred on the side of caution and
compatibility.

>>
>> - Sending IV_PROTO=3 to signal that it is safe to send this client an
>>   expiring auth-token
> 
> Once the server side auth-failure handling is fixed this will be less
> of a concern. But a new IV_PROTO value cant hurt.


You still need the ability in the client to actually be able to forget
and the server needs to know if the client supports forgetting and it is
safe to send the auth-token.

> 
>>
>> The behaviour of the server option auth-gen-token:
>>
>> - Automatically push forget-token-reconnect to avoid a failed
>>   authentication after reconnect
> 
> Yes. Unless "forget on reconnect" becomes the only possible client
> behaviour :)

Sure but then we should add a keep-token-reconnect to support "OTP with
often roaming clients" scenario.

> 
>>
>> - By default only send auth-token to clients that will gracefully
>>   handle auth-token to avoid having clients not able to reconnect
> 
> I suppose this is regarding expiring tokens, not permanent tokens.


Yes, since auth-gen-token has no permanent tokens (they only valid for
the session and after reconnect are invalid), they expire instantly when
a client reconnects.



>> -        switch (auth_retry_get())
>> +    if (c->options.pull) {
>> +        /* Before checking how to react on AUTH_FAILED, first check if the failed authed might be
>> +         * the result of an expired auth-token */
>> +        if (ssl_clean_auth_token())
>>          {
> 
> This is not going to work. The only time the server sends back
> AUTH_FAILED is during the initial connection. See that
> send_auth_failed() is called only during PUSH request processing[*].

At least it fixes a client's behaviour with this patch with server that
has the default auth-gen-token without expiry set. :)

> So, failure due to token expiry that normally happens during a reneg[*]
> will not trigger AUTH_FAILED and the client will continue trying reneg
> until the previous TLS session expires (1 hour?). This is a
> basic limitation of the present implementation and I do not see it
> being addressed by the patch.

I will look into sending AUTH_FAILED also without management-client-auth.

Arne

