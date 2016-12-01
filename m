References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
Date: Thu, 1 Dec 2016 13:23:52 +0100
MIME-Version: 1.0
In-Reply-To: <20161201080132.GC78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aOgtgtMg43Q02coq1C6cPIVLMeGPudmfo"
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aOgtgtMg43Q02coq1C6cPIVLMeGPudmfo
Content-Type: multipart/mixed; boundary="98r4CBKlxKnNdl53kvT1jOBIaL10Q2QQl";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
	--ifconfig-push have argument mismatch with --topology
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
In-Reply-To: <20161201080132.GC78624@...1296...>

--98r4CBKlxKnNdl53kvT1jOBIaL10Q2QQl
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01/12/16 09:01, Gert Doering wrote:
> Hi,
>=20
> On Wed, Nov 30, 2016 at 11:41:27PM +0100, David Sommerseth wrote:
>> +      if ((c->options.topology =3D=3D TOP_SUBNET || c->options.topology=
 =3D=3D TOP_NET30)
>> +          && (c->c2.push_ifconfig_remote_netmask & 0xff000000) !=3D 0xf=
f000000)
>=20
> Are you sure of that?  I would assume that this is stored in network
> byte order (as it's an in_addr_t) so you can't directly compare it to
> a number but need to run through ntohl() first.
>=20
> On *intel* it might end up being the same, but code dealing with IPv4
> addresses and ports always needs to be checked on both endiannesses.

Good point!  I didn't consider endianess too careful, I just looked at
what we do in print_in_addr_t(), realised that we always call it with 0
in the flags argument in same prepare_push_reply() function.

      ia.s_addr =3D (flags & IA_NET_ORDER) ? addr : htonl (addr);

And now (when I have slightly more brainpower) I see I misread the
logic, so ....

> Some random code I just found in a BSD header file does it that way:
>=20
> #define INADDR_ALLHOSTS_GROUP   (u_int32_t)0xe0000001   /* 224.0.0.1 */
> #define in_allhosts(x)  ((x).s_addr =3D=3D htonl(INADDR_ALLHOSTS_GROUP))=
=20=20=20
>=20
> ... so it certainly needs the htonl()

... Yes!

> (What you can do is "peek at byte 0", which will always be the same
> part of the netmask [network byte order!], and which might actually
> make this easier to read .-) )

You mean like this?

    in_addr_t nmask =3D htonl(c->c2.push_ifconfig_remote_netmask);
    if ( nmask[0] =3D=3D 0xff )
      {
         ...


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--98r4CBKlxKnNdl53kvT1jOBIaL10Q2QQl--

--aOgtgtMg43Q02coq1C6cPIVLMeGPudmfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYQBZYAAoJEIbPlEyWcf3y1KIP/20Dw+dLFLP1gS8uSLFHWSsn
+G7BpyNVgDaI6v2rhG6yjlYHwqAm26ly1VUpgEDes4qQiSEDTOri6AQaoaXNjqv7
1kPpUQcgRJBnyWVqLqhT/HLegyNlzFSjtfrXvNAcI0RHhzmbY7ajaZ/6HQ9/aJjI
NgV8kO8xupwrODQt4pbC1qDWxKcfxbDi1IakcgwMaHMcCBDWRzhnvjH0dc0okztx
kJQSKcmF5WY05uyVvTsThHB+ukdmO+TyW4/d5eGDBJhHGMp1ic/Z5xACxz7sYIFY
BbKnXcN9bj9e5weTJYsE0cSJY2JVvLEwkViUbrg2vAv0MIijVxp4Uaj+MqNrRJa/
9HsrN7ifHfZ5WzR26TnSU7MI7oMrooiQh1Lz1GkbpSI4IrBTFaYOkOrTijVhRWNq
LvMahG0/iUXMSK75QyvQHpZjvvBJZryZacW38arVDVY5JiC8qwoVvQySC3BF/8nd
oQqwk7sYO98fam71Jm4rlgAj6X2ETn5ZiLOwL+QD/b1BTEu8zcxqlzQ1zTOXQ7re
IlEro8NzM7H4KXUMmL/mhSpjCklbFCVVyvzwtOEhdwIuSmJj8YMmSgBHJXCytPQY
mA2miaAvw7Niz9+QgUK8qoRNjf3kjV69yDXBhsVLN0kBWsWVtQztABg4UQTwc9W8
sJ685WgmZG/ad2pnXm3U
=fHUP
-----END PGP SIGNATURE-----

--aOgtgtMg43Q02coq1C6cPIVLMeGPudmfo--

