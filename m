Date: Thu, 22 Dec 2016 19:23:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161222182355.GG78624@...1296...>
References: <a0cc9f56-0a28-fdbd-22af-c2c524c9b36d@...68...>
	<9b1ae30e-ee1a-a798-4bfa-fe0ba5c272de@...68...>
	<20161222102432.GE78624@...1296...>
	<c055d6f5-21ff-e4b0-20e8-fcd48ef349b0@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kz6eUT30PReluLpA"
Content-Disposition: inline
In-Reply-To: <c055d6f5-21ff-e4b0-20e8-fcd48ef349b0@...68...>
Subject: Re: [Openvpn-devel] CFT: OpenVPN 2.4 port update (upstream rc2) for
 FreeBSD, now with TUNNELBLICK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Kz6eUT30PReluLpA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 22, 2016 at 07:01:32PM +0100, Matthias Andree wrote:
> I haven't seen anything mentioned by a Jonathan recently, and see
> nothing in the openvpn-devel archives, but yes it is about optionally
> obfuscating OpenVPN traffic on the wire, adding an undocumented
> --scramble option, and taken from here:
> <https://github.com/opnsense/ports/commit/173db0315>.

Sorry, my fault.  That was Jonathan K. Bullard on openvpn-*users*, who
is maintaining Tunnelblick, and he mentioned that his builds do contain
an obfuscation patch.  So it seems to be the same thing.

Jonathan's mail is here:

http://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg03396.ht=
ml

(he calls it the "openvpn_xorpatch")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Kz6eUT30PReluLpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYXBo6AAoJEB2Cnv7KVigSlTIMAK2yTtAmEda+jwQlsplXSBE/
z5XaS3Gu7ftVRX58LzaYnisB4xgqrAhN7kUuoQL7I0OPGrIZrZph7ioX5DKVqCDY
ipNzlQ+Ukz28k54dZEQ2nqpgwj4UpXr05n4HH7kYSksYkUfU5vm5ArZxmF6EJUG3
Kw+jv1h4hP+Vv6Uqo7iDyTKjSzMslmJ6a8pCGfNIqx23+aSP20IfkQ+Y2XIfdHeQ
wYdXlO+ZVj/R58O9r1/Y2U2Pz/A6P8HvCbLb69iAkwxzOCDawgMGuCRG7Jxrz8aV
9krau1P5q9i96OgXVEtGnDUftjoAFNFIauouODYzz3AElHsr2dQ/0Y1blBh+SFEd
k1mVQFdKKJ8rLilhIvNyUBNcqtjBeAjBkylsaPtFF8YBDmfPcGFg2dRoe4CiVCZQ
UcFyFNqf4WO7h9P7C9ZOrr0EJN8NVK1AdGNjKKyCGTM7ocJh2uDo2mjQWxUmKhl/
eYTUjkHyt8517UClx4/5nulMoti6MDj6v9p30mCi8A==
=b6NG
-----END PGP SIGNATURE-----

--Kz6eUT30PReluLpA--

