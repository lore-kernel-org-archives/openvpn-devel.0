MIME-Version: 1.0
In-Reply-To: <CAA1AbxJfdDMHV9PF1Qzpa1FhNBvwKfW-tnnM3w2AO0qh6x9moA@...278...>
References: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
	<CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
	<CAFHpkQGFnPgNGXnasM5Tcwbx1yMdYuRes3+cvpNnb=Gq+=obpQ@...278...>
	<CAA1AbxJfdDMHV9PF1Qzpa1FhNBvwKfW-tnnM3w2AO0qh6x9moA@...278...>
Date: Thu, 23 Jun 2016 07:30:47 +0500
Message-ID: <CAFHpkQGaUiGppt6b8r2F5qaQe7tpH5XyHPdqNPsX9bxcbT6oQA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=047d7b5d4fc28442750535e8d7c3
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
Cc: openvpn-devel@lists.sourceforge.net

--047d7b5d4fc28442750535e8d7c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I did tests. It does not run in case of --disable-crypto
23 =D0=B8=D1=8E=D0=BD=D1=8F 2016 =D0=B3. 1:42 =D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Steffan Karger" <steffan@...493...=
1856...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> On Wed, Jun 22, 2016 at 9:23 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
> > like that ?
> >
> > diff --git a/configure.ac b/configure.ac
> > index d733023..dc95123 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -1192,6 +1192,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes=
"])
> >  AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" =3D "yes"])
> >  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test
> "${enable_plugin_auth_pam}"
> > =3D "yes"])
> >  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test
> > "${enable_plugin_down_root}" =3D "yes"])
> > +AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" =3D "yes"])
> >
> >  plugindir=3D"${with_plugindir}"
> >  sampledir=3D"\$(docdir)/sample"
> > diff --git a/tests/Makefile.am b/tests/Makefile.am
> > index 2cba9e6..235cd13 100644
> > --- a/tests/Makefile.am
> > +++ b/tests/Makefile.am
> > @@ -14,7 +14,10 @@ MAINTAINERCLEANFILES =3D \
> >
> >  SUBDIRS =3D unit_tests
> >
> > -test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
> > +test_scripts =3D t_client.sh
> > +if ENABLE_CRYPTO
> > +test_scripts +=3D t_lpback.sh t_cltsrv.sh
> > +endif
> >
> >  TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
> >  TESTS =3D $(test_scripts)
>
> Ah, this is even cleaner than AC_SUBST.  But this matches what I had
> in mind, yes.  (I didn't test, but I assume this simply doesn't run
> these tests?)
>
> -Steffan
>

--047d7b5d4fc28442750535e8d7c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I did tests. It does not run in case of --disable-crypto</p>
<div class=3D"gmail_quote">23 =D0=B8=D1=8E=D0=BD=D1=8F 2016 =D0=B3. 1:42 =
=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &q=
uot;Steffan Karger&quot; &lt;<a href=3D"mailto:steffan@...1856...">steffan@=
...1856...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"a=
ttribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Wed, Jun 22, 2016 at 9:23 PM,=
 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a=
 href=3D"mailto:chipitsine@...277...">chipitsine@...277...</a>&gt; wrote:<b=
r>
&gt; like that ?<br>
&gt;<br>
&gt; diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=
=3D"_blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noref=
errer" target=3D"_blank">configure.ac</a><br>
&gt; index d733023..dc95123 100644<br>
&gt; --- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_bl=
ank">configure.ac</a><br>
&gt; +++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_bl=
ank">configure.ac</a><br>
&gt; @@ -1192,6 +1192,7 @@ AM_CONDITIONAL([WIN32], [test &quot;${WIN32}&quo=
t; =3D &quot;yes&quot;])<br>
&gt;=C2=A0 AM_CONDITIONAL([GIT_CHECKOUT], [test &quot;${GIT_CHECKOUT}&quot;=
 =3D &quot;yes&quot;])<br>
&gt;=C2=A0 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test &quot;${enable_pl=
ugin_auth_pam}&quot;<br>
&gt; =3D &quot;yes&quot;])<br>
&gt;=C2=A0 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test<br>
&gt; &quot;${enable_plugin_down_root}&quot; =3D &quot;yes&quot;])<br>
&gt; +AM_CONDITIONAL([ENABLE_CRYPTO], [test &quot;${enable_crypto}&quot; =
=3D &quot;yes&quot;])<br>
&gt;<br>
&gt;=C2=A0 plugindir=3D&quot;${with_plugindir}&quot;<br>
&gt;=C2=A0 sampledir=3D&quot;\$(docdir)/sample&quot;<br>
&gt; diff --git a/tests/Makefile.am b/tests/Makefile.am<br>
&gt; index 2cba9e6..235cd13 100644<br>
&gt; --- a/tests/Makefile.am<br>
&gt; +++ b/tests/Makefile.am<br>
&gt; @@ -14,7 +14,10 @@ MAINTAINERCLEANFILES =3D \<br>
&gt;<br>
&gt;=C2=A0 SUBDIRS =3D unit_tests<br>
&gt;<br>
&gt; -test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh<br>
&gt; +test_scripts =3D t_client.sh<br>
&gt; +if ENABLE_CRYPTO<br>
&gt; +test_scripts +=3D t_lpback.sh t_cltsrv.sh<br>
&gt; +endif<br>
&gt;<br>
&gt;=C2=A0 TESTS_ENVIRONMENT =3D top_srcdir=3D&quot;$(top_srcdir)&quot;<br>
&gt;=C2=A0 TESTS =3D $(test_scripts)<br>
<br>
Ah, this is even cleaner than AC_SUBST.=C2=A0 But this matches what I had<b=
r>
in mind, yes.=C2=A0 (I didn&#39;t test, but I assume this simply doesn&#39;=
t run<br>
these tests?)<br>
<br>
-Steffan<br>
</blockquote></div>

--047d7b5d4fc28442750535e8d7c3--

