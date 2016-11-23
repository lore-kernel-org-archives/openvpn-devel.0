MIME-Version: 1.0
In-Reply-To: <CAFHpkQGVArCBW7h=9k8-ycWxyugDKG0VEi5wyZi65P5M72+GmA@...278...>
References: <CAFHpkQFj1ATTbGz5Nic2EKQJh2kZxXfVBZPoMvFOUFvfdhBtjg@...278...>
	<CAKuzo_iXDpmNmNH2_ZmJSSRZYTKpRik6o1U744vNLtzhwM6noQ@...278...>
	<20161121075320.GE28918@...1296...>
	<CAFHpkQGfY4Cy4wnG+zt4Y_XssPac1DVywP=DdCLGY_jWwXZ4aw@...278...>
	<ca5cb614-d190-521b-d376-7c0c6a2df48a@...2080...>
	<CAFHpkQEkYsioMuC3shRU7_ncU0=JjPCZ1R=qTq+oDU7C42X+Kw@...278...>
	<b730e9e5-d233-fa43-7e6b-6accfaa689bd@...515...>
	<CAFHpkQGVArCBW7h=9k8-ycWxyugDKG0VEi5wyZi65P5M72+GmA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 23 Nov 2016 15:00:26 +0500
Message-ID: <CAFHpkQEB2MKsMXZr+F-gcFkuOk+0NVFkCGcMtENJO+=aP1cKaA@...278...>
Content-Type: multipart/alternative; boundary=001a114b3de85056550541f4f500
Subject: Re: [Openvpn-devel] handle unsupported windows versions in installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b3de85056550541f4f500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

here's new PR

https://github.com/OpenVPN/openvpn-build/pull/52

it is tricky to add http link to message box, I'd avoid using nsDialogs.nsh
now

2016-11-21 16:21 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

>
>
> 2016-11-21 16:14 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> Il 21/11/2016 11:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD ha scritto:
>>
>>> as we will make it hard coded within installer, so, if "WinXP installer
>>> link" will ever change, there'll be no way to change it in installer,
>>> which were downloaded (as for our company, I can confirm such practice,
>>> people download installer and put on smb shares, wiki, etc)
>>>
>>> so, which is the proper link to "the latest WinXP installer", which is
>>> frozen for ever.
>>>
>>
>> Right now there is no proper link. We have a bunch of static links here:
>>
>> <http://build.openvpn.net/downloads/releases/latest/>
>>
>> I could add two more links tailored for Windows XP, e.g.
>>
>> openvpn-install-latest-winxp-i686.exe
>> openvpn-install-latest-winxp-x86_64.exe
>>
>
> I meant that for "url rewrite".
> ok, it is good
>
>
>>
>> Then we could link to those in the installer, and the links would "never"
>> break.
>>
>> Thoughts?
>>
>>
>>> 2016-11-21 14:21 GMT+05:00 David Sommerseth
>>> <openvpn@...2080...
>>> <mailto:openvpn@...2080...>>:
>>>
>>>     -----BEGIN PGP SIGNED MESSAGE-----
>>>     Hash: SHA1
>>>
>>>     On 21/11/16 08:57, ???? ??????? wrote:
>>>     > @mattock , can we use some url rewrite for that ?
>>>
>>>     URL rewrite?  As on the web server?  I think that is a very bad ide=
a.
>>>      If you want to download a particular file, you should get what you
>>>     ask for.  The web server should not try to outsmart the user.
>>>
>>>     However, how I understand Selva (and Gerts approval), is that the
>>>     *installer* can displaying the v2.3 download URL - and perhaps even
>>>     downloading it (on request).
>>>
>>>
>>>     - --
>>>     kind regards,
>>>
>>>     David Sommerseth
>>>     OpenVPN Technologies, Inc
>>>
>>>
>>>
>>>     > 2016-11-21 12:53 GMT+05:00 Gert Doering <gert@...1296...
>>> <mailto:gert@...1296...>
>>>     > <mailto:gert@...1296... <mailto:gert@...1296...>>>:
>>>     >
>>>     > Hi,
>>>     >
>>>     > On Sun, Nov 20, 2016 at 11:02:33PM -0500, Selva Nair wrote:
>>>     >> As for 2.4 installer, if run on XP, showing a link to the  latest
>>>     >> 2.3.x before bailing out is a nice thing to do. If its not too
>>>     >> much work, I would vote for offering to download the installer as
>>>     >> well.
>>>     >
>>>     > This sounds good, yes.
>>>     >
>>>     > gert
>>>
>>>     -----BEGIN PGP SIGNATURE-----
>>>     Version: GnuPG v2.0.22 (GNU/Linux)
>>>
>>>     iQIcBAEBAgAGBQJYMrywAAoJEIbPlEyWcf3yGvEP/2kejd40OfjkXorkKyoCQ/LD
>>>     XZGJmZxstOSiEc//Y+7l5TcUWcDdklXjZU2DKBhEpV6RyzhzFI9Hj4IIiDtPj3EB
>>>     c2u5xzm99RJe40LVWNGZnVailgTjg6epWyYsGXeMZVHVA+GBVKEtWQJelo4Jcb/i
>>>     96+ElSUrqGTCBc993MTSzh6ejFSdkyFR5mLK9wGlgLamasim0d1Hd57LN4m9+221
>>>     QR5+PIQFCKzmOZhcFDmFBuZsjxpsNqf65Lw1dUSyekIJC49OLd3f11nancJ6nqhO
>>>     EwqS2OeM2ZKHjgLuQcGivJiZ3VbO+UFzP8d91w+r+463+xuoGzce+B/i9QcDxrLz
>>>     pi9+xfD5n+xLPQCcSOv1ALfZWSstT9N3RN9fTocE+NUlJ5y2t8FqoIhjL/5InR1r
>>>     mBbtcs+Bw4+hjCKQpRtkcIgkRtXrYm7wjZx79xeAAqNSYuz/fvROnhvyjUfcozGw
>>>     YVSER+ZwB3jBnJZ/ECTTYUz6Tzsimz6B7pRZCjrgW807jm3UJXex13wwU8fjvIF2
>>>     e06+E/tbSbRlfNeq6tZagWZMJOkHDu1EEEm0v2n7KP/vBXFWFUeM7tzJplXq42Fk
>>>     FzKMbLPBqXda/3VgjZFFD75/bK+zZYS6kG4xVvabqQkw8m7lAf1jRTKbgy7Fo2YX
>>>     n376Jqybah631uigBdPe
>>>     =3DKzt/
>>>     -----END PGP SIGNATURE-----
>>>
>>>
>>>
>>>
>>> ------------------------------------------------------------
>>> ------------------
>>>
>>>
>>>
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>>
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>
>

