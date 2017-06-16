References: <7860b0e6a671e51e0853cf7a351d874e@...2277...>
	<20170615074739.GI97029@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <ca8191f9-2641-06b4-bcbc-6bd7133b9b18@...1147...>
Date: Fri, 16 Jun 2017 15:31:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170615074739.GI97029@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Bug or Feature? Username in environment in
 auth-user-pass-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Steven Haigh <netwiz@...2277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert et al,

On 15/06/17 09:47, Gert Doering wrote:
> Hi,
>
> On Thu, Jun 15, 2017 at 12:50:40PM +1000, Steven Haigh wrote:
>> I'm just trying to figure out if its expected behaviour to have the
>> 'username' set in the environment when using the auth-user-pass-verify
>> script.
> The code in question (ssl_verify.c) is older than the involvement of
> any of the currently-active developers... but JJK or Ecrist might know.
>
> Anyway, what the code *says* is:
>
> ssl_verify.c, about line 1095:
>
> verify_user_pass_script(...)
> {
> ...
>          /* Set environmental variables prior to calling script */
>          if (session->opt->auth_user_pass_verify_script_via_file)
>          {
> ... (no setenv here)
>          }
>          else
>          {
>              setenv_str(session->opt->es, "username", up->username);
>              setenv_str(session->opt->es, "password", up->password);
>          }
>
>
> so, yes, that is what it *does* - "username" is only ever set together
> with "password", and that's only setenv'ed if you do not use "via-file".

that's how I remember it as well:  username is setenv'ed only if you use 'via-env' ; no special reason for it, just how the flow 
of the code goes.
> Now, that is about calling the --verify-auth-user-pass, but I think the
> "es" (environment set) being affected here is the global per-connection
> es (not something local to this function), so that would affect
> --client-connect as well.
>
> [..]
>> The auth-user-pass-verify documentation states:
>> If method is set to "via-env", OpenVPN will call script with the
>> environmental variables username and password set to the
>> username/password strings provided by the client. Be aware that this
>> method is insecure on some platforms which make the environment of a
>> process publicly visible to other unprivileged processes.
> This "some platforms" actually something we should eventually verify
> and clearly spell-out - because Linux and all recent BSDs do *not* show
> the environment to other unprivileged users.
>
> [..]
>> No mention of the username env variable when using via-file - but this
>> gives me the impression that the username should *not* be set in the
>> environment - but it should be in the file.
>>
>> So - bug or feature?
> Username and Password are always handled in tandem when talking about
> --auth-user-pass-verify, so "both in environment" or "none of them".
>
> Now, if you use a *plugin* (or the management interface), the code will
> always set both in the es, and delete the password(!) afterwards, leaving
> the username intact...
>
>
> Looking from a given distance, I'd say that this is a bug, and "username"
> should propably be always visible in the es (if present), while password
> should not.
>
or one could argue that the behaviour should not change when using a plugin - i.e. the plugin should also unset 'username' ;)

then again, there is no harm in setting the username as an env var, so I'd go for the (trivial) patch.

cheers,

JJK


