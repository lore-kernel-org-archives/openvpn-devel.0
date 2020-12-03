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
From: Arne Schwabe <arne@...1227...>
Message-ID: <0f47e3c7-f9d2-1649-0fb7-b0b58fa4b84a@...1227...>
Date: Thu, 3 Dec 2020 13:22:05 +0100
MIME-Version: 1.0
In-Reply-To: <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
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
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 19.11.20 um 13:23 schrieb Juliusz Sosinowicz:
> Hi Arne,
> 
> some time has passed and I was able to address most of your comments in
> my branch
> https://github.com/julek-wolfssl/wolfssl/tree/openvpn-2.5-missing-stuff
> 
> To summarize what has been done regarding your comments:
> 
>   * SHA1 was indeed being called SHA in wolfSSL. I changed this in favor
>     of just using SHA1.
>   * in configure.ac I used David Sommerseth's suggestion to use
>     PKG_CHECK_MODULES to get the wolfSSL installation directory.

Do you that new patch posted here? I don't see an updated patch.

>   * setting tls min and max is currently not working in the branch that
>     I linked above but we have a big compatibility layer PR pending that
>     appears to fix these issues. Once it is merged I'll revisit this
>     issue and make sure it is solved.
>   * show-tls is fixed but it also relies on the PR I mentioned earlier.
>     After that is merged this should be solved.
>   * tls-ciphersuites and tls-cipher appears to be working in general.
>     Should wolfSSL reject the specified cipher if for example a TLS 1.3
>     cipher is set using --tls-cipher?

Well that is a general question you have to answer yourself on OpenSSL
compatibility. I don't think this is just for OpenVPN.

>   * unfortunately wolfSSL does not support ed448 certificates.

That is not a show stopper. Mbed TLS does not support them either.

>   * tls-groups now checks the validity of the passed in curves
>   * since OpenVPN will make use TLS EKM, exporting keying material has
>     been implemented in wolfSSL.

Great!

>   * I haven't tested OpenVPN with the FIPS mode patch so that issue is
>     still pending. Once I get a chance to test it I will also change
>     wolfSSL to target 1.1.0+ API
> 
> Thanks for your patience!
> 

Hey I am trying to check on this. Since I haven't found the new patch. I
am trying to use it with the old one:

I am getting an error related to EKM:

./../../openvpn-git/src/openvpn/ssl_openssl.c:166:9: error: implicit
declaration of function 'wolfSSL_export_keying_material' is invalid in C99
      [-Werror,-Wimplicit-function-declaration]
    if (SSL_export_keying_material(ssl, ekm, ekm_size, label,


So I tried ./configure --enable-openvpn --enable-keying-material for
WolfSSL but that failed during compile:

src/tls13.c:806:50: error: implicit conversion loses integer precision:
'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
      [-Werror,-Wshorten-64-to-32]
            protocol, protocolLen, (byte*)label, labelLen,
                                                 ^~~~~~~~
src/tls13.c:812:38: error: implicit conversion loses integer precision:
'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
      [-Werror,-Wshorten-64-to-32]
    ret = wc_Hash(hashType, context, contextLen, hashOut,
WC_MAX_DIGEST_SIZE);
          ~~~~~~~                    ^~~~~~~~~~
src/tls13.c:816:34: error: implicit conversion loses integer precision:
'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
      [-Werror,-Wshorten-64-to-32]
    ret = HKDF_Expand_Label(out, outLen, firstExpand, hashLen,
          ~~~~~~~~~~~~~~~~~      ^~~~~~
  CC       tests/unit_test-unit.o
src/ssl.c:11526:61: error: implicit conversion loses integer precision:
'unsigned long' to 'word32' (aka 'unsigned int')
[-Werror,-Wshorten-64-to-32]
    word32 seedLen = !use_context ? SEED_LEN : SEED_LEN + 2 + contextLen;
           ~~~~~~~                             ~~~~~~~~~~~~~^~~~~~~~~~~~
src/ssl.c:11590:25: error: implicit conversion loses integer precision:
'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
      [-Werror,-Wshorten-64-to-32]
    if (wc_PRF_TLS(out, outLen, ssl->arrays->masterSecret, SECRET_LEN,
        ~~~~~~~~~~      ^~~~~~
src/ssl.c:11591:27: error: implicit conversion loses integer precision:
'size_t' (aka 'unsigned long') to 'word32' (aka 'unsigned int')
      [-Werror,-Wshorten-64-to-32]
            (byte*)label, labelLen, seed, seedLen, IsAtLeastTLSv1_2(ssl),



I am also seeing another warning during the compilation:

../../../openvpn-git/src/openvpn/ssl_openssl.c:1559:55: warning:
incompatible pointer types passing 'int (const X509_NAME *const *, const
      X509_NAME *const *)' (aka 'int (const struct WOLFSSL_X509_NAME
*const *, const struct WOLFSSL_X509_NAME *const *)') to parameter of type
      'wolf_sk_compare_cb' (aka 'int (*)(const void *const *, const void
*const *)') [-Wincompatible-pointer-types]
                        cert_names = sk_X509_NAME_new(sk_x509_name_cmp);
                                                      ^~~~~~~~~~~~~~~~


Arne

