Subject: Re: [Openvpn-devel] Re: OpenVPN --resolv-retry and --chroot problem
From: Teemu Kiviniemi <teemuki@...124...>
In-Reply-To: <twig.1067463490.56118@...41...>
References: <twig.1067463490.56118@...41...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3YCY/tmJrHniJfEDyEuH"
Message-Id: <1067495953.8347.253.camel@...125...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 29 22:40:10 2003
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

--=-3YCY/tmJrHniJfEDyEuH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Wed, 29-10-2003 at 23:38, James Yonan wrote:

> I would rather see this fix accomplished by adding some kind of dummy call
> early on in the initialization sequence to trigger the dynamic load of th=
e DNS
> library -- but which doesn't touch the functionality of the current DNS n=
ame
> resolution code.

Hi,

I made a new patch. This time the name lookup is done in openvpn.c if
options->remote is set, just before entering the chroot jail.

http://iki.fi/teemuki/openvpn/cvs-resolvfix2.diff
The patch is against the current CVS version.

Teemu


--=-3YCY/tmJrHniJfEDyEuH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/oLIOq0EylM9fq6oRAjllAJ9qJJA6dY/xeGNDeztGY7m1CMP5yQCfa2vh
D1kZ5i5DXC/Y2Xo+kf9O2zY=
=0zcx
-----END PGP SIGNATURE-----

--=-3YCY/tmJrHniJfEDyEuH--


