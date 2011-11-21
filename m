Message-ID: <4ECA3068.2070009@...1114...>
Date: Mon, 21 Nov 2011 12:05:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] Series of patches to fix Windows builds and
 other errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/10/11 16:29, Adriaan de Jong wrote:
> Hi,
>=20
> The following series of patches enables Windows builds and fixes a few
> bugs to boot. Most of it I'm quite comfortable with.
>=20
> The only unfortunate thing in these patches is switching between
> OpenSSL and PolarSSL. This currently requires changing two flags
> instead of one, due to the build system. If anyone has any suggestions
> there, please let me know.
>=20
> Adriaan

I'll post the complete summary here, of what's included into the -testing
and -stable master branches.

> [PATCH 1/8] Moved prng_uninit out of crypto_uninit_lib
commit 54628d1ac10675d4554b58500341e35e8ac4fcbb
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 2/8] Moved CryptoAPI header include to the ssl_openssl.c
commit 9009aa464bd4d7c58cb9147d3b5344dc25792e57
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 3/8] Fixed missing comma in plugin.h
commit 8d22a9905d1243dbaf10493abdbb91718e8f9969
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 4/8] Reordered functions to ensure warning-free Windows build
commit 7ac7170d0a4b0bb8dadccf98795bba0e0f27d767
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

With an additional patch from Samuli:
* [PATCH] Fixed a regression causing VS2008/Python build failure
commit 354bc04286abe157f906309bb2ab463ac160c5a7
    Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 5/8] Added options to switch between OpenSSL and PolarSSL and
commit 7a8d707237bb18cb1c001205267f399772bdc840
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 6/8] Moved from strsep to strtok, for Windows compatibility
commit 1d90851ed012775b6c85379ee263c5f6ffc2021e
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 7/8] Minor cleanup to enable warning-free Windows build:
commit be960aad88a78967e6425be0d1dc36ea1af6f584
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Tested-by: Samuli Sepp=E4nen <samuli@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

> [PATCH 8/8] Fixed a typo when initialising cryptoapi certs
commit b6a8bada51347e67a34630b23e48483eea8d9548
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Heiko Hund <heiko.hund@...1489...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7KMGQACgkQDC186MBRfrqRDgCfcrAItK+TVG4bKGLWczfWgxXL
qK0An2YviBGzXWQb2GY1Fvl7D4ME/sMc
=3DkHIB
-----END PGP SIGNATURE-----

