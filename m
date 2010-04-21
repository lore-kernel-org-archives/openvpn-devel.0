Message-ID: <4BCF1FEC.60608@...1347...>
Date: Wed, 21 Apr 2010 11:55:24 -0400
From: Richard Monk <rmonk@...1347...>
MIME-Version: 1.0
References: <4BCF0259.8070902@...1347...> <201004211651.41873.dave_br@...1278...>
In-Reply-To: <201004211651.41873.dave_br@...1278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enig9B5E1B47B16F61B8379B72FF"
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
 script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Davide Brini <dave_br@...1278...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B5E1B47B16F61B8379B72FF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 04/21/2010 11:51 AM, Davide Brini wrote:
> as a matter of fact, there's a new version of that script (and client.dow=
n as=20
> well) in the git testing tree, which should fix your problem as it just u=
ses=20
> the DNS servers in the order they're sent from the server. See here for m=
ore=20
> details:
>=20
> http://article.gmane.org/gmane.network.openvpn.devel/3343
>=20
> and try the attached patch (which is the same that has been merged).

Ha, perfect!  My first attempt was using this style (single variable,
add entries, send to resolv) so either actual method works.

Any idea if this will make it into the next point release?

--=20
Richard Monk (rmonk@...1347...) - Security Analyst
Red Hat - Centennial Office: Raleigh, NC USA
+1 (919) 890 8501
GPG Key ID: 0x1EBEF129


--------------enig9B5E1B47B16F61B8379B72FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEAREKAAYFAkvPH/AACgkQb7MZRB6+8Sl6RgCfZ0jPlJ7YwV6Rqbhu4iB7+10r
EkwAn0bkX1eHu2PsyJcj1kuH91x0/v11
=0oUl
-----END PGP SIGNATURE-----

--------------enig9B5E1B47B16F61B8379B72FF--

