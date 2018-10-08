MIME-Version: 1.0
References: <20181008094600.10164-1-simon@...2293...>
In-Reply-To: <20181008094600.10164-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 8 Oct 2018 13:41:03 +0300
Message-ID: <CAGyAFMUqPmnJwkUjB3zuKzgO=hgQD=Jg+B3rM=ds6Rxv47=Zng@...278...>
Content-Type: multipart/alternative; boundary="0000000000008c8db20577b542b7"
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
To: simon@...2293...
Cc: openvpn-devel@lists.sourceforge.net

--0000000000008c8db20577b542b7
Content-Type: text/plain; charset="UTF-8"

Hi,

Makes sense. Tested on VS2017.

Acked-by: Lev Stipakov <lev@...515...>

Since in MinGW/VS we only build openvpnserv with unicode I wonder if we
should get rid of #if(n)def UNICODE ?

-Lev

--0000000000008c8db20577b542b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Makes sense. Teste=
d on VS2017.=C2=A0</div><div><br></div><div><span class=3D"m_49832489783428=
9559gmail-il">Acked</span>-<span class=3D"m_498324897834289559gmail-il">by<=
/span>: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank"=
>lev@...515...</a>&gt;=C2=A0=C2=A0<br></div><div><br></div><div>Since in Mi=
nGW/VS we only build openvpnserv with unicode I wonder if we should get rid=
 of #if(n)def UNICODE ?</div><div><br></div><div>-Lev</div></div></div>

--0000000000008c8db20577b542b7--

