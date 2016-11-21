MIME-Version: 1.0
In-Reply-To: <ca5cb614-d190-521b-d376-7c0c6a2df48a@...2080...>
References: <CAFHpkQFj1ATTbGz5Nic2EKQJh2kZxXfVBZPoMvFOUFvfdhBtjg@...278...>
	<CAKuzo_iXDpmNmNH2_ZmJSSRZYTKpRik6o1U744vNLtzhwM6noQ@...278...>
	<20161121075320.GE28918@...1296...>
	<CAFHpkQGfY4Cy4wnG+zt4Y_XssPac1DVywP=DdCLGY_jWwXZ4aw@...278...>
	<ca5cb614-d190-521b-d376-7c0c6a2df48a@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 21 Nov 2016 14:34:27 +0500
Message-ID: <CAFHpkQEkYsioMuC3shRU7_ncU0=JjPCZ1R=qTq+oDU7C42X+Kw@...278...>
Content-Type: multipart/alternative; boundary=001a1144232eb07cad0541cc5cbe
Subject: Re: [Openvpn-devel] handle unsupported windows versions in installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144232eb07cad0541cc5cbe
Content-Type: text/plain; charset=UTF-8

as we will make it hard coded within installer, so, if "WinXP installer
link" will ever change, there'll be no way to change it in installer, which
were downloaded (as for our company, I can confirm such practice, people
download installer and put on smb shares, wiki, etc)

so, which is the proper link to "the latest WinXP installer", which is
frozen for ever.

2016-11-21 14:21 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 21/11/16 08:57, ???? ??????? wrote:
> > @mattock , can we use some url rewrite for that ?
>
> URL rewrite?  As on the web server?  I think that is a very bad idea.
>  If you want to download a particular file, you should get what you
> ask for.  The web server should not try to outsmart the user.
>
> However, how I understand Selva (and Gerts approval), is that the
> *installer* can displaying the v2.3 download URL - and perhaps even
> downloading it (on request).
>
>
> - --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>
> > 2016-11-21 12:53 GMT+05:00 Gert Doering <gert@...1296...
> > <mailto:gert@...1296...>>:
> >
> > Hi,
> >
> > On Sun, Nov 20, 2016 at 11:02:33PM -0500, Selva Nair wrote:
> >> As for 2.4 installer, if run on XP, showing a link to the  latest
> >> 2.3.x before bailing out is a nice thing to do. If its not too
> >> much work, I would vote for offering to download the installer as
> >> well.
> >
> > This sounds good, yes.
> >
> > gert
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.22 (GNU/Linux)
>
> iQIcBAEBAgAGBQJYMrywAAoJEIbPlEyWcf3yGvEP/2kejd40OfjkXorkKyoCQ/LD
> XZGJmZxstOSiEc//Y+7l5TcUWcDdklXjZU2DKBhEpV6RyzhzFI9Hj4IIiDtPj3EB
> c2u5xzm99RJe40LVWNGZnVailgTjg6epWyYsGXeMZVHVA+GBVKEtWQJelo4Jcb/i
> 96+ElSUrqGTCBc993MTSzh6ejFSdkyFR5mLK9wGlgLamasim0d1Hd57LN4m9+221
> QR5+PIQFCKzmOZhcFDmFBuZsjxpsNqf65Lw1dUSyekIJC49OLd3f11nancJ6nqhO
> EwqS2OeM2ZKHjgLuQcGivJiZ3VbO+UFzP8d91w+r+463+xuoGzce+B/i9QcDxrLz
> pi9+xfD5n+xLPQCcSOv1ALfZWSstT9N3RN9fTocE+NUlJ5y2t8FqoIhjL/5InR1r
> mBbtcs+Bw4+hjCKQpRtkcIgkRtXrYm7wjZx79xeAAqNSYuz/fvROnhvyjUfcozGw
> YVSER+ZwB3jBnJZ/ECTTYUz6Tzsimz6B7pRZCjrgW807jm3UJXex13wwU8fjvIF2
> e06+E/tbSbRlfNeq6tZagWZMJOkHDu1EEEm0v2n7KP/vBXFWFUeM7tzJplXq42Fk
> FzKMbLPBqXda/3VgjZFFD75/bK+zZYS6kG4xVvabqQkw8m7lAf1jRTKbgy7Fo2YX
> n376Jqybah631uigBdPe
> =Kzt/
> -----END PGP SIGNATURE-----
>

