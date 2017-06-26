References: <1498475606-8337-1-git-send-email-arne@...1227...>
	<20170626134412.4a4af754@...1799...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3dd1aa20-745f-4f2a-449e-8dcfa390ae7f@...1856...>
Date: Mon, 26 Jun 2017 20:16:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170626134412.4a4af754@...1799...>
Content-Language: en-US
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-06-17 13:44, Christian Hesse wrote:
> Arne Schwabe <arne@...1227...> on Mon, 2017/06/26 13:13:
>> OpenSSL 1.1 does not allow MD5 signed certificates by default anymore. This
>> can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=0" but only
>> if the cipher list is set before loading the certificates. This patch
>> changes the order of loading. --- src/openvpn/ssl.c | 8 +++++--- 1 file
>> changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 29280dce..9ca300c0 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -616,6 +616,11 @@ init_ssl(const struct options *options, struct
>> tls_root_ctx *new_ctx) tls_ctx_client_new(new_ctx);
>>      }
>>  
>> +    /* Allowable ciphers */
>> +    /* Since @SECLEVEL also influces loading of certificates, set the
>> +     * cipher restrictions before loading certificates */
>> +    tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
>> +
>>      tls_ctx_set_options(new_ctx, options->ssl_flags);
>>  
>>      if (options->pkcs12_file)
>> @@ -708,9 +713,6 @@ init_ssl(const struct options *options, struct
>> tls_root_ctx *new_ctx) tls_ctx_load_ecdh_params(new_ctx,
>> options->ecdh_curve); }
>>  
>> -    /* Allowable ciphers */
>> -    tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
>> -
>>  #ifdef ENABLE_CRYPTO_MBEDTLS
>>      /* Personalise the random by mixing in the certificate */
>>      tls_ctx_personalise_random(new_ctx);
> 
> Looks good and tested on a server with CA and server certificates using MD5.
> So ACK.

MD5 must die, die, die.  People still using MD5 certs should be thankful
that OpenSSL pointed out this security hole in their setup, and fix that
by immediately issuing SHA2 certs...

That said, the patch does not specifically allow MD5, makes sense by
itself, and passes my tests.  So, ACK.

-Steffan

