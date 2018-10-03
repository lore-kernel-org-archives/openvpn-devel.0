MIME-Version: 1.0
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
In-Reply-To: <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 3 Oct 2018 19:56:41 +0300
Message-ID: <CAGyAFMVaLFpBNAdFuvBSMZmw8aFpSMm3dawQRC1Sb+AVTwrY+A@...278...>
Content-Type: multipart/alternative; boundary="000000000000d72892057755ec3d"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000d72892057755ec3d
Content-Type: text/plain; charset="UTF-8"

Hi,

Wishlist: openvpn_swprintf() with nul termination guarantee. I try to avoid
> the TCHAR variety be explicit about wide and narrow characters.
>

Makes sense, at the moment we have 8 swprintf calls all followed by
something like

 > tmp[_countof(tmp)-1] = L'\0';

Will do.

-Lev

--000000000000d72892057755ec3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_quote"><div>Wishlist: openvpn_swprintf() with nul termination gua=
rantee. I try to avoid<br>the TCHAR variety be explicit about wide and narr=
ow characters.</div></div></div></blockquote><div><br></div><div>Makes sens=
e, at the moment we have 8 swprintf calls all followed by something like</d=
iv><div><br></div><div>=C2=A0&gt; tmp[_countof(tmp)-1] =3D L&#39;\0&#39;;<b=
r></div><div><br></div><div>Will do.</div><div><br></div><div>-Lev=C2=A0</d=
iv></div></div></div></div>

--000000000000d72892057755ec3d--

