From: Antonio Quartulli <a@...2181...>
References: <20200402081829.28362-1-arne@...1227...>
 <20200402103821.10347-1-arne@...1227...>
 <3e15acf9-30a4-1b1d-581a-7366e4b58c45@...2181...>
Message-ID: <597dfec9-32d8-3d3d-f2d5-88aa13fba22a@...2181...>
Date: Thu, 2 Apr 2020 15:21:10 +0200
MIME-Version: 1.0
In-Reply-To: <3e15acf9-30a4-1b1d-581a-7366e4b58c45@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Fix OpenSSL error stack handling of
 tls_ctx_add_extra_certs
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 02/04/2020 15:15, Antonio Quartulli wrote:
> Hi,
> 
> On 02/04/2020 12:38, Arne Schwabe wrote:
>> Commit f67efa94 exposed that tls_ctx_add_extra_certs will always leave
>> an error of PEM_R_NO_START_LINE on the stack that will printed the next
>> time that the error is printed.
>>
>> Fix this by discarding this error. Also clean up the logic to report
>> real error on other errors and also the no start line error if no
>> certificate can be found at all and it is required (--extra-certs
>> config option)
>>
>> Patch V2: fix optional flag was flipped betwen --cert and --extra-certs
>> Patch V3: Make logic more easy to follow, no functional changes
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/ssl_openssl.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index 3f0031ff..1731474d 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -881,24 +881,36 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
>>  #endif /* ENABLE_CRYPTOAPI */
>>  
>>  static void
>> -tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio)
>> +tls_ctx_add_extra_certs(struct tls_root_ctx *ctx, BIO *bio, bool optional)
>>  {
>>      X509 *cert;
>> -    for (;; )
>> +    while (true)
>>      {
>>          cert = NULL;
>> -        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL)) /* takes ownership of cert */
>> -        {
>> -            break;
>> -        }
>> -        if (!cert)
>> +        if (!PEM_read_bio_X509(bio, &cert, NULL, NULL))
>>          {
>> +            /*  Error indicates that no certificate is found in the buffer.

there is also a typ0 in the line above: certificateS -> certificate.


-- 
Antonio Quartulli

