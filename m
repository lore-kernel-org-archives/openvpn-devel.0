References: <20210810061644.20353-1-maximilian.fillinger@...2507...>
 <24434d68-f25e-1a86-0f26-259fbef3ae04@...1227...>
 <cbc66884a8d04016bb73fb75c500f67c@...2507...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a1aef3e0-240c-3bb3-57c4-4b3e21976262@...1227...>
Date: Tue, 10 Aug 2021 12:23:23 +0200
MIME-Version: 1.0
In-Reply-To: <cbc66884a8d04016bb73fb75c500f67c@...2507...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Replace deprecated mbedtls DRBG update
 function
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
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 10.08.21 um 12:17 schrieb Maximilian Fillinger:
>> From: Arne Schwabe [mailto:arne@...1227...]
>> Sent: dinsdag 10 augustus 2021 12:12
>> To: Maximilian Fillinger <maximilian.fillinger@...2507...>; openvpn-
>> devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] [PATCH] Replace deprecated mbedtls DRBG
>> update function
>>
>> Am 10.08.21 um 08:16 schrieb Max Fillinger:
>>> +#if MBEDTLS_VERSION_NUMBER < 0x02100000
>>
>> Is that really 2.16? Looking at the API doc
>> (https://tls.mbed.org/api/version_8h.html#adb4f54ebb33fd1a25e2c4d4480cf4
>> 936)
>> it sounds like there should be a 16 in that number.
> 
> It's a hexadecimal 16. Version 2.26.0 for example does
> 
> #define MBEDTLS_VERSION_NUMBER         0x021A0000
> 
Oh well that is confusing. Thanks for clearing that up.

Arne