--001a1144232eb07cad0541cc5cbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>as we will make it hard coded within installer, so, i=
f &quot;WinXP installer link&quot; will ever change, there&#39;ll be no way=
 to change it in installer, which were downloaded (as for our company, I ca=
n confirm such practice, people download installer and put on smb shares, w=
iki, etc)<br><br></div>so, which is the proper link to &quot;the latest Win=
XP installer&quot;, which is frozen for ever.<br></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">2016-11-21 14:21 GMT+05:00 David Somm=
erseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=
=3D"_blank">openvpn@...2080...</a>&gt;</span>:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<span class=3D""><br>
On 21/11/16 08:57, ???? ??????? wrote:<br>
&gt; @mattock , can we use some url rewrite for that ?<br>
<br>
</span>URL rewrite?=C2=A0 As on the web server?=C2=A0 I think that is a ver=
y bad idea.<br>
=C2=A0If you want to download a particular file, you should get what you<br>
ask for.=C2=A0 The web server should not try to outsmart the user.<br>
<br>
However, how I understand Selva (and Gerts approval), is that the<br>
*installer* can displaying the v2.3 download URL - and perhaps even<br>
downloading it (on request).<br>
<br>
<br>
- --<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<span class=3D""><br>
<br>
<br>
&gt; 2016-11-21 12:53 GMT+05:00 Gert Doering &lt;<a href=3D"mailto:gert@...493...=
1296...">gert@...1296...</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:gert@...1296...">gert@...1296...</=
a>&gt;&gt;:<br>
<span class=3D"">&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Sun, Nov 20, 2016 at 11:02:33PM -0500, Selva Nair wrote:<br>
&gt;&gt; As for 2.4 installer, if run on XP, showing a link to the=C2=A0 la=
test<br>
&gt;&gt; 2.3.x before bailing out is a nice thing to do. If its not too<br>
&gt;&gt; much work, I would vote for offering to download the installer as<=
br>
&gt;&gt; well.<br>
&gt;<br>
&gt; This sounds good, yes.<br>
&gt;<br>
&gt; gert<br>
<br>
</span>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2.0.22 (GNU/Linux)<br>
<br>
iQIcBAEBAgAGBQJYMrywAAoJEIbPlE<wbr>yWcf3yGvEP/<wbr>2kejd40OfjkXorkKyoCQ/LD<=
br>
XZGJmZxstOSiEc//Y+<wbr>7l5TcUWcDdklXjZU2DKBhEpV6Ryzhz<wbr>FI9Hj4IIiDtPj3EB<=
br>
c2u5xzm99RJe40LVWNGZnVailgTjg6<wbr>epWyYsGXeMZVHVA+<wbr>GBVKEtWQJelo4Jcb/i<=
br>
96+<wbr>ElSUrqGTCBc993MTSzh6ejFSdkyFR5<wbr>mLK9wGlgLamasim0d1Hd57LN4m9+<wbr=
>221<br>
QR5+<wbr>PIQFCKzmOZhcFDmFBuZsjxpsNqf65L<wbr>w1dUSyekIJC49OLd3f11nancJ6nqhO<=
br>
EwqS2OeM2ZKHjgLuQcGivJiZ3VbO+<wbr>UFzP8d91w+r+463+xuoGzce+B/<wbr>i9QcDxrLz<=
br>
pi9+xfD5n+<wbr>xLPQCcSOv1ALfZWSstT9N3RN9fTocE<wbr>+NUlJ5y2t8FqoIhjL/5InR1r<=
br>
mBbtcs+Bw4+<wbr>hjCKQpRtkcIgkRtXrYm7wjZx79xeAA<wbr>qNSYuz/fvROnhvyjUfcozGw<=
br>
YVSER+ZwB3jBnJZ/<wbr>ECTTYUz6Tzsimz6B7pRZCjrgW807jm<wbr>3UJXex13wwU8fjvIF2<=
br>
e06+E/<wbr>tbSbRlfNeq6tZagWZMJOkHDu1EEEm0<wbr>v2n7KP/vBXFWFUeM7tzJplXq42Fk<=
br>
FzKMbLPBqXda/3VgjZFFD75/bK+<wbr>zZYS6kG4xVvabqQkw8m7lAf1jRTKbg<wbr>y7Fo2YX<=
br>
n376Jqybah631uigBdPe<br>
=3DKzt/<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--001a1144232eb07cad0541cc5cbe--

