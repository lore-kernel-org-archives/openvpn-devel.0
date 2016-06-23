MIME-Version: 1.0
In-Reply-To: <20160623113226.GD79504@...1296...>
References: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
	<CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
	<CAFHpkQGFnPgNGXnasM5Tcwbx1yMdYuRes3+cvpNnb=Gq+=obpQ@...278...>
	<CAA1AbxJfdDMHV9PF1Qzpa1FhNBvwKfW-tnnM3w2AO0qh6x9moA@...278...>
	<20160623113226.GD79504@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 23 Jun 2016 18:16:00 +0500
Message-ID: <CAFHpkQEJxw40cmY1Daz7yfBnJLuMQRQXZt1nvuEBxM7hwwc+1Q@...278...>
Content-Type: multipart/alternative; boundary=089e0122f53aff413c0535f1da84
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0122f53aff413c0535f1da84
Content-Type: text/plain; charset=UTF-8

I'm afraid people do not pay attention to output.
if build doesn't fail, why should they ?

I can add that message, even make it any colour.

2016-06-23 16:32 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Wed, Jun 22, 2016 at 10:41:48PM +0200, Steffan Karger wrote:
> > > -test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
> > > +test_scripts = t_client.sh
> > > +if ENABLE_CRYPTO
> > > +test_scripts += t_lpback.sh t_cltsrv.sh
> > > +endif
> > >
> > >  TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
> > >  TESTS = $(test_scripts)
> >
> > Ah, this is even cleaner than AC_SUBST.  But this matches what I had
> > in mind, yes.  (I didn't test, but I assume this simply doesn't run
> > these tests?)
>
> make will not even know that these tests exist, so "doesn't run these
> tests", yes :-)
>
> I *am* wondering if there is a clever way to print out "not running self
> tests due to lack of --disable-crypto", so people are made aware that
> this is less well tested...
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>

--089e0122f53aff413c0535f1da84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I&#39;m afraid people do not pay attention to ou=
tput.<br></div>if build doesn&#39;t fail, why should they ?<br><br></div>I =
can add that message, even make it any colour.<br></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">2016-06-23 16:32 GMT+05:00 Gert Doer=
ing <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_bla=
nk">gert@...1296...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<b=
r>
<span class=3D""><br>
On Wed, Jun 22, 2016 at 10:41:48PM +0200, Steffan Karger wrote:<br>
&gt; &gt; -test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh<br>
&gt; &gt; +test_scripts =3D t_client.sh<br>
&gt; &gt; +if ENABLE_CRYPTO<br>
&gt; &gt; +test_scripts +=3D t_lpback.sh t_cltsrv.sh<br>
&gt; &gt; +endif<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 TESTS_ENVIRONMENT =3D top_srcdir=3D&quot;$(top_srcdir)&quot=
;<br>
&gt; &gt;=C2=A0 TESTS =3D $(test_scripts)<br>
&gt;<br>
&gt; Ah, this is even cleaner than AC_SUBST.=C2=A0 But this matches what I =
had<br>
&gt; in mind, yes.=C2=A0 (I didn&#39;t test, but I assume this simply doesn=
&#39;t run<br>
&gt; these tests?)<br>
<br>
</span>make will not even know that these tests exist, so &quot;doesn&#39;t=
 run these<br>
tests&quot;, yes :-)<br>
<br>
I *am* wondering if there is a clever way to print out &quot;not running se=
lf<br>
tests due to lack of --disable-crypto&quot;, so people are made aware that<=
br>
this is less well tested...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</font></span></blockquote></div><br></div>

--089e0122f53aff413c0535f1da84--

