MIME-Version: 1.0
References: <20181008094600.10164-1-simon@...2293...>
 <CAGyAFMUqPmnJwkUjB3zuKzgO=hgQD=Jg+B3rM=ds6Rxv47=Zng@...278...>
In-Reply-To: <CAGyAFMUqPmnJwkUjB3zuKzgO=hgQD=Jg+B3rM=ds6Rxv47=Zng@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 8 Oct 2018 10:12:57 -0400
Message-ID: <CAKuzo_j=sxNuPyfT4dB3hSf2pd3ic6w7oEnkOqQVQ2UftVk+dQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000cc60c00577b8384b"
Subject: Re: [Openvpn-devel] [PATCH 1/2] msvc: Unify Unicode/MultiByte
 string setting across all cfg|plat
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cc60c00577b8384b
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 8, 2018 at 6:42 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> Makes sense. Tested on VS2017.
>
> Acked-by: Lev Stipakov <lev@...515...>
>
> Since in MinGW/VS we only build openvpnserv with unicode I wonder if we
> should get rid of #if(n)def UNICODE ?
>

In fact the non-unicode build is its unlikely to work anymore -- there are
number of places we implicitly assume that TCHAR = WCHAR. So assuming
UNICODE is defined (and refusing to build otherwise) would be good.

Selva

--000000000000cc60c00577b8384b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon=
, Oct 8, 2018 at 6:42 AM Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1664...=
7...">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Makes sense.=
 Tested on VS2017.=C2=A0</div><div><br></div><div><span class=3D"m_-3726212=
025145446704m_498324897834289559gmail-il">Acked</span>-<span class=3D"m_-37=
26212025145446704m_498324897834289559gmail-il">by</span>: Lev Stipakov &lt;=
<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt;=C2=
=A0=C2=A0<br></div><div><br></div><div>Since in MinGW/VS we only build open=
vpnserv with unicode I wonder if we should get rid of #if(n)def UNICODE ?</=
div></div></div></blockquote><div><br></div><div>In fact the non-unicode bu=
ild is its unlikely to work anymore -- there are number of places we implic=
itly assume that TCHAR =3D WCHAR. So assuming UNICODE is defined (and refus=
ing to build otherwise) would be good.</div><div><br></div><div>Selva</div>=
<div><br></div></div></div>

--000000000000cc60c00577b8384b--

