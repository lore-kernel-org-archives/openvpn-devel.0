MIME-Version: 1.0
In-Reply-To: <CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
References: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
	<CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 23 Jun 2016 00:23:20 +0500
Message-ID: <CAFHpkQGFnPgNGXnasM5Tcwbx1yMdYuRes3+cvpNnb=Gq+=obpQ@...278...>
Content-Type: multipart/alternative; boundary=001a11c3af2ed98d770535e2de27
Subject: Re: [Openvpn-devel] what is the best way of skipping tests when
 openvpn configured --disable-crypto ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c3af2ed98d770535e2de27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

like that ?

diff --git a/configure.ac b/configure.ac
index d733023..dc95123 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1192,6 +1192,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" =3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}"
=3D "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test
"${enable_plugin_down_root}" =3D "yes"])
+AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])

 plugindir=3D"${with_plugindir}"
 sampledir=3D"\$(docdir)/sample"
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2cba9e6..235cd13 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,7 +14,10 @@ MAINTAINERCLEANFILES =3D \

 SUBDIRS =3D unit_tests

-test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
+test_scripts =3D t_client.sh
+if ENABLE_CRYPTO
+test_scripts +=3D t_lpback.sh t_cltsrv.sh
+endif

 TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
 TESTS =3D $(test_scripts)


2016-06-19 15:37 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On Sun, Jun 19, 2016 at 10:41 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
> > when playing with travis-ci, I encountered that t_lpback.sh and
> t_cltsrv.sh
> > fails on "make check" if openvpn is configured with --disable-crypto
> > (because --genkey is not available)
> >
> > what would be the best ?
> >
> > 1) run 'openvpn --help' and grep for --genkey ?
> > 2) check exit code of 'openvpn --genkey' ?
> > 3) run 'openvpn --show-ciphers' and see it is empty ?
> > 4) somehow determine exact configure options ? (I haven't found a way
> yet)
>
> I think 4.  You can use AC_SUBST to pass the value of $enable_crypto
> to a Makefile.am, and just not run the t_client.sh, t_lpback.sh and
> t_cltsrv.sh if it is 'no'.
>
> Later on, we might want to add a test that verifies correct behaviour
> of openvpn-without-crypto.
>
> -Steffan
>

--001a11c3af2ed98d770535e2de27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">like that ?<br><br>diff --git a/<a href=3D"http://configur=
e.ac">configure.ac</a> b/<a href=3D"http://configure.ac">configure.ac</a><b=
r>index d733023..dc95123 100644<br>--- a/<a href=3D"http://configure.ac">co=
nfigure.ac</a><br>+++ b/<a href=3D"http://configure.ac">configure.ac</a><br=
>@@ -1192,6 +1192,7 @@ AM_CONDITIONAL([WIN32], [test &quot;${WIN32}&quot; =
=3D &quot;yes&quot;])<br>=C2=A0AM_CONDITIONAL([GIT_CHECKOUT], [test &quot;$=
{GIT_CHECKOUT}&quot; =3D &quot;yes&quot;])<br>=C2=A0AM_CONDITIONAL([ENABLE_=
PLUGIN_AUTH_PAM], [test &quot;${enable_plugin_auth_pam}&quot; =3D &quot;yes=
&quot;])<br>=C2=A0AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test &quot;${e=
nable_plugin_down_root}&quot; =3D &quot;yes&quot;])<br>+AM_CONDITIONAL([ENA=
BLE_CRYPTO], [test &quot;${enable_crypto}&quot; =3D &quot;yes&quot;])<br>=
=C2=A0<br>=C2=A0plugindir=3D&quot;${with_plugindir}&quot;<br>=C2=A0sampledi=
r=3D&quot;\$(docdir)/sample&quot;<br>diff --git a/tests/Makefile.am b/tests=
/Makefile.am<br>index 2cba9e6..235cd13 100644<br>--- a/tests/Makefile.am<br=
>+++ b/tests/Makefile.am<br>@@ -14,7 +14,10 @@ MAINTAINERCLEANFILES =3D \<b=
r>=C2=A0<br>=C2=A0SUBDIRS =3D unit_tests<br>=C2=A0<br>-test_scripts =3D t_c=
lient.sh t_lpback.sh t_cltsrv.sh<br>+test_scripts =3D t_client.sh<br>+if EN=
ABLE_CRYPTO<br>+test_scripts +=3D t_lpback.sh t_cltsrv.sh<br>+endif<br>=C2=
=A0<br>=C2=A0TESTS_ENVIRONMENT =3D top_srcdir=3D&quot;$(top_srcdir)&quot;<b=
r>=C2=A0TESTS =3D $(test_scripts)<br><br></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">2016-06-19 15:37 GMT+05:00 Steffan Karger <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">=
steffan@...1856...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Sun, Jun 19, 2016 at 10:41 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chi=
pitsine@...277...</a>&gt; wrote:<br>
&gt; when playing with travis-ci, I encountered that t_lpback.sh and t_clts=
rv.sh<br>
&gt; fails on &quot;make check&quot; if openvpn is configured with --disabl=
e-crypto<br>
&gt; (because --genkey is not available)<br>
&gt;<br>
&gt; what would be the best ?<br>
&gt;<br>
&gt; 1) run &#39;openvpn --help&#39; and grep for --genkey ?<br>
&gt; 2) check exit code of &#39;openvpn --genkey&#39; ?<br>
&gt; 3) run &#39;openvpn --show-ciphers&#39; and see it is empty ?<br>
&gt; 4) somehow determine exact configure options ? (I haven&#39;t found a =
way yet)<br>
<br>
</span>I think 4.=C2=A0 You can use AC_SUBST to pass the value of $enable_c=
rypto<br>
to a Makefile.am, and just not run the t_client.sh, t_lpback.sh and<br>
t_cltsrv.sh if it is &#39;no&#39;.<br>
<br>
Later on, we might want to add a test that verifies correct behaviour<br>
of openvpn-without-crypto.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div>

--001a11c3af2ed98d770535e2de27--

