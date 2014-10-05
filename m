Message-ID: <543133A4.8000701@...1856...>
Date: Sun, 05 Oct 2014 14:03:48 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1411727041-11884-1-git-send-email-hkario@...1347...>
In-Reply-To: <1411727041-11884-1-git-send-email-hkario@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] ocsp_check - signature verification
 and cert staus results are separate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ACK

- -Steffan

On 26-09-14 12:24, Hubert Kario wrote:
> when openssl returns result of parsing and verification of the OCSP
> response, the signature verification is separate from the
> certificate status, as such it's necessary to check both of them.
> 
> Otherwise results like:
> 
> Response Verify Failure 140170966779776:error:27069076:OCSP
> routines:OCSP_basic_verify:signer certificate not
> found:ocsp_vfy.c:85: ca/cert.pem: good This Update: Sep 23 12:12:28
> 2014 GMT
> 
> will be accepted as being trustworthy.
> 
> Note that "Response verify OK" is printed on stderr, so it can't be
> discarded.
> 
> Signed-off-by: Hubert Kario <hkario@...1347...> --- 
> contrib/OCSP_check/OCSP_check.sh | 9 ++++++--- 1 file changed, 6
> insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/OCSP_check/OCSP_check.sh
> b/contrib/OCSP_check/OCSP_check.sh index 553c3dc..ce7ec04 100644 
> --- a/contrib/OCSP_check/OCSP_check.sh +++
> b/contrib/OCSP_check/OCSP_check.sh @@ -97,12 +97,15 @@ if [
> $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then 
> "$nonce" \ -CAfile "$verify" \ -url "$ocsp_url" \ -
> -serial "${serial}" 2>/dev/null) +                    -serial
> "${serial}" 2>&1)
> 
> if [ $? -eq 0 ]; then -      # check that it's good +      # check
> that the reported status of certificate is ok if echo "$status" |
> grep -Fq "^${serial}: good"; then -        exit 0 +        # check
> if signature on the OCSP response verified correctly +        if
> echo "$status" | grep -Fq "^Response verify OK"; then +
> exit 0 +        fi fi fi fi
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJUMTOWAAoJEJgCyj0AftKIH94H/AmwiKXEaT+k32B5Qie33iNa
r38WbFtQoTDKJAlZZ4ykGhgqo5bVoec/zVYJaGVmBYVDFUK8lzL6xaeIOT5aQbQ4
L3noEtdzRPpS+sSMLrFA+MinRLDaknbFArIc9JjkSV2Z8vNw4R3cJnKtzss7ZJ7N
aPpD6porhLK/phCP4dtqwZo5iEqXyfX1pW2ThzUbgfZ2wmdf1S6Ja8/40ZwQiCrN
aIkfnAXt/2PLSPIuCcE3hQTdJx4hp68pEo7Xl0jtYFKDNVUC7NDVfDO9BztbrfVP
MIxDDneS0JB93YNqcu8Ah0GKBM354h1jvjaB/XtAncVjjfCHHzYk36doxlXeqRw=
=G1/O
-----END PGP SIGNATURE-----

