References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <7b2c0430-4d5a-1e7e-334c-9292193b2a2d@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ce2afd5b-cd48-8623-eaf0-0a03ee146436@...1856...>
Date: Sun, 7 Oct 2018 20:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <7b2c0430-4d5a-1e7e-334c-9292193b2a2d@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in
 the data channel
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

Thank for review.  I'l be getting back on your other comments later, for
now just:

On 07-10-18 15:36, Antonio Quartulli wrote:
> On 07/10/18 21:28, Antonio Quartulli wrote:
>>> +#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >= 0x020C0000)
>>
>> Why do we need the dual condition? Isn't MBEDTLS_CHACHAPOLY_C enough to
>> know mbedTLS has what we need? Or you feel like we have to demand a
>> specific mbedTLS version when using ChaCha20?
> 
> Just to reinforce my argument: ChaCha20-Poly1305 was introduced with
> ce66d5e8e (in mbedTLS upstream) and a quick search shows:
> 
> mbedtls $ git tag --contains ce66d5e8e
> mbedtls-2.12.0
> mbedtls-2.13.0
> mbedtls-2.13.1
> 
> Given that 2.12 is 0x020C0000, I am fairly sure there is no reason to
> have both conditions in the if guard.
> But I might still be missing something.
> 
> (p.s. I am arguing simply because I want to avoid more version-based
> ifdef that may become new nightmares)

Which is a good cause, but that unfortunately won't work here. That is
because the actual implementation was introduced in dca3a5d8, which is
already in 2.9.0. So we do need the version. Unless you've got another
trick up your sleeve to avoid it, what I would love to hear.

-Steffan

