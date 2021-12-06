Message-ID: <1cc6827a-9cd2-7aaa-ec15-5bf3fb226206@...1227...>
Date: Mon, 6 Dec 2021 01:44:38 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211201180727.2496903-1-arne@...1227...>
 <20211201180727.2496903-5-arne@...1227...> <Yaz5gxzcCSAgQhlV@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Yaz5gxzcCSAgQhlV@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 5/9] Remove key_type->cipher_length field
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

Am 05.12.21 um 18:40 schrieb Gert Doering:
> Hi,
> 
> On Wed, Dec 01, 2021 at 07:07:23PM +0100, Arne Schwabe wrote:
>> This field is only set once to cipher_kt_key_size(kt.cipher) at the same
>> time that kt.cipher is set and therefore completely redundant.
> [..]
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -744,8 +744,6 @@ init_key_type(struct key_type *kt, const char *ciphername,
>>               msg(M_FATAL, "Cipher %s not supported", ciphername);
>>           }
>>   
>> -        kt->cipher_length = cipher_kt_key_size(kt->cipher);
>> -
>>           /* check legal cipher mode */
>>           aead_cipher = cipher_kt_mode_aead(kt->cipher);
>>           if (!(cipher_kt_mode_cbc(kt->cipher)
>> @@ -811,21 +809,20 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
> [..]
>>           const char *ciphername = cipher_kt_name(kt->cipher);
>>           msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
>>               prefix,
>>               ciphername,
>> -            kt->cipher_length *8);
>> +            cipher_kt_key_size(kt->cipher));
> 
> This does not look right.  Shouldn't it be "cipher_kt_key_size() * 8", then?
> 

You are correct.

Arne

