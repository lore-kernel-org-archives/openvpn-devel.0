Message-ID: <4BB45E25.2010700@...1338...>
Date: Thu, 01 Apr 2010 10:49:41 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...>
In-Reply-To: <4BB45497.8040707@...1338...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA497EE81104B5367BDBC69FA"
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
--------------enigA497EE81104B5367BDBC69FA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Fabian Knittel schrieb:
> Peter Stuge schrieb:
>> It would be nice to be able to use VID 0 to mean untagged packets.
>=20
> Hm, nice idea.  I'll implement it in my next round of patches.

I've just noticed a detail that might warrant discussion.  To make sure
we're talking about the same thing, this is how I intended --vlan-tag 0
to be handled:

Packets coming in from the tap device:
 If the packet has no 802.1Q header or the 802.1Q header's VID field is
 0, the vid is assumed to be 0 and the packet will be forwarded to all
 clients who's --vlan-tag is set to 0.

Packets outgoing via the tap device:
 Packets originating from clients who's --vlan-tag is set to 0 are
 passed on to the tap device without change, i.e. no 802.1Q header is
 attached or removed.  A potential 802.1Q header already present within
 the packet is left untouched.  This would allow the Priority Code Point
 (PCP) field to be used.

Now, to the slight difficulty: What happens with outgoing frames from
clients who's --vlan-tag is set to 0, where the frame contains a 802.1Q
header with VID field !=3D 0?  Pushed onto a network which uses vlan tags,
this would allow a client to inject packets into a different network.
(For --vlan-tag !=3D 0 this is no problem, because we unconditionally wrap
the packets in 802.1Q headers with a new VID.)

Possible solutions:

a) Inspect outgoing packets for --vlan-tag =3D=3D 0 clients.  Drop packets
   that have a VID !=3D 0.
b) Always wrap outgoing packets with 802.1Q headers and set the VID to
   0. (This would make the code-patch uniform for all --vlan-tag
   values.)

I think I slightly prefer solution a), as it allows the PCP field to be
used and doesn't add needless overhead to outgoing packets.

Cheers
Fabian


--------------enigA497EE81104B5367BDBC69FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEUEARECAAYFAku0XjIACgkQARH1aMTipzOXjACdG20XNkwx1NP+D/mpDGwvmSR/
1ycAliR/vMdAilfdd0gsV/vOnTPLxPs=
=op/v
-----END PGP SIGNATURE-----

--------------enigA497EE81104B5367BDBC69FA--

