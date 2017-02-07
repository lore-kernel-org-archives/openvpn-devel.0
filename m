MIME-Version: 1.0
In-Reply-To: <20170207041451.GA11922@...2182...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<20170207041451.GA11922@...2182...>
From: Olivier W <olivierw.ml@...277...>
Date: Tue, 7 Feb 2017 12:13:06 +0100
Message-ID: <CAOAUwZGfHUR2NQq9VtbknFvzr0YHWX4GKbqSL9F6veNCPAny=w@...278...>
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

Good question. For the test, I looked how it was done in other parts
of ssl_openssl.c, like around line 1518:
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_openssl.c#L1518-L1522
and did the same.
And as said by Gert, crypto_msg() solve it.

I'm sorry, in my first message, I fortgot to add a link to my pull
request on Github: https://github.com/OpenVPN/openvpn/pull/82

Best Regards.

2017-02-07 5:14 GMT+01:00 Antonio Quartulli <a@...2181...>:
> On Mon, Feb 06, 2017 at 08:18:01PM +0100, Olivier W wrote:
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
> I have a question (sorry if I couldn't check myself): did you check that
> SSL_get_privatekey() and SSL_free() won't crash when ssl is NULL ?
>
> Cheers,
>
>
> --
> Antonio Quartulli

