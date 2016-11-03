References: <1477670087-30063-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>
Date: Thu, 3 Nov 2016 19:21:54 +0100
MIME-Version: 1.0
In-Reply-To: <1477670087-30063-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor CRL handling
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net
Cc: Ivo Manca <ivo.manca@...1435...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/10/16 17:54, Steffan Karger wrote:
> This patch refactors the CRL handling to rely more on the
> implementation of the crypto library.  It will insert the CRL at
> the correct time to keep it up to date, but all additional
> verification logic is removed from ssl_verify_<backend>.c.  "Less
> code of our own, less bugs of our own."
>=20
> In practice, this means extra checks will be performed on the CRL,
> such as checking it validBefore and validAfter fields.
>=20
> This patch was originally written by Ivo Manca, and then molded by
> Steffan before sending to the list.  All bugs are Steffan's fault.
>=20
> Thanks also go to Antonio Quartulli for useful feedback.  He'll
> send follow-up patches to improve CRL handling performance.
>=20
> Signed-off-by: Ivo Manca <ivo.manca@...1435...> Signed-off-by:
> Steffan Karger <steffan.karger@...1435...> --- Changes.rst
> |  6 +++ src/openvpn/ssl.c                | 15 +++++++=20
> src/openvpn/ssl_backend.h        | 11 +++++=20
> src/openvpn/ssl_mbedtls.c        | 43 +++++++++++++++++-=20
> src/openvpn/ssl_mbedtls.h        |  1 + src/openvpn/ssl_openssl.c
> | 58 ++++++++++++++++++++++++ src/openvpn/ssl_verify.c         | 19
> ++++---- src/openvpn/ssl_verify_backend.h | 19 +++-----=20
> src/openvpn/ssl_verify_mbedtls.c | 56 +++--------------------=20
> src/openvpn/ssl_verify_openssl.c | 96
> ++++++++++++++++------------------------ 10 files changed, 193
> insertions(+), 131 deletions(-)

This is a bit scary.  I have nothing to complain about in the patch,
so I feel like I'm not seeing the large neon-pink elephant in the room.

I've run lots of tests, both with OpenSSL and mbedTLS.  Testing with
and without valgrind --leak-check=3Dfull.  Tested configurations without
- --crl, with --crl ca.crl and --crl crldir dir.

Every thing works as expected, no memory leaks detected.  It passes
'make check' including t_client.sh runs.  Traffic is passed over the
tunnel where certificate is not listed on a CRL.


There is one detail, which is not a fault of this patch ... but I'll
just mention it here.  The client does not exit gracefully on
rejections due to CRL.  It's not too odd, but should probably look
into if it would be possible to send an "AUTH_FAILED,REVOKED:
Certificate revoked" message back to the client.  But that's for a
different patch.


I can definitely give this one a Feature-ACK.  I can also support a
full ACK too if one more developer does a thorough code review.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYG4BCAAoJEIbPlEyWcf3yahUP/jP1fh4L+y4Ct2u61OVVJLIg
7g5nxw/S3j87tbqf5cyvP/Pw8GvB9klDqMt3MHPZLfG1fRpiJuOwPB/ad53WNdOf
BDN2NqlDpDFNT1Zv+VxM4B1SJlefMQGRvKS67PM3VESDdCVZ60p//AwvTyczi6lB
lgk+Wp/vOypdky3L1nxvH7iMsOJWdkE/DcvYFrryI+vFCBQjxp88V4X6MHxQKqRp
g2l5rSHXv0gh7A5BmnzZLIbUjJBpuCDZ4/TpkNAgScXeqGOGLyzT+S8kvNEdgVUG
jOkDQunJ6hcN1Hf3g1xltj+zoDoYh4iRSGqAHpURh4hgKVue1ElLXWGqS2vNzxRQ
vV0Nmt/4R6LTiCgKow7WX8kJxWfB83SKhpB9XCg1xri2tqwqwy7pNwVFhqcBjb9F
qHLb/z9vddMsgvTjuMwOH0DyQbXi9vyNTB+KadhkN9BSYBJaR4CHAddAdzOnEh+0
bjGNIbd9UVVbf+Bo8sqbjV3VVLJgV2gZgPK4HpxAY6DGno1Bfh0IYGNngR4w2+T7
QetPKsbOaa9w6k+Sc7sGuytZBhgJ4jtjPRBgZ13Q+cUpyVgl8UjxPS9YyxwHg0Mt
S02uLZvhqA8NMd3s4X7VGjPle4or1voMxiWGUonvrHR8PsoAVfEBfNK5xrvfkf8m
xjpM785uFGjPvbQkisTN
=3Dmk0U
-----END PGP SIGNATURE-----

