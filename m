Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <1474672864.11690.27.camel@...1866...>
Date: Fri, 23 Sep 2016 18:15:35 -0700
Message-Id: <85189792-C6D2-436F-8231-2A739A3F0C42@...277...>
References: <1474666458.11690.23.camel@...1866...>
	<57E5A654.60503@...1147...>
	<1474672864.11690.27.camel@...1866...>
Subject: Re: [Openvpn-devel] p2p topology on Windows
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
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

I may be wrong, but this sounds suspiciously like what we use Gava's client=
-nat patch for. To enable us to NAT the device's local IP to the one assign=
ed dynamically by openvpn (dhcp).=20

Marvin

Sent from my iPhone

> On Sep 23, 2016, at 4:21 PM, David Woodhouse <dwmw2@...1866...> wrote:
>=20
>> On Sat, 2016-09-24 at 00:01 +0200, Jan Just Keijser wrote:
>>=20
>> sorry for asking, but what's the use case for this?
>=20
> The use case for point-to-point? It allows you to use a single IP
> address per client instead of having to set aside a whole /30 subnet
> per client as with the 'net30' mode.
>=20
> (And in my case, because some Cisco servers end up being configured
> thus, their own client copes with it under Windows and users were
> complaining.)
>=20
>> And you say "configure it with the local IP address" - which address is=
=20
>> that? the address that OpenVPN assigns? or the address of a local=20
>> adapter on the Windows host?
>=20
> The address that OpenVPN assigns.
>=20
> --=20
> dwmw2
>=20
>=20
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

