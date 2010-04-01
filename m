Message-ID: <4BB48345.7020408@...1338...>
Date: Thu, 01 Apr 2010 13:28:05 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>	<4BB45497.8040707@...1338...>
	<4BB46059.9080208@...1147...> <20100401091414.24106.qmail@...1287...>
In-Reply-To: <20100401091414.24106.qmail@...1287...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5267C0072AFE5BDDEC1AF2DF"
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and
 remove	VLAN	identifiers on outgoing and incoming frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5267C0072AFE5BDDEC1AF2DF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Peter Stuge schrieb:
> Jan Just Keijser wrote:
>> FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1=20
>> are *by definition* not encapsulated (according to my CCNA guide ;-))
[...]
>> Perhaps we need to make sure that VID 1 means untagged ...
>=20
> Any VID can be untagged. While 1 is the default it can change and
> OpenVPN shouldn't really care.
>=20
> One alternative approach to using tag 0 would be to introduce a
> vlan-pvid (or vlan-default-tag) option to set the PVID.

So packets coming in on the tap device that aren't tagged would be
assumed to have a vid =3D=3D PVID.  And packets going out on the tap device
with a vid =3D=3D PVID would go out untagged.  (A vid of 0 would continue to
be rejected as configuration option.)
Not specifying --vlan-pvid would mean that only tagged packets are
accepted (and sent).

I'm still unsure what to do with incoming frames from clients who's vid
matches the pvid and where the frames contain a full 802.1Q header with
a non-zero vid.  I'll probably just drop those packets.  Maybe we should
drop such packets regardless of the PVID value while in --vlan-tagging
mode.   (Tags in tags are apparently specified by 802.1ad and we don't
support that anyway.)

> But explicitly allowing tag 0 can also be useful.

What would be the use-case?  Packets with tag 0 are priority packets and
we currently completely ignore / drop the priority values.  We could of
course add an option to specify whether the priority part of 802.1Q
packets should be preserved.

Instead of removing the 802.1Q packets when untagging, we would instead
change the vid to 0 and leave the priority fields untouched.  We'd
probably want an option separate from the --vlan-tag option to specify
that though ...

And would this be a global setting or per-client? Per-client could make
the broadcasting code a tad bit more difficult, as the packets would
need to be modified for each client. (Stripping or not stripping the
802.1Q headers...)

Cheers
Fabian


--------------enig5267C0072AFE5BDDEC1AF2DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku0g0wACgkQARH1aMTipzNwLQCbBISkWBLmffbGCfJPtIUvcmGk
DP8AoLhc38cbSxWUjWD3frBBDQh0UBqe
=xxpO
-----END PGP SIGNATURE-----

--------------enig5267C0072AFE5BDDEC1AF2DF--

