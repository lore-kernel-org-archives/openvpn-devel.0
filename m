References: <20210325000121.10331-1-arne@...1227...>
 <20210325000121.10331-2-arne@...1227...>
 <b418f610-6e7e-ba3c-8c30-6e0ef0c50fa5@...2181...>
 <20210326065851.GP976@...1296...>
 <4d294744-b5d1-22a2-2723-80a1cad3005c@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <48334b64-b24f-f412-0188-502cc9f70cf5@...2181...>
Date: Sun, 28 Mar 2021 00:15:06 +0100
MIME-Version: 1.0
In-Reply-To: <4d294744-b5d1-22a2-2723-80a1cad3005c@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Remove deprecated option '--keysize'
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
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 26/03/2021 12:05, Arne Schwabe wrote:
> Am 26.03.21 um 07:58 schrieb Gert Doering:
>> Hi,
>>
>> On Fri, Mar 26, 2021 at 12:12:40AM +0100, Antonio Quartulli wrote:
>>>> -#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
>>>> +    /* This serves as a check that the keylen is the correct as this fails
>>>> +     * when key_len and the fixed size of cipher disagree */
>>>>      if (!EVP_CIPHER_CTX_set_key_length(ctx, key_len))
>>>
>>> Are you sure we need to keep this check?
>>
>> Indeed, that also got me wondering (and is the reason why I didn't
>> just ack-and-merge it right away :-) - but I was waiting for someone
>> else to understand and ACK this)
>>
> 
> The reason I kept it that it doesn't hurt but fails if something fishy
> happend in cipher handling. For mbed TLS the check is more useful as it
> doesn't set the keylen before doing this check.
> 

I'd dare to say that if we don't trust OpenSSL in returning a meaningful
key length, I am not sure why we should trust it when calling
EVP_CIPHER_CTX_set_key_length.

If OpenSSL went cocoon, more calls will fail for sure.

This said, if you really wanna stick with EVP_CIPHER_CTX_set_key_length,
I presume you should add it back to the configure.ac and you should also
add again the ifdef around the invocation? Or that's not needed in this
case?


Regarding mbedtls I am not sure how it is related to calling
EVP_CIPHER_CTX_set_key_length.

Cheers!

-- 
Antonio Quartulli

