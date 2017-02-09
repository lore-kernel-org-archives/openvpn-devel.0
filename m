MIME-Version: 1.0
In-Reply-To: <c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
From: Olivier W <olivierw.ml@...277...>
Date: Thu, 9 Feb 2017 21:04:34 +0100
Message-ID: <CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,
Please find the new version of the patch.

So, I added back the comment I had removed and new versions of OpenSSL
will use SSL_CTX_get0_privatekey() instead of SSL_new() +
SSL_get_privatekey() + SSL_free().

It successfully compile with LibreSSL 2.4.5, 2.5.1 and OpenSSL 1.0.2k.
I've also pushed it to Github and Travis-CI is currently running:
https://github.com/OpenVPN/openvpn/pull/82

Best Regards,
Olivier

---
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8266595..abf69c9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -508,10 +508,18 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx
*ctx, const char *curve_name
         const EC_GROUP *ecgrp = NULL;
         EVP_PKEY *pkey = NULL;

+#if OPENSSL_VERSION_NUMBER >= 0x10002000L && !defined(LIBRESSL_VERSION_NUMBER)
+        pkey = SSL_CTX_get0_privatekey(ctx->ctx);
+#else
         /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
-        SSL ssl;
-        ssl.cert = ctx->ctx->cert;
-        pkey = SSL_get_privatekey(&ssl);
+        SSL *ssl = SSL_new(ctx->ctx);
+        if (!ssl)
+        {
+            crypto_msg(M_FATAL, "SSL_new failed");
+        }
+        pkey = SSL_get_privatekey(ssl);
+        SSL_free(ssl);
+#endif

         msg(D_TLS_DEBUG, "Extracting ECDH curve from private key");

2017-02-08 23:39 GMT+01:00 Steffan Karger <steffan@...1856...>:
> Hi,
>
> On 06-02-17 20:18, Olivier W wrote:
>> Should be compatible with all versions of OpenSSL and LibreSSL.
>> Similar to what is done in curl:
>> https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d565900355/lib/vtls/openssl.c#L603-L619
>>
>> Error while compiling was:
>> "ssl_openssl.c:512:30: error: no member named 'cert' in 'struct ssl_ctx_st'
>> ssl.cert = ctx->ctx->cert;
>> ~ ^
>> 1 error generated.
>> *** Error code 1"
>> ---
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index 8266595..a889332 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -508,10 +508,13 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx
>> *ctx, const char *curve_name
>>          const EC_GROUP *ecgrp = NULL;
>>          EVP_PKEY *pkey = NULL;
>>
>> -        /* Little hack to get private key ref from SSL_CTX, yay OpenSSL... */
>> -        SSL ssl;
>> -        ssl.cert = ctx->ctx->cert;
>> -        pkey = SSL_get_privatekey(&ssl);
>> +        SSL *ssl = SSL_new(ctx->ctx);
>> +        if (!ssl)
>> +        {
>> +            crypto_msg(M_FATAL, "SSL_new failed");
>> +        }
>> +        pkey = SSL_get_privatekey(ssl);
>> +        SSL_free(ssl);
>
> The code change looks good, and passes my (manual) tests.  I'd like to
> keep the comment though, because this still is a hack/workaround to get
> the private key from the SSL_CTX object, it just does so a little nicer
> at the cost of a number of malloc/free calls.
>
> It might be even worth noting that the workaround is only needed for
> OpenSSL <= 1.0.1, because later versions do have a function to get the
> private key from a struct SSL_CTX directly.  By noting that explicitly,
> we help ourselves remember to get rid of the hack as soon as we drop
> support for these OpenSSL versions.
>
> -Steffan
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

