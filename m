MIME-Version: 1.0
In-Reply-To: <1412688204-29265-2-git-send-email-openvpn.list@...1114...>
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
	<1412688204-29265-2-git-send-email-openvpn.list@...1114...>
Date: Tue, 7 Oct 2014 12:56:55 -0500
Message-ID: <CAE4D3A4_33FxfHx_qUF8QHaWd6TzaQqtkq8C317CnCrNXco4=w@...278...>
From: Jon Ciesla <limburgher@...277...>
Content-Type: multipart/alternative; boundary=047d7ba973dac857750504d8ecf6
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: Do not mask usernames when
 querying for it via systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7ba973dac857750504d8ecf6
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth <
openvpn.list@...1114...> wrote:

> From: David Sommerseth <davids@...1347...>
>
> In systemd after version 216, systemd-ask-password will support --echo
> which
> will avoid masking the user input.  As OpenVPN uses this mechanism
> collecting
> usernames when systemd is available, this will avoid the input of
> usernames to
> be masked.
>
> This patch also adds the --icon argument, which is aimed at graphical
> inputs.
> For example when OpenVPN is started at system boot-time using a graphical
> boot
> interface such as Plymouth.
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  configure.ac          | 1 +
>  src/openvpn/console.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 608ab6d..09f32d4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1017,6 +1017,7 @@ if test "$enable_systemd" = "yes" ; then
>      AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is
> missing sd_booted()])])
>      OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
>      AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
> +    AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [`echo
> ${libsystemd_MODVERSION}`], [systemd version installed])
>      LIBS="${saved_LIBS}"
>  fi
>
> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
> index d66d408..5d4d878 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -167,6 +167,14 @@ get_console_input_systemd (const char *prompt, const
> bool echo, char *input, con
>
>    argv_init (&argv);
>    argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
> +
> +#if SYSTEMD_VERSION > 216
> +  if( echo )
> +    {
> +      argv_printf_cat(&argv, "--echo");
> +    }
> +#endif
> +  argv_printf_cat (&argv, "--icon=network-wired");
>    argv_printf_cat (&argv, "%s", prompt);
>
>    if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
> --
> 1.8.3.1
>
>
>
> ------------------------------------------------------------------------------
> Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
> Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
> Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
>
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

ACK.  Enables systemd features on systemd systems, and looks like a no-op
on non-systemd systems.

-- 
http://cecinestpasunefromage.wordpress.com/
------------------------------------------------
in your fear, seek only peace
in your fear, seek only love

-d. bowie

--047d7ba973dac857750504d8ecf6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth <span dir=3D"ltr">&lt;=
<a href=3D"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.list@...220...=
..1114...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: David Sommerseth &lt;<a href=3D"mailto:davids@...1347...">=
davids@...1347...</a>&gt;<br>
<br>
In systemd after version 216, systemd-ask-password will support --echo whic=
h<br>
will avoid masking the user input.=C2=A0 As OpenVPN uses this mechanism col=
lecting<br>
usernames when systemd is available, this will avoid the input of usernames=
 to<br>
be masked.<br>
<br>
This patch also adds the --icon argument, which is aimed at graphical input=
s.<br>
For example when OpenVPN is started at system boot-time using a graphical b=
oot<br>
interface such as Plymouth.<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...1347...">da=
vids@...1347...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0src/openvpn/console.c | 8 ++++++++<br>
=C2=A02 files changed, 9 insertions(+)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac=
</a> b/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a><b=
r>
index 608ab6d..09f32d4 100644<br>
--- a/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a><br>
@@ -1017,6 +1017,7 @@ if test &quot;$enable_systemd&quot; =3D &quot;yes&quo=
t; ; then<br>
=C2=A0 =C2=A0 =C2=A0AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd =
library is missing sd_booted()])])<br>
=C2=A0 =C2=A0 =C2=A0OPTIONAL_SYSTEMD_LIBS=3D&quot;${libsystemd_LIBS}&quot;<=
br>
=C2=A0 =C2=A0 =C2=A0AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integratio=
n])<br>
+=C2=A0 =C2=A0 AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [`echo ${libsystemd_MODV=
ERSION}`], [systemd version installed])<br>
=C2=A0 =C2=A0 =C2=A0LIBS=3D&quot;${saved_LIBS}&quot;<br>
=C2=A0fi<br>
<br>
diff --git a/src/openvpn/console.c b/src/openvpn/console.c<br>
index d66d408..5d4d878 100644<br>
--- a/src/openvpn/console.c<br>
+++ b/src/openvpn/console.c<br>
@@ -167,6 +167,14 @@ get_console_input_systemd (const char *prompt, const b=
ool echo, char *input, con<br>
<br>
=C2=A0 =C2=A0argv_init (&amp;argv);<br>
=C2=A0 =C2=A0argv_printf (&amp;argv, SYSTEMD_ASK_PASSWORD_PATH);<br>
+<br>
+#if SYSTEMD_VERSION &gt; 216<br>
+=C2=A0 if( echo )<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 argv_printf_cat(&amp;argv, &quot;--echo&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+=C2=A0 argv_printf_cat (&amp;argv, &quot;--icon=3Dnetwork-wired&quot;);<br>
=C2=A0 =C2=A0argv_printf_cat (&amp;argv, &quot;%s&quot;, prompt);<br>
<br>
=C2=A0 =C2=A0if ((std_out =3D openvpn_popen (&amp;argv, NULL)) &lt; 0) {<br>
--<br>
1.8.3.1<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer<br>
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports<br>
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper<br>
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D154622311&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D154622311&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br>ACK.=C2=A0 Enables systemd features on systemd syste=
ms, and looks like a no-op on non-systemd systems.<br clear=3D"all"><br>-- =
<br><a href=3D"http://cecinestpasunefromage.wordpress.com/" target=3D"_blan=
k">http://cecinestpasunefromage.wordpress.com/</a><br>---------------------=
---------------------------<br>in your fear, seek only peace<br>in your fea=
r, seek only love<br><br>-d. bowie
</div></div>

--047d7ba973dac857750504d8ecf6--

