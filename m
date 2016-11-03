References: <1477670087-30063-1-git-send-email-steffan.karger@...1435...>
	<e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5c580505-2837-77fa-2c42-1a70fe9f5fac@...1856...>
Date: Thu, 3 Nov 2016 22:48:06 +0100
MIME-Version: 1.0
In-Reply-To: <e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9LhXNs4UEhUh1x2IdeUinrSv0FOFb304p"
Subject: Re: [Openvpn-devel] [PATCH] Refactor CRL handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9LhXNs4UEhUh1x2IdeUinrSv0FOFb304p
Content-Type: multipart/mixed; boundary="WgU0k5L5FHfxFLvSGWHPxj1e3N94SbpRv"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5c580505-2837-77fa-2c42-1a70fe9f5fac@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor CRL handling
References: <1477670087-30063-1-git-send-email-steffan.karger@...1435...>
	<e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>
In-Reply-To: <e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>

--WgU0k5L5FHfxFLvSGWHPxj1e3N94SbpRv
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03-11-16 19:21, David Sommerseth wrote:
> On 28/10/16 17:54, Steffan Karger wrote:
>> This patch refactors the CRL handling to rely more on the
>> implementation of the crypto library.  It will insert the CRL at
>> the correct time to keep it up to date, but all additional
>> verification logic is removed from ssl_verify_<backend>.c.  "Less
>> code of our own, less bugs of our own."
>=20
>> In practice, this means extra checks will be performed on the CRL,
>> such as checking it validBefore and validAfter fields.
>=20
>> This patch was originally written by Ivo Manca, and then molded by
>> Steffan before sending to the list.  All bugs are Steffan's fault.
>=20
>> Thanks also go to Antonio Quartulli for useful feedback.  He'll
>> send follow-up patches to improve CRL handling performance.
>=20
>> Signed-off-by: Ivo Manca <ivo.manca@...1435...> Signed-off-by:
>> Steffan Karger <steffan.karger@...1435...> --- Changes.rst
>> |  6 +++ src/openvpn/ssl.c                | 15 +++++++=20
>> src/openvpn/ssl_backend.h        | 11 +++++=20
>> src/openvpn/ssl_mbedtls.c        | 43 +++++++++++++++++-=20
>> src/openvpn/ssl_mbedtls.h        |  1 + src/openvpn/ssl_openssl.c
>> | 58 ++++++++++++++++++++++++ src/openvpn/ssl_verify.c         | 19
>> ++++---- src/openvpn/ssl_verify_backend.h | 19 +++-----=20
>> src/openvpn/ssl_verify_mbedtls.c | 56 +++--------------------=20
>> src/openvpn/ssl_verify_openssl.c | 96
>> ++++++++++++++++------------------------ 10 files changed, 193
>> insertions(+), 131 deletions(-)
>=20
> This is a bit scary.  I have nothing to complain about in the patch,
> so I feel like I'm not seeing the large neon-pink elephant in the room.

What probably makes a difference here is that this patch was not
originally written by me ;)  Seriously though, the patch was written by
my colleague, reviewed and slightly adjusted by me, then got some
comments from Antonio and then finally molded to it's current form.  So
it already got quite some off-list review.  Also, I ran our OpenVPN-NL
test suite against (the mbed TLS version of) this patch, which verifies
correct behaviour for a number of more advanced CA setups (including
intermediate CAs, revoked intermediates, invalid CRLS, etc...).

Still, this does change behaviour (e.g. rejecting expired CRLS), so will
probably reject some connections that earlier versions would accept.
But I'd consider that a fix, not a bug.

> I've run lots of tests, both with OpenSSL and mbedTLS.  Testing with
> and without valgrind --leak-check=3Dfull.  Tested configurations without
> --crl, with --crl ca.crl and --crl crldir dir.
>=20
> Every thing works as expected, no memory leaks detected.  It passes
> 'make check' including t_client.sh runs.  Traffic is passed over the
> tunnel where certificate is not listed on a CRL.
>=20
>=20
> There is one detail, which is not a fault of this patch ... but I'll
> just mention it here.  The client does not exit gracefully on
> rejections due to CRL.  It's not too odd, but should probably look
> into if it would be possible to send an "AUTH_FAILED,REVOKED:
> Certificate revoked" message back to the client.  But that's for a
> different patch.

We can't send AUTH_FAILED, because we have no control channel to send it
over yet (see other mail thread).

> I can definitely give this one a Feature-ACK.  I can also support a
> full ACK too if one more developer does a thorough code review.

Thanks!

-Steffan


--WgU0k5L5FHfxFLvSGWHPxj1e3N94SbpRv--

--9LhXNs4UEhUh1x2IdeUinrSv0FOFb304p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYG7CsAAoJEJgCyj0AftKIa+4H/30aQKM9ARGZkp3B/QvfGxjT
9eYdIZtDqptKxv2adM6y/0y3GTrmJeVCK01mbM47pgvARfYxo0LGHAB+stmcI8/Q
7PRq9lmpVBDQ3Sd0R2GKuQlWg7kYemDC/GOoIFlpokh4HeI7MPfZBUIALKSMJ9wq
AaXD6bssCiOUBecxVmpInJWs2mBZlz28xmGbIgW7Ab0FYcoe0gKr3CZoGQMLXaG4
8s2hU2b+6p/PH9zLTl5Mi8cwbCyuuYTqcCjZcaYVvdNvb/tSUQidpneJwPvxWalJ
+vALFEQOA2hZWgIlWBpdVLJCzJdfyS8ussH5fS0hFCve2Di1UAQNNU2S8EPcFlQ=
=6kZK
-----END PGP SIGNATURE-----

--9LhXNs4UEhUh1x2IdeUinrSv0FOFb304p--

