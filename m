Date: Wed, 18 Jan 2017 20:35:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170118193527.GT78624@...1296...>
References: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Epdev7n9Nu0o9kVy"
Content-Disposition: inline
In-Reply-To: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
Subject: Re: [Openvpn-devel] NOTE: unable to redirect default gateway --
 Cannot read current default gateway from system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Epdev7n9Nu0o9kVy
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Servus,

On Wed, Jan 18, 2017 at 04:43:22PM +0100, Thomas Sch=E4fer wrote:
> Client:
> client
> dev tun
> proto udp6
> remote raspberrypi.XXXXXXXX.myfritz.net 1194 udp6
[..]
> redirect-gateway
> verb 3
>=20
> This works perfectly as long the client has still an IPv4-connection.
>=20
> But in case of an IPv6-only-client (not system-wide disabled, just not=20
> getting IPv4-addresses by the ISP, e.g. eduroam-IPv6) the client doesn't=
=20
> set the IPv4-default route, since it can not find the old one.

I can see the problem.

The most elegant solution might be to use "redirect-gateway def1".   The
"def1" flag instructs the code to not add a 0.0.0.0/0 route (replacing
and later restoring the existing default route) but to add 0.0.0.0/1 and
128.0.0.0/1 routes - which cover "the default" as well, but do not=20
need to interfere with the existing /0 route.

It might *still* fail, as the code might still want to check and install
a v4 /32 host route for the VPN gateway, pointing to the existing=20
default gateway.  Which is arguably something that should not be done
if we're not talking v4 in the first place, but I'm not sure that part
of the code was ever adapted (I'd love to see a log with "def1" :-) ) -
the v6 part is smart enough to only try looking at v6 routing tables
if we're connecting over v6.


In case "def1" is not enough, please try "redirect-gateway def1 local",
which is a hack (but a documented one).  "local" signals "do not install
a host route pointing to the default gateway, because the VPN server is=20
in the same locally connected network" (think "university wifi").  So that
should make things succeed.


If that is still not working, use brute force, and replace "redirect-gatewa=
y"
with

  route 0.0.0.0/1
  route 128.0.0.0/1

in the client config - that is the same thing as "def1 local" should give
you, but explicitely only the "two half-default routes".


(Whatever the outcome of your tests, I think our code should be smarter=20
- the v4 code is 10+ years old, and has grown over time, and parts of
it have been contributed by non-networking folks...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Epdev7n9Nu0o9kVy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYf8N+AAoJEB2Cnv7KVigS03kMALNkwwt6OaiIVv5jbDD9frpu
aLOuYFv+CoRfVUSi28CCyb+bMYX/BCvFFBZKeQhL8nW1k5cZhdnlAk5iYwdEllr/
flcsKexNMBsn4z+T6meyMLjoNOqRdwHg1XpqpSxGFN0slX2cJN6m+NuZGjMWJ8oY
X3g8X+zW2s3+651SYZaW64YRnPF5xVIunKMtZiKrfOlllQtPErjguW6/1HVmwUeR
HcYlo6a90x3PV1+ZlQAYzEPgoYu6vM8bEPFdIK3thTZDlIPLNauuvfGpFEUJIWmf
j40cNJLmD1c2gE0coallt3yqf0Aaq4ajeHGt9EUtEdKSq77xfMut/xava0uUMbz0
vt/dYHdghLsredtA4W5hHOtJDsXSJ1cix7JLocz6jTCk3VX9tod5VjNwdNMH7xuA
v1I+moFZjZs+tfUaRGD0ch2y9OOSH/Jnsy9VHdtrrkiJcKA7v7g7iNaGReM9WeB1
AqJ15KJ7PazPLyB/KUhaDTjVE3iW/p3M8a5NUrsvPA==
=szLr
-----END PGP SIGNATURE-----

--Epdev7n9Nu0o9kVy--

