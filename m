Message-ID: <b56f6c79-b11f-cff3-24ee-2fb1b9f822d1@...1227...>
Date: Mon, 6 Dec 2021 01:41:38 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211201180727.2496903-1-arne@...1227...>
 <20211201180727.2496903-3-arne@...1227...> <Yaz3zz8acJfit0iJ@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Yaz3zz8acJfit0iJ@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 3/9] Remove cipher_ctx_get_cipher_kt and
 replace with direct context calls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 05.12.21 um 18:33 schrieb Gert Doering:
> Hi,
> 
> On Wed, Dec 01, 2021 at 07:07:21PM +0100, Arne Schwabe wrote:
>> We currently have a number of calls that fetch the cipher_kt from a
>> cipher_ctx to then do a query on the cipher_kt. Directly fetching the
>> desired property from the context is cleaner and helps for using the
>> proper APIs with OpenSSL 3.0 and mbed TLS 3.0
> 
> Generally speaking this seems reasonable, I just wonder about
> two things:
> 
>> @@ -68,12 +68,10 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
>>       int outlen = 0;
>>       const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
>>       uint8_t *mac_out = NULL;
>> -    const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
>>       const int mac_len = OPENVPN_AEAD_TAG_LENGTH;
>>   
>>       /* IV, packet-ID and implicit IV required for this mode. */
>>       ASSERT(ctx->cipher);
>> -    ASSERT(cipher_kt_mode_aead(cipher_kt));
>>       ASSERT(packet_id_initialized(&opt->packet_id));
> 
> This ASSERT goes away now.  It's there to ensure that "yeah, we're
> really using an AEAD ciphere here" - which should, of course, never
> trigger, but I assume Steffan had some reason to put it here.

Since we no longer use cipher_kt in that function at all, we also no 
longer need to check it if it is AEAD. On  the ctx we already check if 
it is AEAD before calling this function:

         if (cipher_ctx_mode_aead(opt->key_ctx_bi.encrypt.cipher))
         {
             openvpn_encrypt_aead(buf, work, opt);
         }

It is basically a overly cautions "Is the cipher type really AEAD from a 
AEAD context?"

> 
>> @@ -371,7 +364,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
>>       ASSERT(frame);
>>       ASSERT(buf->len > 0);
>>       ASSERT(ctx->cipher);
>> -    ASSERT(cipher_kt_mode_aead(cipher_kt));
> 
> Same thing here.
> 
> So - can we be "crypto level" secure that this is never needed?

Same here.



