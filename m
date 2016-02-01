MIME-Version: 1.0
In-Reply-To: <1453835508-26119-1-git-send-email-gert@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 1 Feb 2016 11:34:47 -0500
Message-ID: <CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
Content-Type: multipart/alternative; boundary=001a113d3d02bac8a8052ab7f740
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Heiko Hund <heiko.hund@...1489...>

--001a113d3d02bac8a8052ab7f740
Content-Type: text/plain; charset=UTF-8

Hi,

I did some review over the weekend, but haven't yet run the code, yet
thought of sending these comments in light of the Windows meeting today.

On Tue, Jan 26, 2016 at 2:11 PM, Gert Doering <gert@...1296...> wrote:
>
> From: Heiko Hund <heiko.hund@...1489...>
>
> v1: Heiko Hund
>  - Message-ID: <2215306.x9ci9DhAZ9@...2001...>
>  - extend openvpn service to provide "automatic service" and "interactive
>    service" (which is used by GUI and OpenVPN to run openvpn
non-privileged
>    and still be able to install routes and configure IPv6 addresses)
>  - add --msg-channel <n> option to openvpn to tell it which pipe to use
>    to talk to the interactive service (used in tun.c for ifconfig + ARP
flush,
>    and route.c for routing)
>  - add openvpn-msg.h with message definitions for talking to interactive
service
>  - routing in openvpn uses message-pipe automatically if --msg-channel
<n> is
>    configured, no other option needed
>  - today, the integration in route.c and tun.c is windows-only, but could
be adapted
>    to other platforms


(snip)

>  src/openvpnserv/Makefile.am   |   14 +-
>  src/openvpnserv/automatic.c   |  416 ++++++++++++++

The "automatic service" part is essentially the same code as the original
except for some mostly cosmetic changes and code re-organization. The
changes are all good and makes the code leaner and cleaner.

But it fixes none of the weaknesses of the original service.

As suggested before, it would be better to make the interactive service a
new executable without the automatic service functionality. Then the
original service could be independently improved or replaced by something
better (openvpnserv2, or whatever)

>  src/openvpnserv/common.c      |  211 +++++++
>  src/openvpnserv/interactive.c | 1273
+++++++++++++++++++++++++++++++++++++++++


The new code implementing the interactive service looks good except for
some possible security concerns.

First, the service starts openvpn.exe as user using a command line supplied
by the user (say by a UI like OpenVPNGUI). The executable name (openvpn.exe)
itself is taken from the registry entry (exe_path) which is good, but the UI
can pass arbitrary options and specify the working directory. This means
arbitrary config files can be passed as arguments to openvpn.exe enabling
arbitrary routes to be set by an unprivileged user using config file
directives or command line options.

While the whole purpose of the interactive service is to allow unprivileged
users to set routes or do ifconfig, admin users should have some ability to
control what routes will be set or which remote servers will be connected
to by unprivileged users. This requires two changes:

