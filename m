References: <20190403225657.8003-1-rosenp@...277...>
 <c6020cbf-4340-7e24-9bbc-50fbe6b2112d@...1227...>
 <E1hqEpr-00074e-Ak@...2487...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d4746c92-25c2-4b4b-1cc4-0514624f669a@...1227...>
Date: Wed, 24 Jul 2019 13:14:05 +0200
MIME-Version: 1.0
In-Reply-To: <E1hqEpr-00074e-Ak@...2487...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCHv2] openssl: Fix compilation without
 deprecated OpenSSL 1.1 APIs
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
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 24.07.19 um 12:28 schrieb Steffan Karger:
> Hi all,
> 
> On 14-06-19 12:38, Arne Schwabe wrote:
>>> +#if !defined(HAVE_EVP_CIPHER_CTX_INIT)
>>> +#define EVP_CIPHER_CTX_init EVP_CIPHER_CTX_reset
>>> +#endif
>>> +
>>> +#if !defined(HAVE_EVP_CIPHER_CTX_CLEANUP)
>>> +#define EVP_CIPHER_CTX_cleanup EVP_CIPHER_CTX_reset
>>> +#endif
>>
>> These two keep the older API instead of switching to the new one, from
>> OpenSSL.
>>
>> # if OPENSSL_API_COMPAT < 0x10100000L
>> #  define EVP_CIPHER_CTX_init(c)      EVP_CIPHER_CTX_reset(c)
>> #  define EVP_CIPHER_CTX_cleanup(c)   EVP_CIPHER_CTX_reset(c)
>> # endif
>>
>> Since just using only the new API in this case does not really work I
>> think in case it would be better to rather always use
>> EVP_CIPHER_CTX_reset isntead of init and  have ifdefs in the 2-3 places
>> where we actually use EVP_CIPHER_CTX_cleanup so we can remove the old
>> API when we bump our minimum OpenSSL version (and find this thing easy
>> since it is an ifdef depending on the openssl version).

Okay, I double checked this.


The new API drops EVP_CIPHER_CTX_cleanup, so we have do either ifdef the
EVP_CIPHER_CTX_cleanup calls or remove them completely.

Currently we only call the EVP_CIPHER_CTX_cleanup directly before
EVP_CIPHER_CTX_free.

Looking at the 1.0.2 openssl code:


void EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *ctx)
{
   if (ctx) {
       EVP_CIPHER_CTX_cleanup(ctx);
      OPENSSL_free(ctx);
   }
}

it looks like the EVP_CIPHER_CTX_cleanup is implicit already, so we can
remove those call and drop the cipher_ctx_cleanup function and combine
cipher_ctx_cleanup and _free into one for mbed TLS.

Does that sound reasonble?

Arne

