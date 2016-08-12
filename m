MIME-Version: 1.0
In-Reply-To: <1470926035-434-1-git-send-email-davids@...515...>
References: <1470684488-21307-5-git-send-email-davids@...515...>
	<1470926035-434-1-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Aug 2016 00:08:37 -0400
Message-ID: <CAKuzo_gROYTQLYrE=oep8ES6mDU_z6-KmgCEwhCVsdhyN46urg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0764169f55f20539d80a3f
Subject: Re: [Openvpn-devel] [PATCH v4.1] systemd: Do not mask usernames
 when querying for it via systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0764169f55f20539d80a3f
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 11, 2016 at 10:33 AM, David Sommerseth <davids@...515...>
wrote:

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
>   [v2 - Avoid pkg.m4 hacks and use pkgconfig/autoconf methods to flag
>         if systemd is recent enough for --echo support]
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  configure.ac                  | 6 ++++++
>  src/openvpn/console_systemd.c | 8 ++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index c3088fd..b2fa41c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1012,6 +1012,12 @@ if test "$enable_systemd" = "yes" ; then
>                        [],
>                        [PKG_CHECK_MODULES([libsystemd],
> [libsystemd-daemon])]
>                        )
> +
> +    PKG_CHECK_EXISTS( [libsystemd > 216],
> +                     [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],
> +                           [systemd is newer than v216])]
> +                    )
> +
>      AC_CHECK_HEADERS(systemd/sd-daemon.h,
>         ,
>         [
> diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
> index bf0f99d..f385c0c 100644
> --- a/src/openvpn/console_systemd.c
> +++ b/src/openvpn/console_systemd.c
> @@ -64,6 +64,14 @@ get_console_input_systemd (const char *prompt, const
> bool echo, char *input, con
>
>      argv_init (&argv);
>      argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
> +#ifdef SYSTEMD_NEWER_THAN_216
> +    /* the --echo support arrived in upstream systemd 217 */
> +    if( echo )
> +    {
> +       argv_printf_cat(&argv, "--echo");
> +    }
> +#endif
> +    argv_printf_cat (&argv, "--icon network-vpn");
>      argv_printf_cat (&argv, "%s", prompt);
>
>      if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
>
<http://sdm.link/zohodev2dev>
This looks much better now and works fine (tested without applying patches
1/4 and 2/4). ACK from me.

Selva

--94eb2c0764169f55f20539d80a3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Aug 11, 2016 at 10:33 AM, David Sommerseth <span dir=3D"ltr">&l=
t;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">In s=
ystemd after version 216, systemd-ask-password will support --echo which<br>
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
</span>=C2=A0 [v2 - Avoid pkg.m4 hacks and use pkgconfig/autoconf methods t=
o flag<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if systemd is recent enough for --echo support]=
<br>
<span class=3D""><br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515...">dav=
ids@...515...</a>&gt;<br>
---<br>
</span>=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 6 ++++++<br>
=C2=A0src/openvpn/console_systemd.c | 8 ++++++++<br>
=C2=A02 files changed, 14 insertions(+)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index c3088fd..b2fa41c 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -1012,6 +1012,12 @@ if test &quot;$enable_systemd&quot; =3D &quot;yes&qu=
ot; ; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0[],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0[PKG_CHECK_MODULES([<wbr>libsystemd], [libsystemd-daemon])]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0)<br>
+<br>
+=C2=A0 =C2=A0 PKG_CHECK_EXISTS( [libsystemd &gt; 216],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0[AC_DEFINE([SYSTEMD_NEWER_<wbr>THAN_216], [1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0[systemd is newer than v216])]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
=C2=A0 =C2=A0 =C2=A0AC_CHECK_HEADERS(systemd/sd-<wbr>daemon.h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [<br>
diff --git a/src/openvpn/console_systemd.<wbr>c b/src/openvpn/console_syste=
md.<wbr>c<br>
index bf0f99d..f385c0c 100644<br>
--- a/src/openvpn/console_systemd.<wbr>c<br>
+++ b/src/openvpn/console_systemd.<wbr>c<br>
@@ -64,6 +64,14 @@ get_console_input_systemd (const char *prompt, const boo=
l echo, char *input, con<br>
<span class=3D""><br>
=C2=A0 =C2=A0 =C2=A0argv_init (&amp;argv);<br>
=C2=A0 =C2=A0 =C2=A0argv_printf (&amp;argv, SYSTEMD_ASK_PASSWORD_PATH);<br>
</span>+#ifdef SYSTEMD_NEWER_THAN_216<br>
+=C2=A0 =C2=A0 /* the --echo support arrived in upstream systemd 217 */<br>
<div class=3D"HOEnZb"><div class=3D"h5">+=C2=A0 =C2=A0 if( echo )<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_printf_cat(&amp;argv, &quot;--echo&quot;);=
<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+=C2=A0 =C2=A0 argv_printf_cat (&amp;argv, &quot;--icon network-vpn&quot;);=
<br>
=C2=A0 =C2=A0 =C2=A0argv_printf_cat (&amp;argv, &quot;%s&quot;, prompt);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ((std_out =3D openvpn_popen (&amp;argv, NULL)) &lt; =
0) {<br></div></div></blockquote><a href=3D"http://sdm.link/zohodev2dev" re=
l=3D"noreferrer" target=3D"_blank"></a><br>This looks much better now and w=
orks fine (tested without applying patches 1/4 and 2/4). ACK from me.<br><b=
r></div><div class=3D"gmail_quote">Selva<br></div></div></div>

--94eb2c0764169f55f20539d80a3f--

