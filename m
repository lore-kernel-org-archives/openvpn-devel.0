From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
Date: Thu, 27 Dec 2018 20:11:49 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KVkqMMV7sUI625gQRivAK3YYfhrmFgEj5"
Subject: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KVkqMMV7sUI625gQRivAK3YYfhrmFgEj5
Content-Type: multipart/mixed; boundary="xjs0vJkKji20ByYMzBJXlyFDYDl8FrJQD";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
Subject: Ubuntu 18.04 packages available for testing

--xjs0vJkKji20ByYMzBJXlyFDYDl8FrJQD
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

I've produced OpenVPN 2.4.6 packages for Ubuntu 18.04 and they're now
available here:

https://build.openvpn.net/downloads/temp/

The Debian packaging files are taken from Ubuntu's own 18.04 openvpn
package. They already used our openvpn-client@...1685... and
openvpn-server@...1685... so I only need to make a few enhancements:

- Restart active VPN client and server instances on upgrade
- Stop activate VPN client and server instances on uninstall

I also tested upgrading from Ubuntu's own openvpn package and that
worked fine.

Let me know if these packages work for you or if they don't. I'd like to
get the to our official apt repositories soon.

Also, if you can, please review these PRs which enable anyone to build
the Ubuntu/Debian packages, including ones for Ubuntu 18.04:

https://github.com/OpenVPN/sbuild_wrapper/pull/1
https://github.com/OpenVPN/openvpn-vagrant/pull/6

Samuli


--xjs0vJkKji20ByYMzBJXlyFDYDl8FrJQD--

--KVkqMMV7sUI625gQRivAK3YYfhrmFgEj5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlwlFe0ACgkQKVhNn0CG
RXg3Qgf+K/WstqK5q+UPniu3zymU9GpXFW1uOMg19LjZ0xwDCOfLJpNa2kA13bZq
a6DWY67mjy8A8DbBFX77EJV0FuPp0lbYAoX6oHXqSlAryP7Va6wbQFrnt+19UJRB
Yh9ERKrHafJTGFrIb109aifN22ZqMF+neaj1YSDon2fqXy/LCHIMYLwa5ND5GKbY
5Enm4mrthvyNMwa7bBqTdGrLAHaunNp6PXVw0aQRxrraMroHao1pOGVk0S3GgSOH
5T9vIbBlShfve+XAxstgCg2twNHhCf3RQPBJBr6zcA3Sgvyug73JE06YhYyaZUdo
TRZmwZa3BtDIbgKPcGyVzglyzArsqQ==
=cfly
-----END PGP SIGNATURE-----

--KVkqMMV7sUI625gQRivAK3YYfhrmFgEj5--

