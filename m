MIME-Version: 1.0
In-Reply-To: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 26 Aug 2016 00:21:50 +0200
Message-ID: <CAA1AbxK5kCi5_NzeggKNt7+oLCvacMCEG0X4UwWqbzRKraTV=Q@...278...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
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

On 25 August 2016 at 15:45, David Sommerseth
<openvpn@...2080...> wrote:
> I've been working a bit on a new patch-set which enables third-party
> user/password authentication mechanisms using two factor
> authentications [2FA] (such as OTP) and not needing to disable the
> renegotiation features of OpenVPN.
>
> Currently, if a server is configured with 2FA using for example
> HOTP/TOTP tokens, each renegotiation of the tunnel would require the
> user to provide a new OTP code.  The current workaround have been to
> disable the renegotiation (which by default happens once per hour).
> It is also not considered ideal to disable the renegotiation.
>
> The patch-set I have worked on fixes this by adding a new server side
> option, --auth-gen-token.  This makes use of a feature already found
> in OpenVPN clients.  If a server pushes 'auth-token $TOKENVALUE' to a
> client, it will replace the currently locally stored password with
> $TOKENVALUE.  Next time the OpenVPN tunnel is rengotiated, the
> $TOKENVALUE will now be passed instead to the server along with the
> username.
>
> What the patch-set does is:
>
> - - Add --auth-gen-token, and when used the following steps happens
>
> - - After a successful normal user/password authentication, it will
>   generate a random token for this tunnel and keep a local copy of it.
>   This token is currently set to 256 bits (32 bytes).
>
> - - It will push 'auth-token $RANDOM_TOKEN_VALUE'.  The
>   $RANDOM_TOKEN_VALUE sent to the client is BASE64 encoded.
>
> - - When a re-authentication happens, and the server sees it have
>   a token and the token have been sent to the client, it does an
>   authentication of the token alone.  Any --auth-user-pass-verify or
>   --plugins enabling OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY will not
>   be called at this point.  On successful token authentication,
>   everything continues as before.  On failure the session is considered
>   un-authenticated and a complete new authentication round is required.

I haven't yet had the chance to look at the code, but the concept makes sense.

One thing I think might be useful is a timeout that forces a client to
do a full reauth.  I can imagine a company policy that, for example,
requires users to perform a 2FA at least every 4 hours.  I'd want to
implement such a policy without stretching the default 1 hour
renegotiate to 4 hours.  But that might also be too much of a corner
case which is not worth the extra code...

-Steffan

