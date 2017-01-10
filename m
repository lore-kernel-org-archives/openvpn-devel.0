MIME-Version: 1.0
In-Reply-To: <20170109201634.GA76307@...1296...>
References: <d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
	<e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
	<CAFHpkQFo-W_4_1_6vmBaDfLk8nTHE_=uCi7ZcGES+1iq0sTKxA@...278...>
	<ad02b1ab-1552-7108-e951-65daa05a6680@...2080...>
	<20161219154649.GG78624@...1296...>
	<20170109201634.GA76307@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 10 Jan 2017 12:07:31 +0500
Message-ID: <CAFHpkQFGXEVr3ADo+J9t7DjrQC05P0YYe9kFVq2YRFD==NR3zQ@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4e4675c20545b823a1
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
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

--047d7bf10b4e4675c20545b823a1
Content-Type: text/plain; charset=UTF-8

2017-01-10 1:16 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, Dec 19, 2016 at 04:46:49PM +0100, Gert Doering wrote:
> > *Or* just check for GNU ld, and disable cmocka testing if that's not
> > available - we already have a check in there that talks about
> > "checking for ld used by $CC", which seems to result in
> >
> >   "with_gnu_ld=yes"
> >
> > if, well, GNU ld is used.  So the cmocka init part could just add a
> > check
> >
> >    if [ yes != "$with_gnu_ld" ] ...
> >
> > and set CMOCKA_INITIALIZED to "false".  Done.
>
> Trying this avenue.  Configure.ac looks reasonable, the resulting
> configure script is a nightmare on steroids, but that wasn't *my* doing
> (AM_CONDITIONAL() does some really crazy stuff).
>
> Arne or Ilya, could you test this on MacOS and/or Travis?  I do not
> have a working OSX 10.11 build environment right now, so this is
> "tested on linux" only - it's not breaking things here, but I can't
> see if it fixes OSX breakage.
>


I do not have OSX10 neither :-)

https://github.com/chipitsine/openvpn/commit/16a91484e640ed12680dc79faf7675bf70fc21a5
https://travis-ci.org/chipitsine/openvpn/builds/190515718

OSX10 is ok, you can merge it.

I will resolve other "red" things today



>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--047d7bf10b4e4675c20545b823a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-10 1:16 GMT+05:00 Gert Doering <span dir=3D"ltr">&lt;<a href=3D=
"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On Mon, Dec 19, 2016 at 04:46:49PM +0100, Gert Doering wrote:<br>
&gt; *Or* just check for GNU ld, and disable cmocka testing if that&#39;s n=
ot<br>
&gt; available - we already have a check in there that talks about<br>
&gt; &quot;checking for ld used by $CC&quot;, which seems to result in<br>
&gt;<br>
&gt;=C2=A0 =C2=A0&quot;with_gnu_ld=3Dyes&quot;<br>
&gt;<br>
&gt; if, well, GNU ld is used.=C2=A0 So the cmocka init part could just add=
 a<br>
&gt; check<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 if [ yes !=3D &quot;$with_gnu_ld&quot; ] ...<br>
&gt;<br>
&gt; and set CMOCKA_INITIALIZED to &quot;false&quot;.=C2=A0 Done.<br>
<br>
</span>Trying this avenue.=C2=A0 Configure.ac looks reasonable, the resulti=
ng<br>
configure script is a nightmare on steroids, but that wasn&#39;t *my* doing=
<br>
(AM_CONDITIONAL() does some really crazy stuff).<br>
<br>
Arne or Ilya, could you test this on MacOS and/or Travis?=C2=A0 I do not<br>
have a working OSX 10.11 build environment right now, so this is<br>
&quot;tested on linux&quot; only - it&#39;s not breaking things here, but I=
 can&#39;t<br>
see if it fixes OSX breakage.<br></blockquote><div><br><br></div><div>I do =
not have OSX10 neither :-)<br><br><a href=3D"https://github.com/chipitsine/=
openvpn/commit/16a91484e640ed12680dc79faf7675bf70fc21a5">https://github.com=
/chipitsine/openvpn/commit/16a91484e640ed12680dc79faf7675bf70fc21a5</a><br>=
<a href=3D"https://travis-ci.org/chipitsine/openvpn/builds/190515718">https=
://travis-ci.org/chipitsine/openvpn/builds/190515718</a><br><br></div><div>=
OSX10 is ok, you can merge it.<br><br></div><div>I will resolve other &quot=
;red&quot; things today<br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/%7Egert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de=
/~gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</div></div></blockquote></div><br></div></div>

--047d7bf10b4e4675c20545b823a1--