--001a114b3de85056550541f4f500
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>hello,<br><br></div>here&#39;s new PR<br><br><a =
href=3D"https://github.com/OpenVPN/openvpn-build/pull/52">https://github.co=
m/OpenVPN/openvpn-build/pull/52</a><br><br></div>it is tricky to add http l=
ink to message box, I&#39;d avoid using nsDialogs.nsh now<br></div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-11-21 16:21 GMT+05:0=
0 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">=
chipitsine@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
<span class=3D"">2016-11-21 16:14 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=
=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...220...=
..515...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>Il 21/11/2=
016 11:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD ha scritto:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
as we will make it hard coded within installer, so, if &quot;WinXP installe=
r<br>
link&quot; will ever change, there&#39;ll be no way to change it in install=
er,<br>
which were downloaded (as for our company, I can confirm such practice,<br>
people download installer and put on smb shares, wiki, etc)<br>
<br>
so, which is the proper link to &quot;the latest WinXP installer&quot;, whi=
ch is<br>
frozen for ever.<br>
</blockquote>
<br></span>
Right now there is no proper link. We have a bunch of static links here:<br>
<br>
&lt;<a href=3D"http://build.openvpn.net/downloads/releases/latest/" rel=3D"=
noreferrer" target=3D"_blank">http://build.openvpn.net/down<wbr>loads/relea=
ses/latest/</a>&gt;<br>
<br>
I could add two more links tailored for Windows XP, e.g.<br>
<br>
openvpn-install-latest-winxp-i<wbr>686.exe<br>
openvpn-install-latest-winxp-x<wbr>86_64.exe<br></blockquote><div><br></div=
></span><div>I meant that for &quot;url rewrite&quot;.<br></div><div>ok, it=
 is good<br></div><div><div class=3D"h5"><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Then we could link to those in the installer, and the links would &quot;nev=
er&quot; break.<br>
<br>
Thoughts?<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span>
<br>
2016-11-21 14:21 GMT+05:00 David Sommerseth<br>
&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2193...=
...<wbr>.net</a><br></span>
&lt;mailto:<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@=
...2157...<wbr>emmelig.net</a>&gt;&gt;:<span><br>
<br>
=C2=A0 =C2=A0 -----BEGIN PGP SIGNED MESSAGE-----<br>
=C2=A0 =C2=A0 Hash: SHA1<br>
<br>
=C2=A0 =C2=A0 On 21/11/16 08:57, ???? ??????? wrote:<br>
=C2=A0 =C2=A0 &gt; @mattock , can we use some url rewrite for that ?<br>
<br>
=C2=A0 =C2=A0 URL rewrite?=C2=A0 As on the web server?=C2=A0 I think that i=
s a very bad idea.<br>
=C2=A0 =C2=A0 =C2=A0If you want to download a particular file, you should g=
et what you<br>
=C2=A0 =C2=A0 ask for.=C2=A0 The web server should not try to outsmart the =
user.<br>
<br>
=C2=A0 =C2=A0 However, how I understand Selva (and Gerts approval), is that=
 the<br>
