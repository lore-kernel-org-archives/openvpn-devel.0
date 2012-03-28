Message-ID: <4F72CFC7.8040402@...1114...>
Date: Wed, 28 Mar 2012 10:45:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332797200-9295-4-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] cleanup: warnings at
	src/openvpn/httpdigest.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/03/12 23:26, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- 
> src/openvpn/httpdigest.c |   44
> ++++++++++++++++++++++---------------------- 1 files changed, 22
> insertions(+), 22 deletions(-)
> 
> diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c index
> 78b8344..a011e56 100644 --- a/src/openvpn/httpdigest.c +++
> b/src/openvpn/httpdigest.c @@ -76,20 +76,20 @@ DigestCalcHA1( const
> md_kt_t *md5_kt = md_kt_get("MD5");
> 
> md_ctx_init(&md5_ctx, md5_kt); -  md_ctx_update(&md5_ctx, pszUserName,
> strlen(pszUserName)); -  md_ctx_update(&md5_ctx, ":", 1); -
> md_ctx_update(&md5_ctx, pszRealm, strlen(pszRealm)); -
> md_ctx_update(&md5_ctx, ":", 1); -  md_ctx_update(&md5_ctx,
> pszPassword, strlen(pszPassword)); +  md_ctx_update(&md5_ctx, (uint8_t
> *)pszUserName, strlen(pszUserName)); +  md_ctx_update(&md5_ctx,
> (uint8_t *)":", 1); +  md_ctx_update(&md5_ctx, (uint8_t *)pszRealm,
> strlen(pszRealm)); +  md_ctx_update(&md5_ctx, (uint8_t *)":", 1); +
> md_ctx_update(&md5_ctx, (uint8_t *)pszPassword, strlen(pszPassword));

My remark here goes to all these type-cast patches [1,2,3].

Wouldn't it be way cleaner to rather fix the function declarations and do
the proper type-casting in the {crypto,ssl}_{open,polar}ssl.[ch] and
{crypto,ssl}_backend.h files?  Instead of type-casting the whole source
code where such warnings might pop up?


kind regards,

David Sommerseth


[1] <http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=6118>
[2] <http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=6119>
[3] <http://thread.gmane.org/gmane.network.openvpn.devel/5772/focus=6122>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9yz8cACgkQDC186MBRfrqHNgCggHTdTK2T0SacEtrhbVfpCYGw
37cAoJWTFnIFF5wSOG45s9ZO5wXtZm4E
=vKjb
-----END PGP SIGNATURE-----

