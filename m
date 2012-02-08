From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 8 Feb 2012 08:39:32 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
In-Reply-To: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: James Ring <sjr@...1546...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: James Ring [mailto:sjr@...1546...]
> Sent: dinsdag 7 februari 2012 23:33
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
>=20
> Hi there,
>=20
> I was just wondering if anybody has seen the new Android 4.0 VPN API.
> It looks like a promising way to have a native Java OpenVPN solution on
> Android.
>=20
> http://developer.android.com/reference/android/net/VpnService.html
>=20
> There is a lot of interest in having an Android implementation of
> OpenVPN that does not require rooting the phone.
>=20
> Thanks,
> James

Hi James,

I had a look at it a few months ago, and it looks really promising. It uses=
 a tun device at its base. Network settings can be passed to There are a fe=
w tricky bits though:=20

 - The ABI expects a two-stage setup process: set up a control channel firs=
t for negotiation, then a call VpnService.Builder with the proper routing, =
DNS, addresses, etc. As far as I've been told by other developers, this is =
not how OpenVPN currently works.=20

- We would need the management interface to export the routing and network =
parameters that need to be set, so that a surrounding android app can call =
the appropriate Java methods.

 - We would need a call in the management interface allowing the tun interf=
ace to be passed back into OpenVPN.

None of these problems are impossible to solve, but they would take some re=
factoring of the OpenVPN main and connection code. Any input would of cours=
e be appreciated!

Adriaan

