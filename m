References: <20200414185214.1863-1-juliusz@...2525...>
 <c33a84b3-b10a-a8c2-d46a-3ee2d296f7f1@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <8b1d14d6-9ca4-46f3-b038-0fbc5af568ff@...2525...>
Date: Thu, 16 Apr 2020 12:42:15 +0200
MIME-Version: 1.0
In-Reply-To: <c33a84b3-b10a-a8c2-d46a-3ee2d296f7f1@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Arne,

On 15/04/2020 11:31, Arne Schwabe wrote:
> Am 14.04.20 um 20:52 schrieb Juliusz Sosinowicz:
>> This patch adds support for wolfSSL in OpenVPN. Support is added by using wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged and instead the OpenSSL includes point to wolfSSL headers and OpenVPN is linked against the wolfSSL library.
>>
>> As requested by OpenVPN maintainers, this patch does not include wolfssl/options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include wolfssl/options.h on its own (change added in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an option '--disable-wolfssl-options-h' in case the user would like to supply their own settings file for wolfSSL.
>>
> Thanks the patch is lot less intrusive then the last version. We will
> have to discuss in our meeting under what condition we want to include
> the patch. We might add a note or statement that the WolfSSL support in
> OpenVPN is mainly developed and tested by WolfSSL itself or something
> along these lines.
This is understandable since we will be maintaining wolfSSL within OpenVPN.
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 453cb20a..73da5fa7 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -428,7 +428,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
>>       tag_ptr = BPTR(buf);
>>       ASSERT(buf_advance(buf, tag_size));
>>       dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
>> -#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L
>> +#if (defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L) || defined(ENABLE_CRYPTO_WOLFSSL)
>>       /* OpenSSL <= 1.0.1c bug requires set tag before processing ciphertext */
>>       if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size, tag_ptr))
>>       {
> Are you sure that WolfSSL requires a workaround for old OpenSSL version
> before 1.0.1d?
wolfSSL is built around one-shot APIs as oppose to OpenSSL's stream 
APIs. The reason for using this workaround is that the authentication 
tag is checked in the Update call not the Final call. I'll look into 
fixing this issue.
> Arne
>
Thanks!
Juliusz

