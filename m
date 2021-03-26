References: <20210325000121.10331-1-arne@...1227...>
 <20210325000121.10331-2-arne@...1227...>
 <b418f610-6e7e-ba3c-8c30-6e0ef0c50fa5@...2181...>
 <20210326065851.GP976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4d294744-b5d1-22a2-2723-80a1cad3005c@...1227...>
Date: Fri, 26 Mar 2021 12:05:28 +0100
MIME-Version: 1.0
In-Reply-To: <20210326065851.GP976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] Remove deprecated option '--keysize'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Am 26.03.21 um 07:58 schrieb Gert Doering:
> Hi,
> 
> On Fri, Mar 26, 2021 at 12:12:40AM +0100, Antonio Quartulli wrote:
>>> -#ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
>>> +    /* This serves as a check that the keylen is the correct as this fails
>>> +     * when key_len and the fixed size of cipher disagree */
>>>      if (!EVP_CIPHER_CTX_set_key_length(ctx, key_len))
>>
>> Are you sure we need to keep this check?
> 
> Indeed, that also got me wondering (and is the reason why I didn't
> just ack-and-merge it right away :-) - but I was waiting for someone
> else to understand and ACK this)
>

The reason I kept it that it doesn't hurt but fails if something fishy
happend in cipher handling. For mbed TLS the check is more useful as it
doesn't set the keylen before doing this check.

Arne