(1) the config file should reside in some pre-defined location(s)
controlled by, say, a registry key that only an admin user can change
(2) only a limited set of "safe" options may be allowed on the command line

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b710c9c..6d97b4f 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6015,6 +6015,24 @@ add_option (struct options *options,
>      }
>  #endif
>  #endif
> +  else if (streq (p[0], "msg-channel") && p[1])
> +    {
> +#ifdef WIN32
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      HANDLE process = GetCurrentProcess ();
> +      HANDLE handle = (HANDLE) atoi (p[1]);
> +      if (!DuplicateHandle (process, handle, process,
> &options->msg_channel, 0,
> +                            FALSE, DUPLICATE_CLOSE_SOURCE |
> DUPLICATE_SAME_ACCESS))
> +        {
> +          msg (msglevel, "could not duplicate service pipe handle");
> +          goto err;
> +        }
>

The msg_channel handle is passed on to openvpn.exe as a command line
option, so it cannot trust it (could be that of a named pipe opened by a
rogue process). This looks insecure ---- such a pipe server could
impersonate the user.

A more serious problem is related to the the service requiring connections
from UI with impersonation allowed. Again, an unprivileged process
pretending to be the service could escalate privileges if an OpenVPNGUI
instance running as admin connects to it. This looks easy to exploit.

Possible mitigation:
(i) The GUI should not connect to the interactive service if running with
elevated privileges
(ii) openvpn.exe should not honor the --msg-channel option if running with
elevated privileges

Other comments I have are more specific to code snippets and of minor
consequence. Will send them after compile/test runs.

Selva

--001a113d3d02bac8a8052ab7f740
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I did some review over the weekend,=
 but haven&#39;t yet run the code, yet thought of sending these comments in=
 light of the Windows meeting today.<br><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Tue, Jan 26, 2016 at 2:11 PM, Gert <span>Doering<=
/span> &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank"><span>gert<=
/span>@<span>greenie</span>.<span>muc</span>.<span>de</span></a>&gt; wrote:=
<br>&gt;<br>&gt; From: <span>Heiko</span> <span>Hund</span> &lt;<a href=3D"=
mailto:heiko.hund@...1489..." target=3D"_blank"><span>heiko</span>.<span>hu=
nd</span>@<span>sophos</span>.com</a>&gt;<br>&gt;<br>&gt; v1: <span>Heiko</=
span> <span>Hund</span><br>&gt; =C2=A0- Message-ID: &lt;2215306.x9ci9DhAZ9@=
<span>de</span>-<span>gn</span>-40970&gt;<br>&gt; =C2=A0- extend <span>open=
vpn</span> service to provide &quot;automatic service&quot; and &quot;inter=
active<br>&gt; =C2=A0 =C2=A0service&quot; (which is used by GUI and <span>O=
penVPN</span> to run <span>openvpn</span> non-privileged<br>&gt; =C2=A0 =C2=
=A0and still be able to install routes and configure IPv6 addresses)<br>&gt=
; =C2=A0- add --<span>msg</span>-channel &lt;n&gt; option to <span>openvpn<=
/span> to tell it which pipe to use<br>&gt; =C2=A0 =C2=A0to talk to the int=
eractive service (used in tun.c for <span>ifconfig</span> + <span>ARP</span=
> flush,<br>&gt; =C2=A0 =C2=A0and route.c for routing)<br>&gt; =C2=A0- add =
<span>openvpn</span>-<span>msg</span>.h with message definitions for talkin=
g to interactive service<br>&gt; =C2=A0- routing in <span>openvpn</span> us=
es message-pipe automatically if --<span>msg</span>-channel &lt;n&gt; is<br=
>&gt; =C2=A0 =C2=A0configured, no other option needed<br>&gt; =C2=A0- today=
, the integration in route.c and tun.c is windows-only, but could be adapte=
d<br>&gt; =C2=A0 =C2=A0to other platforms<br><br><br>(snip)<br><br>&gt; =C2=
=A0<span>src</span>/<span>openvpnserv</span>/<span>Makefile</span>.am =C2=
=A0 | =C2=A0 14 +-<br>&gt; =C2=A0<span>src</span>/<span>openvpnserv</span>/=
automatic.c =C2=A0 | =C2=A0416 ++++++++++++++<div><br></div><div>The &quot;=
automatic service&quot; part is essentially the same code as the original e=
xcept for some mostly cosmetic changes and code re-organization. The change=
s are all good and makes the code leaner and cleaner.=C2=A0</div><div><br><=
/div><div>But it fixes none of the weaknesses of the original service.</div=
><div>=C2=A0</div><div>As suggested before, it would be better to make the =
interactive service a new executable without the automatic service function=
ality. Then the original service could be independently improved or replace=
d by something better (openvpnserv2, or whatever)</div><br>&gt; =C2=A0<span=
>src</span>/<span>openvpnserv</span>/common.c =C2=A0 =C2=A0 =C2=A0| =C2=A02=
11 +++++++<br>&gt; =C2=A0<span>src</span>/<span>openvpnserv</span>/interact=
ive.c | 1273 +++++++++++++++++++++++++++++++++++++++++<br><br><br>The new c=
ode implementing the interactive service looks good except for some possibl=
e security concerns.<div><br></div><div>First, the service starts <span>ope=
nvpn</span>.<span>exe</span> as user using a command line supplied by the u=
ser (say by a <span>UI</span> like <span>OpenVPNGUI</span>). The executable=
 name (<span>openvpn</span>.<span>exe</span>) itself is taken from the regi=
stry entry (<span>exe</span>_path) which is good, but the <span>UI</span> c=
an pass arbitrary options and specify the working directory. This means arb=
itrary <span>config</span> files can be passed as arguments to <span>openvp=
n</span>.<span>exe</span> enabling arbitrary routes to be set by an unprivi=
leged user using <span>config</span> file directives or command line option=
s.=C2=A0</div><div><br></div><div>While the whole purpose of the interactiv=
e service is to allow unprivileged users to set routes or do ifconfig, admi=
n users should have some ability to control what routes will be set or whic=
h remote servers will be connected to by unprivileged users. This requires =
two changes:</div><div><br></div><div>(1) the <span>config</span> file shou=
ld reside in some <span>pre</span>-defined location(s) controlled by, say, =
a registry key that only an admin user can change</div><div>(2) only a limi=
ted set of &quot;safe&quot; options may be allowed on the command line</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index b710c9c..6d97b4f 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -6015,6 +6015,24 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0#endif<br>
+=C2=A0 else if (streq (p[0], &quot;msg-channel&quot;) &amp;&amp; p[1])<br>
+=C2=A0 =C2=A0 {<br>
+#ifdef WIN32<br>
+=C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);<br>
+=C2=A0 =C2=A0 =C2=A0 HANDLE process =3D GetCurrentProcess ();<br>
+=C2=A0 =C2=A0 =C2=A0 HANDLE handle =3D (HANDLE) atoi (p[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 if (!DuplicateHandle (process, handle, process, &amp;=
options-&gt;msg_channel, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 FALSE, DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACC=
ESS))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (msglevel, &quot;could not duplicat=
e service pipe handle&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>The <spa=
n>msg</span>_channel handle is passed on to <span>openvpn</span>.<span>exe<=
/span> as a command line option, so it cannot trust it (could be that of a =
named pipe opened by a rogue process). This looks insecure ---- such a pipe=
 server could impersonate the user.</div><div><br></div><div>A more serious=
 problem is related to the the service requiring connections from <span>UI<=
/span> with impersonation allowed. Again, an unprivileged process pretendin=
g to be the service could escalate privileges if an <span>OpenVPNGUI</span>=
 instance running as admin connects to it. This looks easy to exploit.</div=
><div><br></div><div>Possible mitigation:=C2=A0</div><div>(i) The GUI shoul=
d not connect to the interactive service if running with elevated privilege=
s</div><div>(ii) <span>openvpn</span>.<span>exe</span> should not honor the=
 --<span>msg</span>-channel option if running with elevated privileges</div=
><div><br></div><div>Other comments I have are more specific to code snippe=
ts and of minor consequence. Will send them after compile/test runs.</div><=
div><br></div><div><span>Selva</span></div></div></div></div></div>

--001a113d3d02bac8a8052ab7f740--

