From: James Yonan <jim@...41...>
In-Reply-To: <05Mar9.114257est.1627338@...346...>
Message-ID: <Pine.LNX.4.58.0503091410230.18805@...41...>
References: <05Mar9.114257est.1627338@...346...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [2rc16] PAM plugin bug for PAM_PROMPT_ECHO_ON
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Mar  9 13:19:06 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: P Kern <pkern@...345...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 9 Mar 2005, P Kern wrote:

> > From yonan.net!jim Tue Mar  8 16:47:54 2005
> >
> > On Tue, 8 Mar 2005, P Kern wrote:
> > > Stumbled across a bug in the auth-pam.c plugin which was causing the
> > > username to be sent in response (instead of the password) when 
> > > PAM_PROMPT_ECHO_ON is requested.  The patch below seems to fix this.
> > > Hope this helps.  pk.
> >
> > Are you sure this is a bug?  All of the PAM examples I've seen use 
> > PAM_PROMPT_ECHO_OFF as the hint that the password is being queried, and 
> > PAM_PROMPT_ECHO_ON as the username hint.
> 
> Yup, pretty sure.  With those examples you saw, which side of the PAM
> conversation was involved?
> 
> The PAM module that we use works okay with SSH.  But it was failing
> with the openvpn auth-pam plugin.  The logs at the authentication server
> showed that the username was being sent in place of the password.
> 
> According to ...
> http://www.kernel.org/pub/linux/libs/pam/Linux-PAM-html/pam_appl-3.html
>     PAM_PROMPT_ECHO_OFF  =  Obtain a string without echoing any text 
>     PAM_PROMPT_ECHO_ON   =  Obtain a string whilst echoing text 
> 
> The way I think this stuff is supposed to work is that when the
> application (ie. openvpn) gets a msg_style of PAM_PROMPT_ECHO_x from
> the other side of the PAM converstion, then it's supposed to use the msg
> string to prompt the user for a password.  If msg_style is _ECHO_ON,
> then the application should display the prompt and echo the password as
> the user types it in.  With _ECHO_OFF, the prompt should be displayed
> and the password should be hidden when the user types is in.
> 
> [ In our case, we use a couple of authentication methods:
>   old-style unix passwords or one-time SecurID passcodes.
>   The password prompt is used to indicate which authentication method
>   is being used.  But typically our users already know in advance which
>   authentication method they need to use so we're able to work just fine
>   without being able to display indicative prompts.
>   So with old-style unix passwords, what the user types is not echoed.
>   But with one-time SecurID passcodes, what the user types can be echoed
>   because next time the passcode will be different.  ]
> 
> Openvpn seems to fetch the username+password independent of PAM and the
> auth-pam module is then used for simple authentication.  Which means the
> prompt styles and strings are not really used in auth-pam. So auth-pam's
> PAM_PROMPT_ behaviour shouldn't really be any different for _ECHO_ON or
> for _ECHO_OFF.

The problem with PAM is that it doesn't give a machine readable indication
on whether it wants the username or password.  All you have is the
PAM_PROMPT_ECHO_x hint and a human-readable prompt string that could be 
anything the PAM module wants it to be.

Right now openvpn-auth-pam does what most PAM client examples show --
assume the password is queried with echo off, and the username with echo
on. Obviously this is a simplification, and some PAM modules will break
with this assumption.

A better method would be to look at the human readable query string and
figure out what it means.  This is tricky because different PAM modules 
may use different strings.

If you run with --verb 7 or higher, openvpn-auth-pam.so will show the 
PAM "conversation" strings, so we will see the human readable queries.  If 
we knew the different ways that different PAM modules query for 
username/password, i.e. the different query strings they use, we could 
fix the my_conv() function in auth_pam.c to be smarter.

James


