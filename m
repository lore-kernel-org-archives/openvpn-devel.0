References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5655D801.4020508@...2080...>
Date: Wed, 25 Nov 2015 16:47:13 +0100
MIME-Version: 1.0
In-Reply-To: <5654A314.3080607@...2070...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aIeWdaS8xLaDQTJ7oTseDB9kvIsF5QeKp"
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aIeWdaS8xLaDQTJ7oTseDB9kvIsF5QeKp
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/11/15 18:49, ValdikSS wrote:
> I can't figure out why Thunderbird corrupts my patches.
> Please use the attached version.
> I still need help with 2.3 build system. If somebody willing to help me, =
please use the attached version.

Thunderbird works great in many areas, but my experience with patches
are poor.  It often does some odd mangling with line lengths and other
things.  I've even heard rumours of Linux kernel developers rejecting
patches when Thunderbird is the MUA, as it will "always" be wrong (but
that's 5-6 years ago, might have improved).

And in particular if you use Enigmail with inline signatures, then
enigmail makes a really big mess.  It will do a select-all -> reformat
-> copy -> send clipboard to gpg -> gpg result to clipboard -> paste.
What is less worse is to use PGP/MIME ... which I had to do for all
these ML discussions, as it even messed up the '>' blocks completely and
other git log messages when replying.

As others have said already ... For patches, configure git send-email,
it is fairly simple and you won't have so much complaints from us :)


--=20
kind regards,

David Sommerseth


--aIeWdaS8xLaDQTJ7oTseDB9kvIsF5QeKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZV2AMACgkQDC186MBRfroXgQCfQ28DB7Qb+i03sF8wJbV6ZZNN
5M0AmQEEprklRKMAHFnMiXA/qdaiOscl
=C9s9
-----END PGP SIGNATURE-----

--aIeWdaS8xLaDQTJ7oTseDB9kvIsF5QeKp--

