References: <20190223180241.18374-1-stefan.strogin@...277...>
 <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
From: Stefan Strogin <stefan.strogin@...277...>
Message-ID: <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>
Date: Mon, 25 Feb 2019 08:29:28 +0200
MIME-Version: 1.0
In-Reply-To: <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

Thanks for the reply. Please see my comments and a clarifying question below.

On 24/02/2019 03:28, Arne Schwabe wrote:
> And I
> am getting quite fed up with way that LibreSSL does API compatiblity. It
> claims to support OpenSSL 2.0.0 API when it clearly doesn't.

Sorry, but LibreSSL officially claims only compatibility with OpenSSL 1.0.1:
https://github.com/libressl-portable/portable
However, practically most of OpenSSL 1.1 API is supported by LibreSSL.

> The || !defined(LIBRESSL_VERSION_NUMBER) means that I have no idea of
> knowing when it is safe to remove the code. The idea of having the
> OPENSSL_VERSION macros is to remove the ifdefs when we drop support for
> old version but the unversioned LIBRESSL sounds like we would have to
> keep ancient OpenSSL APIs forever in the code to support LibreSSL.
> 
> Your comment that TLS 1.3 and SSL_get1_supported_ciphers will become
> available with some later LibreSSL, means that the current patch is
> wrong here and we will need to patch it again.
> 
> In summary I really do not like this stuff. But I also accept that
> having these defines in there makes same sense to have at least
> unofficial support.  If you can send a follow up patch that at least
> uses some feature or libressl version in the ifdef, we have an easier
> time identifying those parts in the future to be obsolete.

I see your point.
Regarding TLS 1.3. LibreSSL 2.9.0 (current development release) defines
OPENSSL_NO_TLS1_3, but LibreSSL <2.9.0 doesn't. Therefore it could be:

#if (OPENSSL_VERSION_NUMBER < 0x1010100fL) \
    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x2090000fL) \
    || defined(OPENSSL_NO_TLS1_3)
    crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
               "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
(...)

alternatively we can just use TLS1_3_VERSION instead of all version numbers, i.e.:

#if !defined(TLS1_3_VERSION)
    crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
               "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
(...)

AFAIK in theory OpenSSL >=1.1.1 can be built without TLS 1.3 support, unlikely
in practice though.
Which ifdef will you prefer?

Regarding SSL_get1_supported_ciphers. [Based upon current LibreSSL release schedule
(2.9.x is a current development branch which will be part of OpenBSD 6.5) and that
this method was added soon after 2.9.0 release], I think it will be correct:
#if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || \
    (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x2090100fL)

I also see other 'defined(LIBRESSL_VERSION_NUMBER)' ifdefs that don't specify
exact LibreSSL version number. I agree that it is not correct, and it is not nice
to force deprecated functions on users of newer LibreSSL, when newer API is
available. So if you don't mind I'll try to fix them as well in a follow-up patch.

--
Stefan

> 
> Arne
> 
>> Signed-off-by: Stefan Strogin <stefan.strogin@...277...>
>> ---
>>  src/openvpn/ssl_openssl.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index ddb78da7..fcaac080 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -465,7 +465,7 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
>>          return;
>>      }
>>  
>> -#if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
>> +#if (OPENSSL_VERSION_NUMBER < 0x1010100fL) || defined(LIBRESSL_VERSION_NUMBER)
>>      crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
>>                 "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
>>                 ciphers);
>> @@ -1998,7 +1998,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
>>          crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
>>      }
>>  
>> -#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
>> +#if (OPENSSL_VERSION_NUMBER >= 0x1010100fL && !defined(LIBRESSL_VERSION_NUMBER))
>>      if (tls13)
>>      {
>>          SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
>> @@ -2019,7 +2019,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
>>          crypto_msg(M_FATAL, "Cannot create SSL object");
>>      }
>>  
>> -#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)
>> +#if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || defined(LIBRESSL_VERSION_NUMBER)
>>      STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
>>  #else
>>      STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
>>
> 


