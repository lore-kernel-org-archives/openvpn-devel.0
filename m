Subject: Re: [Openvpn-devel] New feature: --ifconfig for tap devices
From: Jan Johansson <jan.johansson@...1...>
In-Reply-To: <20030903104904.GD27875@...33...>
References: <twig.1062580090.46409@...41...>
	 <20030903104904.GD27875@...33...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DBlLtVsKgZVEFOTqCNNv"
Message-Id: <1062682176.1372.1.camel@...2...>
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
Date: Thu Sep  4 06:32:21 2003
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel@lists.sourceforge.net

--=-DBlLtVsKgZVEFOTqCNNv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> > What I need right now in order to make the TAP version of --ifconfig wo=
rk
> > correctly, is the correct ifconfig command syntax for setting the IP ad=
dress
> > and netmask of a TAP device, on all the OSes which OpenVPN supports.  I=
've
> > already coded templates for Linux and Windows, but I still need to know=
 the
> > appropriate ifconfig syntax for FreeBSD, OpenBSD, NetBSD, Solaris, and =
Mac OS
> > X, with respect to setting the IP/netmask on a TAP device.
>=20
> ## FreeBSD 4.9-PRERELEASE:
>=20
> ifconfig tap0 inet 10.11.12.42 netmask 255.0.0.0 up
>=20
> (inet appears to be optional, so the Linux syntax, "ifconfig tap0
> 10.11.12.42 netmask 255.0.0.0 up", should also work.

The above works for OpenBSD too, but do mind that openbsd usually dont come
with tap drivers, I'm re-porting an older port from FreeBSD to current Open,
and on my box the above works the same way as in Free.


--=-DBlLtVsKgZVEFOTqCNNv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Vz5ANJYxu+mj1OkRAh2oAJ4lITW2Olj9NyEdKEjOzJxV1pv0VQCgxjof
DPPhEL9avfdYROHtY4pNyco=
=lpFW
-----END PGP SIGNATURE-----

--=-DBlLtVsKgZVEFOTqCNNv--


