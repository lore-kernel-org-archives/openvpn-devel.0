Message-ID: <4F9B1BBD.9010905@...1114...>
Date: Sat, 28 Apr 2012 00:20:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9CB0680539C723BFE19EC785"
Subject: Re: [Openvpn-devel] [PATCH 1/6] Added support for new PolarSSL 1.1
 RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CB0680539C723BFE19EC785
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


This is a summary of all the 6 applied patches.  All patches were applied to
the master branch and pushed out to -stable and -testing trees.


commit 4b87c868333e6aca5cb78bc345059e61c72b9423
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Apr 2 09:28:06 2012 +0200

    Removed stray "Fox-IT hardening" string.
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1333351687-3732-5-git-send-email-dejong@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6212
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 34091048af1ba94e8bf2049354610d16f8bb3d4c
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Apr 2 09:28:07 2012 +0200

    Updated README.polarssl with build system changes.
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1333351687-3732-6-git-send-email-dejong@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6209
    Signed-off-by: David Sommerseth <davids@...1347...>

 README.polarssl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

commit 1d92d06dca5ac38990261cb546a766b91fc53f9b
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Apr 2 09:28:05 2012 +0200

    Removed support for PolarSSL < 1.1
=20=20=20=20
    PolarSSL 1.0 and earlier use only the Havege RNG. Havege is based on ti=
ming
    certain operations, using the RDTSC instruction. Although this is fine =
on
    bare metal PCs, the RDTSC instruction is virtualised on some virtual
    machine implementations. This can result in issues on those virtual
    machines. PolarSSL fixes this potential issue by also using platform
    entropy.
=20=20=20=20
    To ensure that OpenVPN is always built against a decent RNG, PolarSSL <=
1.1
    is therefore no longer supported.
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1333351687-3732-4-git-send-email-dejong@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6211
    Signed-off-by: David Sommerseth <davids@...1347...>

 src/openvpn/crypto_polarssl.c |   34 ----------------------------------
 src/openvpn/crypto_polarssl.h |   13 +------------
 src/openvpn/ssl_polarssl.c    |    6 ------
 src/openvpn/syshead.h         |    3 ---
 4 files changed, 1 insertions(+), 55 deletions(-)

commit 21fdfb73d5d18038872da15cd15026f40666b4d5
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Apr 2 09:28:04 2012 +0200

    Use POLARSSL_CFLAGS instead of POLARSSL_CRYPTO_CFLAGS in configure.ac
=20=20=20=20
    Ensured that the used variable name actually matches the one advertised=
 by configure.
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Alon Bar-Lev <alon.barlev@...277...>
    Message-Id: 1333351687-3732-3-git-send-email-dejong@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6208
    Signed-off-by: David Sommerseth <davids@...1347...>

 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

commit 0f25d2969f09ba4263dc37944e1f10405a2df461
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Apr 2 09:28:03 2012 +0200

    Added a configuration option to enable prediction resistance in the Pol=
arSSL random number generator.
=20=20=20=20
    Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: James Yonan <james@...515...>
    Message-Id: 1333351687-3732-2-git-send-email-dejong@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6213
    Signed-off-by: David Sommerseth <davids@...1347...>

Notes:
    This patch was ACKed by James Yonan in an IRC meeting March 29, 2012.
=20=20=20=20
    Currently, the meeting minutes have not been made public.
=20=20=20=20
    (David Sommerseth, Fri Apr 27 21:36:04 UTC 2012)

 doc/openvpn.8                 |   14 ++++++++++++++
 src/openvpn/crypto_polarssl.c |    9 +++++++++
 src/openvpn/crypto_polarssl.h |    7 +++++++
 src/openvpn/init.c            |    6 ++++++
 src/openvpn/options.c         |   22 ++++++++++++++++++++++
 src/openvpn/options.h         |    3 +++
 src/openvpn/syshead.h         |    8 ++++++++
 7 files changed, 69 insertions(+), 0 deletions(-)

commit 6efeaa2e4462bc10f395d8aceed363c3e77b35a3
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Apr 2 09:28:02 2012 +0200

    Added support for new PolarSSL 1.1 RNG
=20=20=20=20
    This patch, while retaining PolarSSL 1.0 support, introduces the PolarS=
SL 1.1 DRBG.
    This RNG adds a number of features, including support for personalisati=
on strings
    and multiple entropy sources.
=20=20=20=20
    Personalisation strings have been implemented, based on PID, program na=
me, place
    within memory, and a hash of the user's certificate.
=20=20=20=20
    The entropy sources used are the platform default ones. Which ones thes=
e are
    depends on how PolarSSL was built, but usually this includes:
=20=20=20=20
     - /dev/urandom or the Windows CryptoAPI RNG
     - the HAVEGE RNG
     - the output of PolarSSL's hardclock() call (usually RDTSC)
=20=20=20=20
    Finally, this patch moves to only one instance of the RNG  per OpenVPN =
instance,
    instead of one per keystate
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: Eelse-jan Stutvoet <stutvoet@...1435...>
    Acked-by: James Yonan <james@...515...>
    Message-Id: 1333351687-3732-1-git-send-email-dejong@...1435...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6210
    Signed-off-by: David Sommerseth <davids@...1347...>

Notes:
    This patch was ACKed by James Yonan in an IRC meeting March 29, 2012 un=
der the condition
    that PolarSSL 1.0 and havege support is removed later on.
=20=20=20=20
    Currently, the meeting minutes have not been made public.
=20=20=20=20
    (David Sommerseth, Fri Apr 27 21:31:03 UTC 2012)

 src/openvpn/crypto_polarssl.c |   84 ++++++++++++++++++++++++++++++++++++-=
----
 src/openvpn/crypto_polarssl.h |   25 ++++++++++++
 src/openvpn/ssl.c             |    5 ++
 src/openvpn/ssl_backend.h     |   10 +++++
 src/openvpn/ssl_polarssl.c    |   44 ++++++++++++++++-----
 src/openvpn/ssl_polarssl.h    |    2 -
 6 files changed, 148 insertions(+), 22 deletions(-)



kind regards,

David Sommerseth


--------------enig9CB0680539C723BFE19EC785
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+bG8AACgkQDC186MBRfrpyaQCgjLv4j7XSkUOyPbSH2hsSXAEZ
PBAAniq8Ite9KhkJdeaxEAY6hWN7j8pj
=HdSl
-----END PGP SIGNATURE-----

--------------enig9CB0680539C723BFE19EC785--

