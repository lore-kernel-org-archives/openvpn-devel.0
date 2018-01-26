From: Jan Just Keijser <janjust@...1147...>
References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
 <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
Message-ID: <663a0e1d-0d21-6f40-851e-78d770bec68f@...1147...>
Date: Fri, 26 Jan 2018 14:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

On 26/01/18 14:11, Jan Just Keijser wrote:
> the patch works as expected but I did notice something in the openvpn log=
 :
>
> Fri Jan 26 14:08:09 2018 do_ifconfig, tt->did_ifconfig_ipv6_setup=3D1
> Fri Jan 26 14:08:10 2018 NETSH: C:\Windows\system32\netsh.exe interface i=
pv6 set address interface=3D17 2001:610:120::200:0:1001=20
> store=3Dactive
> Fri Jan 26 14:08:10 2018 add_route_ipv6(2001:610:120::200:0:0/112 -> 2001=
:610:120::200:0:1001 metric 0) dev vpn0
> Fri Jan 26 14:08:10 2018 C:\Windows\system32\netsh.exe interface ipv6 add=
 route 2001:610:120::200:0:0/112 interface=3D17 fe80::8=20
> store=3Dactive
> Fri Jan 26 14:08:10 2018 env_block: add PATH=3DC:\Windows\System32;C:\Win=
dows;C:\Windows\System32\Wbem
>
> the route was added with the default GW of fe80::8 : should I be worried ?
> Note that this also happened with the regular 2.4.4 version of OpenVPN an=
d also note that the TAP adapter on my Win7 laptop is=20
> named 'vpn0'
>
arrrgh, the important line is missing:
 =A0ERROR: Windows route add ipv6 command failed: returned error code 1

sorry for the noise,

JJK




