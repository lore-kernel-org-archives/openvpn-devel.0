MIME-Version: 1.0
In-Reply-To: <1d788821-2cec-9201-f8b0-3f8a7c76333a@...2080...>
References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-6-git-send-email-davids@...515...>
	<83c2c0fc-23e6-f03e-7151-198955416315@...1856...>
	<1d788821-2cec-9201-f8b0-3f8a7c76333a@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 28 Oct 2016 13:46:51 +0200
Message-ID: <CAA1Abx+rxD6STU5DuSMKL7gnG8_UpmpuuaDLftOu1cTB-oUN6A@...278...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] auth-gen-token: Authenticate
 generated auth-tokens when client re-authenticates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 19 October 2016 at 23:12, David Sommerseth
<openvpn@...2080...> wrote:
> On 19/10/16 22:12, Steffan Karger wrote:
>> On 13-10-16 21:59, David Sommerseth wrote:
>>> On a server with --auth-gen-token enabled, the server will have created
>>> a random token and pushed it to the client.  When the client needs to
>>> renegotiate the connection or otherwise reconnect, it will at this point
>>> use the auth-token as password.
>>
>> How does/should auth-token behave across the various restarts?  Should
>> auth-token for example be cleared on a sigusr1?
>
> This isn't really well defined, from the initial design.  This patch is
> all based upon the --auth-token feature already present in OpenVPN 2.3,
> and what is possible to do via the plug-in/script mechanisms available
> today - which works even on v2.3 servers today.
>
> So this feature I introduce here will currently only provide a similar
> behaviour as if this the external authentication module had implemented
> --auth-token support.  Plug-ins and --auth-user-pass-verify can only
> return "success" and "fail", which is what this patch in essence does.
>
> With that said, I am not too happy about this ambiguity.  But fixing
> that should be done separately.  And we need to ensure we don't break
> existing v2.3 clients, and I believe we need to update the client code a
> bit too to achieve these goals.
>
>>> Here we check if we have a token generated and that it has been pushed
>>> to the client, if so, then we check if the token matches the locally
>>> stored token.  If everything matches, we're done and the connection
>>> is still authenticated.
>>>
>>> If the auth-token authentication fails, we delete our local copy of
>>> the token and changes the connection to not being authenticated.  From
>>> this moment of, the client needs to do a full reconnect providing
>>> the users password again.
>>
>> How does the client know this?  This patch does not send an AUTH_FAILED
>> (or something similar) to the client.  Testing seems to indicate that
>> the server keeps refusing the token, and the client keeps resending it.
>
> Sending AUTH_FAILED explicit would definitely be a good idea.  But it is
> needed to verify that the OpenVPN is in a state where it can push and
> that the client can accept the push.
>
> But regardless of this, it this will not change the behaviour much at
> all.  AFAICT, the client code today cannot separate authentication
> failures based on passwords or tokens or get a reason why the
> authentication failed.  (Unless there are something hidden inside IV_*
> stuff or Peer-ID).
>
> So what happens?  The server goes back to normal username/password
> authentication, which fails as the token isn't valid as a password to
> the authentication module.  The authentication module rejects and the
> server sends an AUTH_FAILED, and the client disconnects.  At least
> that's what happens in my testing environment.
>
> If it is possible to send an AUTH_FAILED directly without going via the
> authentication module, we can do that.  But going further than that will
> most likely require some updates to the client code as well - which I
> try to avoid in this round.

Ok, so it seems we want the exact same thing, and these are the first
step towards it.  Let's postpone this for later patches than.  I do
think we need to look into this before releasing 2.4.0.

If youl fix my nagging point before applying, ACK.

-Steffan

