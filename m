References: <1498475606-8337-1-git-send-email-arne@...1227...>
	<99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
	<73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
	<96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
	<a486ae43-afd7-5066-5f32-459c90c7a976@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <cdb9b9a5-8df4-e5d9-5632-fb48bf7314f2@...1227...>
Date: Mon, 26 Jun 2017 16:00:19 +0200
MIME-Version: 1.0
In-Reply-To: <a486ae43-afd7-5066-5f32-459c90c7a976@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


>>>
>>> See this also a bugfix. Since tls-cipher options affect certificate
>>> loading, it is good to set it before certificate loading. E.g. you might
>>> want to use @SECLEVEL=5 to only allow loading of SHA256 based certificates.
> Oh, btw ... We need to align this with another patch-set from Steffan.
> There is a feature we have in OpenVPN 3 and the proposed patches from
> Steffan which adds --tls-cert-profile.  This is aimed at controlling
> what kind of TLS security parameters which is required.
> 
> Currently there is an agreement of the following profiles:
> 
>   - legacy: SHA1 and newer, RSA 2048-bit+, any elliptic curve.
>   - preferred: SHA2 and newer, RSA 2048-bit+, any elliptic curve.
>                (default in v2.5)
>   - suiteb: SHA256/SHA384, ECDSA with P-256 or P-384.
> 
> The mbed TLS definition of these profiles in OpenVPN 3 is like this.
> 
>   const mbedtls_x509_crt_profile crt_profile_legacy = // CONST GLOBAL
>         {
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
>           0xFFFFFFF, /* Any PK alg    */
>           0xFFFFFFF, /* Any curve     */
>           1024,      /* Minimum size for RSA keys */
>         };
> 
>   const mbedtls_x509_crt_profile crt_profile_preferred = // CONST GLOBAL
>         {
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
>           MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
>           0xFFFFFFF, /* Any PK alg    */
>           0xFFFFFFF, /* Any curve     */
>           2048,      /* Minimum size for RSA keys */
>         };
> 
> 
> The suiteb profile is just reusing the mbed TLS definition directly.
> 
> With that said ... The legacy profile does not include MD5.  So either
> we allow MD5 into the legacy profile; or we need legacy-md5.
> 


Yes but I think that is seperate effort. I am not sure how to probably
implment that with OpenSSL. SECLEVEL is similar but does not have
exactly the same consequences. YOu could probably emulate the profiles
with some kind of tls-cipher settings. But if you do that, you still
need this patch :)

Arne

