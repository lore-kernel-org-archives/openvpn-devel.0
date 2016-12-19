References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<efa5d95d-9622-f80d-42fb-c676679b7308@...1856...>
From: Julien Muchembled <jm@...1926...>
Message-ID: <cf2df937-2a91-e487-3956-ce1db6e11977@...1926...>
Date: Mon, 19 Dec 2016 11:37:25 +0100
MIME-Version: 1.0
In-Reply-To: <efa5d95d-9622-f80d-42fb-c676679b7308@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lXu0IvkvM53BbQBeC7egvQtHCPtGD6w4Q"
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lXu0IvkvM53BbQBeC7egvQtHCPtGD6w4Q
Content-Type: multipart/mixed; boundary="gQm3wKmgfeJv2C86rmD29oIr6lmQpT4cf";
	protected-headers="v1"
From: Julien Muchembled <jm@...1926...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <cf2df937-2a91-e487-3956-ce1db6e11977@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
	compiler supports them
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
	<44d2e307-1954-de7f-9979-68728de900b3@...1926...>
	<efa5d95d-9622-f80d-42fb-c676679b7308@...1856...>
In-Reply-To: <efa5d95d-9622-f80d-42fb-c676679b7308@...1856...>

--gQm3wKmgfeJv2C86rmD29oIr6lmQpT4cf
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Le 12/16/16 =E0 23:33, Steffan Karger a =E9crit :
> Also, is -Werror=3Dformat-security needed (instead of -Wformat-security)
> if we already have -Werror?

No. In this case, it's indeed clearer to have -Wformat-security

Julien


--gQm3wKmgfeJv2C86rmD29oIr6lmQpT4cf--

--lXu0IvkvM53BbQBeC7egvQtHCPtGD6w4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYV7hlAAoJEEwjvlkacWMk6X0QALwvJ76rdZaj4IE7gLORBC9O
gUSsujyd1h0XbTcNQJAd8gJdVYrnbhjlBFMyYwVqaAOscJOJe5UDsUDs8CQtcVME
eE74RM4jdVgrSFcAH/AhEbvDvSXfVx10J206AAfcxPm55aTSYv2VDtTiT+5pXGwZ
tMA9Olv7pGfIkWCct5aTQmVQJJh9hsdvzkZNkJeH7OKbL4b4LVrEbudJHXhZwpiR
PtH/1284L0Vagy0IwH7+n5XGL2R2wyn1VRQBYqA8ESrj8WSSZWtAXg5UPDbeF6Gu
mQTziNMcPuGvqBwfr7aLyqXG3vnGOWICCkXWKfakEVnRjSIpZ7qXhH92XnHAhEL2
0iNVUoMllB9j0wWQBmzsF3AP+uNAx9TOFONNAEucKibs/ic2vgN7N3FQb0CRZ2Iq
vuJwQU3OLMxprsg870FfwI2R3bkWX/q+0T3n4rQQV3+bj/G9gQVePuX/YdJ4AAlF
U1gC3WfEVBEN2A9Qz58r6BT+oSy4BNtE7LmUTfcWIrTS1UCcHO9W1c5VYSe0bExx
/EHSoUOQ/iyg5A+0hEk2d9QaszB1f0CgX7YvuffALlb3Mnf0oSXaqcnoGeqpSlw+
6nh9RdZus+ZtnJI6CqlXsfgkhFcFp3y9OEcFt4TdL1ectXV3DwJQjoNk8zCGmbIE
yaqeAURqCSnt0Bemfg+f
=4fZo
-----END PGP SIGNATURE-----

--lXu0IvkvM53BbQBeC7egvQtHCPtGD6w4Q--

