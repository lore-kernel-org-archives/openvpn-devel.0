Date: Fri, 10 Jun 2016 14:54:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160610125457.GC62247@...1296...>
References: <575AA2BD.60908@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <575AA2BD.60908@...277...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 10, 2016 at 12:21:33PM +0100, debbie10t wrote:
> today I successfully built git-master for windows x86_64
> and started testing the new features.
>=20
> You will be pleased to know that everything works well
> (as far as my limited knowledge and testing goes)
>=20
> However, why does pull-filter reject throw SIGUSER1 ?

So the client can move to the next server - or retry, in case it was
a temporary hickup at the server...

> If the server pushes an item the client rejects then
> the client will just reconnect endlessly, completing a
> full reconnect to the server then restarting !
> Thispractically constitutes a DDOS ..

"If you send me stuff that I find reject-worthy, you should be DoSed!!!"

Seriously: I expect people to notice that their VPN isn't connecting, and
check the log, no?

@Selva, Arne: can we make the reconnect logic somewhat smarter overall, like
"if reconnecting to the same host, wait 30 seconds instead of 5"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1q4oakuBuNlUUl1AQIgsQP8C81hEkDTh/sljnrU/fsgMlIsPAyFslH0
vm4Kwk6xfjEsy5QBhllwcvI8guuVr9Kz3kWNefCrO3uCnJHFlBW3KPzDYaaV9Jj7
aYePBez9vTZZWVNtnTgcecaT4CgoLbmoIfmcz/Td5zdUwkg0kaN7tRAGME9BXA2j
NDPpPobwLBE=
=/NsD
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

