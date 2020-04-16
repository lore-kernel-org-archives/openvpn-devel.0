References: <20200414185214.1863-1-juliusz@...2525...>
 <20200415094851.GE1431@...1296...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <ca421473-263a-099e-2e1a-77f53330fe5b@...2525...>
Date: Thu, 16 Apr 2020 12:49:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200415094851.GE1431@...1296...>
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
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

thanks for the suggestion. I will change this in the next patch after 
looking into the issue that Arne brought up.

On 15/04/2020 11:48, Gert Doering wrote:
> Hi,
>
> as Arne said, this is much better.
>
> On Tue, Apr 14, 2020 at 08:52:14PM +0200, Juliusz Sosinowicz wrote:
>> This patch adds support for wolfSSL in OpenVPN. Support is added by using wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged and instead the OpenSSL includes point to wolfSSL headers and OpenVPN is linked against the wolfSSL library.
> [..]
>
> There is one thing, though:
>
>> index 30eba7b2..a82c52ad 100644
>> --- a/src/openvpn/cryptoapi.c
>> +++ b/src/openvpn/cryptoapi.c
>> @@ -39,6 +39,10 @@
>>   
>>   #ifdef ENABLE_CRYPTOAPI
>>   
>> +#ifdef ENABLE_CRYPTO_WOLFSSL
>> +#error wolfSSL does not support CryptoAPI
>> +#endif
>> +
> I do not like this very much.  It will, effectively, break win32 builds
> with WolfSSL - and add yet another #ifdef to our .c files.
>
> ENABLE_CRYPTOAPI is defined in syshead.h
>
> #if defined(_WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
> #define ENABLE_CRYPTOAPI
> #endif
>
> ... could you investigate whether it would be sufficient to just
> conditionalize this on WolfSSL, like this?
>
> #if defined(_WIN32) && defined(ENABLE_CRYPTO) && \
> 	defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL)
> #define ENABLE_CRYPTOAPI
> #endif
>
> so you can have WolfSSL-linked binaries for Windows, just without
> CryptoAPI support (as with mbedtls)...
>
> gert
>
Sincerely
Juliusz

