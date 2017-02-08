References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f0ff751e-8171-5f1e-19b1-a208bc50ac6a@...1227...>
Date: Thu, 9 Feb 2017 00:13:31 +0100
MIME-Version: 1.0
In-Reply-To: <c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 08.02.17 um 23:39 schrieb Steffan Karger:
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
SOund like adding an ifdef for >= 1.0.2 would be a good idea when we
touch this code now anyway.

Arne


