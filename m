Message-ID: <7c11f7c6-46c1-bf0c-ff88-67ad0c9e3cda@...2525...>
Date: Fri, 2 Sep 2022 11:50:32 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20200429145132.28424-1-juliusz@...2525...>
 <41fef456-3ced-7cb3-7888-46a3522080b2@...2181...>
 <196ab7ef-4a2f-dc82-45a7-59295b5c36e7@...2525...>
 <7a019859-7884-f278-2463-b07e9ee4e747@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
In-Reply-To: <7a019859-7884-f278-2463-b07e9ee4e747@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
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
To: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

I'll try to propose a solution to avoid this warning.

Juliusz

On 01/09/2022 14:39, Arne Schwabe wrote:
>>> (*)(const X509_NAME * const*, const X509_NAME * const*) {aka int
>>> (*)(const struct WOLFSSL_X509_NAME * const*, const struct
>>> WOLFSSL_X509_NAME * const*)}
>>> In file included from /usr/local/include/wolfssl/openssl/ssl.h:35,
>>>                   from ssl_openssl.h:32,
>>>                   from ssl_backend.h:36,
>>>                   from ssl_openssl.c:44:
>>> /usr/local/include/wolfssl/ssl.h:3534:47: note: expected
>>> ‘wolf_sk_compare_cb’ {aka ‘int (*)(const void * const*, const void *
>>> const*)’} but argument is of type ‘int (*)(const X509_NAME * const*,
>>> const X509_NAME * const*)’ {aka ‘int (*)(const struct WOLFSSL_X509_NAME
>>> * const*, const struct WOLFSSL_X509_NAME * const*)’}
>>>   3534 | WOLFSSL_API WOLF_STACK_OF(WOLFSSL_X509_NAME)*
>>> wolfSSL_sk_X509_NAME_new(
>>>        |
>>> ^~~~~~~~~~~~~~~~~~~~~~~~
>> To make wolfSSL_sk_X509_NAME_new more universal we accept a function 
>> with void* parameters. This will unfortunately generate a warning 
>> when compiling with wolfSSL but won't affect functionality.
>
>
> This issue is still present and still breaks compiling with -Werror . 
> Are there any plans to address this?
>
> Arne

