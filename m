References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
Date: Fri, 23 Aug 2019 11:22:33 -0700
MIME-Version: 1.0
In-Reply-To: <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>

Hi,

thank you for the feedback. To answer your questions:


- Why WolfSSL in OpenVPN instead of mbed or OpenSSL
wolfSSL can be compiled to use very few resources in a wide array of 
embedded environments.
wolfSSL is FIPS ready - that is it has all the code available to be FIPS 
140 validated on a platform.
- What features does WolfSSL offer in OpenVPN that mbed/OpenSSL don't have
wolfSSL has a large customer base and some of them would like to use 
OpenVPN with wolfSSL.
- What is missing with WolfSSL?
wolfSSL doesn’t support some older, weaker algorithms like Blowfish.
wolfSSL also lacks support for CryptoAPI and exporting of keying material.
- What are your future plans in terms of involvement in OpenVPN
development and maintaince?
Our plans are to help support and maintain the wolfSSL component of any 
project, including OpenVPN, that decides to incorporate our technology.

Regarding our OpenSSL compatibility layer: we do have a compatibility 
layer for OpenSSL but it still lacks many features. In addition, using 
wolfSSL directly without an additional layer allows for better 
efficiency and performance.

Sincerely
Juliusz

On 8/16/19 8:30 AM, Arne Schwabe wrote:
> Am 16.08.19 um 16:14 schrieb Juliusz Sosinowicz:
>> This patch adds the option to use wolfSSL as the ssl backend. To build
>> this patch:
>>
> That is great and it is also a very big patch. I skimmed only through
> the patch.
>
>
> +#ifdef ENABLE_CRYPTO_WOLFSSL
> +    o->ciphername = "AES-256-CBC";
> +#else
>       o->ciphername = "BF-CBC";
> +#endif
>
> Such silent changes that OpenVPN behaves different, is something we
> would like to avoid. Better to error out in this case than to behave
> diffently.
>
> Overall the WolfSSL feels to be a bit similar to OpenSSL. Is there any
> compatibility you are aiming at?
>
> Also it would be nice to have a summary for people on the OpenVPN
> perspective
>
> - Why WolfSSL in OpenVPN instead of mbed or OpenSSL
> - What features does WolfSSL offer in OpenVPN that mbed/OpenSSL don't have
> - What is missing with WolfSSL?
>
> That should also good to have in the patch like README.mbedtls.
>
> And one of the important question is:
>
> What are your future plans in terms of involvement in OpenVPN
> development and maintaince? I think since you are first time contributer
> and this a big patch, that is something resonable to ask.
>
> Arne

