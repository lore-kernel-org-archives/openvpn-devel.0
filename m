MIME-Version: 1.0
References: <20220224144245.878056-1-arne@...1227...>
In-Reply-To: <20220224144245.878056-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 4 Mar 2022 13:57:46 +0200
Message-ID: <CAGyAFMW4hX8p9GH8unPAhLg-OPevpvdmDu_GUbLPUZBwB0bLKA@...278...>
Content-Type: multipart/alternative; boundary="000000000000c087dd05d9633916"
Subject: Re: [Openvpn-devel] [PATCH] Implement fixed MSS value for mssfix
 and use it for non default MTUs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c087dd05d9633916
Content-Type: text/plain; charset="UTF-8"

Hi,

encapsoluation
>

Built and tested on Windows with dco, works as expected - "mssfix 1000
fixed" results in MSS 960 and 1000 bytes in-tunnel TCP packets with 1024
bytes transport UDP packets. Same behavior with "tun-mtu 1000".

Acked-by: Lev Stipakov <lstipakov@...277...>

--000000000000c087dd05d9633916
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">encapsoluation<=
br></blockquote><div><br></div><div>Built and tested on Windows with dco, w=
orks as expected - &quot;mssfix 1000 fixed&quot; results in MSS 960 and 100=
0 bytes in-tunnel TCP packets with 1024 bytes transport UDP packets. Same b=
ehavior with &quot;tun-mtu 1000&quot;.=C2=A0</div><div><br></div><div>Acked=
-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...1665...=
77...</a>&gt;</div></div></div>

--000000000000c087dd05d9633916--

