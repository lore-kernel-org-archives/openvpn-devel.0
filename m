Message-ID: <45346CD6.6090603@...744...>
Date: Tue, 17 Oct 2006 01:40:38 -0400
From: Jason Wittlin-Cohen <jasonwc@...744...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enig42294E417523E724011D63AE"
Subject: [Openvpn-devel] Question about IV size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42294E417523E724011D63AE
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I was reading the OpenVPN security overview which states that an
Explicit IV is used to ensure that two packets with the same plaintext
do not encrypt to the same ciphertext. However, the Overview did not
state the size of the Initialization Vector. I found this page
(http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/ssl.h)
which states that "=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20

Ciphertext IV (size is cipher-dependent, if not disabled by
 *       --no-iv).


So, does the IV size depend only on the cipher used or does it also
depend on the key size? For example would AES-128-CBC and AES-256-CBC
use the same IV size?

Also, the Security Overview stated that the Initialization Vector was
created using a pseudo-random number generator, and that each IV is
randomized. If this is the case, what is to prevent IV collisions? Is
anything done to prevent an IV being used twice with the same encryption
key or is the IV of a sufficient size that the likelihood of this
occurring is nominal?




--------------enig42294E417523E724011D63AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQEVAwUBRTRs2m4XQ4QiKLyPAQr4Uwf/frIcTyMRrArC+qVvKScPwrIRL8k+NRaI
lZ9T/xDY/orH3Obvpir54BRV/qEK9YdE5VkE7kgZZbJfwbXeFqQyQ1ubRy1FdfMn
YHc1J134Mt6vBUN4ahiVvnK1zzy63mHGAyl3Wbi2uhUrTFpWrzP0A3rQ4aDJ4AqI
hmJc7kb0BFAPX4suZha1kcvUYQrQ7mTd9di7O/LTA3srcDW+RrgKNcyrLrYswsUh
bpbnbzjgGt9WSlLJGBDsb9BtkZh4wj0ye5VS7m3BDNdb/RRt+zGpI0tzsfGvK0Sn
woNrQFVNAvbatJoB9PL4sqaGG6kB8t5FTVti6IqPfnHzMJp4hQ3dlg==
=rrdK
-----END PGP SIGNATURE-----

--------------enig42294E417523E724011D63AE--