=C2=A0 =C2=A0 *installer* can displaying the v2.3 download URL - and perhap=
s even<br>
=C2=A0 =C2=A0 downloading it (on request).<br>
<br>
<br>
=C2=A0 =C2=A0 - --<br>
=C2=A0 =C2=A0 kind regards,<br>
<br>
=C2=A0 =C2=A0 David Sommerseth<br>
=C2=A0 =C2=A0 OpenVPN Technologies, Inc<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 &gt; 2016-11-21 12:53 GMT+05:00 Gert Doering &lt;<a href=3D"m=
ailto:gert@...1296..." target=3D"_blank">gert@...1296...</a> &lt;mailto:<a =
href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;<b=
r></span>
=C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:gert@...1296..." target=3D"=
_blank">gert@...1296...</a> &lt;mailto:<a href=3D"mailto:gert@...1296..." t=
arget=3D"_blank">gert@...1296...</a>&gt;&gt;&gt;<wbr>:<span><br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; Hi,<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; On Sun, Nov 20, 2016 at 11:02:33PM -0500, Selva Nair wro=
te:<br>
=C2=A0 =C2=A0 &gt;&gt; As for 2.4 installer, if run on XP, showing a link t=
o the=C2=A0 latest<br>
=C2=A0 =C2=A0 &gt;&gt; 2.3.x before bailing out is a nice thing to do. If i=
ts not too<br>
=C2=A0 =C2=A0 &gt;&gt; much work, I would vote for offering to download the=
 installer as<br>
=C2=A0 =C2=A0 &gt;&gt; well.<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; This sounds good, yes.<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; gert<br>
<br>
=C2=A0 =C2=A0 -----BEGIN PGP SIGNATURE-----<br>
=C2=A0 =C2=A0 Version: GnuPG v2.0.22 (GNU/Linux)<br>
<br>
=C2=A0 =C2=A0 iQIcBAEBAgAGBQJYMrywAAoJEIbPlE<wbr>yWcf3yGvEP/2kejd40OfjkXork=
KyoC<wbr>Q/LD<br>
=C2=A0 =C2=A0 XZGJmZxstOSiEc//Y+7l5TcUWcDdkl<wbr>XjZU2DKBhEpV6RyzhzFI9Hj4II=
iDtP<wbr>j3EB<br>
=C2=A0 =C2=A0 c2u5xzm99RJe40LVWNGZnVailgTjg6<wbr>epWyYsGXeMZVHVA+GBVKEtWQJe=
lo4J<wbr>cb/i<br>
=C2=A0 =C2=A0 96+ElSUrqGTCBc993MTSzh6ejFSdky<wbr>FR5mLK9wGlgLamasim0d1Hd57L=
N4m9<wbr>+221<br>
=C2=A0 =C2=A0 QR5+PIQFCKzmOZhcFDmFBuZsjxpsNq<wbr>f65Lw1dUSyekIJC49OLd3f11na=
ncJ6<wbr>nqhO<br>
=C2=A0 =C2=A0 EwqS2OeM2ZKHjgLuQcGivJiZ3VbO+U<wbr>FzP8d91w+r+463+xuoGzce+B/i=
9QcD<wbr>xrLz<br>
=C2=A0 =C2=A0 pi9+xfD5n+xLPQCcSOv1ALfZWSstT9<wbr>N3RN9fTocE+NUlJ5y2t8FqoIhj=
L/5I<wbr>nR1r<br>
=C2=A0 =C2=A0 mBbtcs+Bw4+hjCKQpRtkcIgkRtXrYm<wbr>7wjZx79xeAAqNSYuz/fvROnhvy=
jUfc<wbr>ozGw<br>
=C2=A0 =C2=A0 YVSER+ZwB3jBnJZ/ECTTYUz6Tzsimz<wbr>6B7pRZCjrgW807jm3UJXex13ww=
U8fj<wbr>vIF2<br>
=C2=A0 =C2=A0 e06+E/tbSbRlfNeq6tZagWZMJOkHDu<wbr>1EEEm0v2n7KP/vBXFWFUeM7tzJ=
plXq<wbr>42Fk<br>
=C2=A0 =C2=A0 FzKMbLPBqXda/3VgjZFFD75/bK+zZY<wbr>S6kG4xVvabqQkw8m7lAf1jRTKb=
gy7F<wbr>o2YX<br>
=C2=A0 =C2=A0 n376Jqybah631uigBdPe<br>
=C2=A0 =C2=A0 =3DKzt/<br>
=C2=A0 =C2=A0 -----END PGP SIGNATURE-----<br>
<br>
<br>
<br>
<br></span>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
<br>
<br>
<br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br><span class=3D"m_1445507817153259501HOEnZb"><font color=3D"#888888">
</font></span></blockquote><span class=3D"m_1445507817153259501HOEnZb"><fon=
t color=3D"#888888">
<br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div></div></div><br></div></div>
</blockquote></div><br></div>

--001a114b3de85056550541f4f500--

