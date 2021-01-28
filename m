References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
 <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
 <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
 <33d99bf3-96ae-4728-87b2-cc442aa611a4@...2525...>
 <2e1ae5d6-d7bf-9784-689a-b92f51204bda@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <9ffb07ff-067d-d1d3-a39c-357abb70f21a@...2525...>
Date: Thu, 28 Jan 2021 10:59:52 +0100
MIME-Version: 1.0
In-Reply-To: <2e1ae5d6-d7bf-9784-689a-b92f51204bda@...1227...>
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

our CI tests caught that as well. I was able to fix it quickly but it 
looks like you were even quicker :D The latest version of the PR should 
be free from the implicit conversion errors.

Sincerely
Juliusz

On 27/01/2021 20:07, Arne Schwabe wrote:
> Am 27.01.21 um 18:25 schrieb Juliusz Sosinowicz:
>> Hi Arne,
>>
>> I believe I fixed the issues that you mentioned in your review of the
>> patch for wolfSSL. I have sent a new patch tested on the latest master
>> branch on OpenVPN along with the version of wolfSSL found in this pull
>> request: https://github.com/wolfSSL/wolfssl/pull/3697 .
>>
> Unfortunatel,y I am still not able to compile that branch on
> macOS/clang. It seem wolfssl uses -Werror and this breaks it. On a quick
> check I also don't see an option to disable this behaviour in configure.
>
> The master branch compiles but that doesn't work for OpenVPN.
>
> src/tls13.c:806:50: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>              protocol, protocolLen, (byte*)label, labelLen,
>                                                   ^~~~~~~~
> src/tls13.c:812:38: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>      ret = wc_Hash(hashType, context, contextLen, hashOut,
> WC_MAX_DIGEST_SIZE);
>            ~~~~~~~                    ^~~~~~~~~~
> src/tls13.c:816:34: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>      ret = HKDF_Expand_Label(out, outLen, firstExpand, hashLen,
>            ~~~~~~~~~~~~~~~~~      ^~~~~~
>    CC       examples/server/testsuite_testsuite_test-server.o
>    CC       testsuite/testsuite_test-testsuite.o
>    CC       tests/unit_test-unit.o
> 3 errors generated.
> make[2]: *** [src/libwolfssl_la-tls13.lo] Error 1
> make[2]: *** Waiting for unfinished jobs....
> src/ssl.c:11527:61: error: implicit conversion loses integer precision:
> 'unsigned long' to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>      word32 seedLen = !use_context ? SEED_LEN : SEED_LEN + 2 + contextLen;
>             ~~~~~~~                             ~~~~~~~~~~~~~^~~~~~~~~~~~
> src/ssl.c:11591:25: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>      if (wc_PRF_TLS(out, outLen, ssl->arrays->masterSecret, SECRET_LEN,
>          ~~~~~~~~~~      ^~~~~~
> src/ssl.c:11592:27: error: implicit conversion loses integer precision:
> 'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
> [-Werror,-Wshorten-64-to-32]
>              (byte*)label, labelLen, seed, seedLen, IsAtLeastTLSv1_2(ssl),
>                            ^~~~~~~~
> 3 errors generated.
> make[2]: *** [src/libwolfssl_la-ssl.lo] Error 1
> make[1]: *** [all-recursive] Error 1
> make: *** [all] Error 2
> Time: 0h:00m:27s
>
>

