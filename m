Message-ID: <0853128b-25df-aef8-78bf-c6af7fae157f@...2525...>
Date: Wed, 31 Aug 2022 13:59:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
In-Reply-To: <48db419f-0d5d-a9b9-6f55-dffc5d4fbbe5@...1227...>
Subject: Re: [Openvpn-devel] wolfSSL unit test failures
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Everyone,

this leak has been fixed in wolfSSL in this pull request: 
https://github.com/wolfSSL/wolfssl/pull/5514

Sincerely
Juliusz

On 18/08/2022 00:40, Arne Schwabe wrote:
> Hey,
>
> currently we still have test failures in wolfSSL in
>
> EVP_PKEY_CTX_new with clang asan. Github action patch that reproduces 
> this also attached. With the OpenVPN 2.6 release coming up in the next 
> months it would be good if these can be fixed. These look like problems
> in the upstream wolfSSL code.
>
>
> Details are below:
>
> =================================================================
> ==19723==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 160 byte(s) in 4 object(s) allocated from:
>     #0 0x49604d in malloc 
> (/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
>     #1 0x7f64e8318291 in wolfSSL_EVP_PKEY_CTX_new 
> (/usr/local/lib/libwolfssl.so.34+0x9e291)
>
> Indirect leak of 400 byte(s) in 2 object(s) allocated from:
>     #0 0x49604d in malloc 
> (/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
>     #1 0x7f64e833c537 in wolfSSL_EVP_PKEY_new_ex 
> (/usr/local/lib/libwolfssl.so.34+0xc2537)
>
> Indirect leak of 240 byte(s) in 2 object(s) allocated from:
>     #0 0x49604d in malloc 
> (/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
>     #1 0x7f64e82b4ac2 in _InitRng.isra.0 
> (/usr/local/lib/libwolfssl.so.34+0x3aac2)
>
> Indirect leak of 118 byte(s) in 2 object(s) allocated from:
>     #0 0x49604d in malloc 
> (/home/runner/work/openvpn/openvpn/tests/unit_tests/openvpn/crypto_testdriver+0x49604d)
>     #1 0x7f64e833c72b in wolfSSL_EVP_PKEY_new_mac_key 
> (/usr/local/lib/libwolfssl.so.34+0xc272b)
>
> SUMMARY: AddressSanitizer: 918 byte(s) leaked in 10 allocation(s).
> FAIL: crypto_testdriver
>

