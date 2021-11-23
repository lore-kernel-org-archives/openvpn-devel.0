MIME-Version: 1.0
References: <20211118205229.303-1-lstipakov@...277...>
 <20211118212945.478-1-lstipakov@...277...>
 <CAKuzo_hQK-Hqk_LqUegkugZAZiEBjPVqtH5qVfONhWZ-zT9FpQ@...278...>
In-Reply-To: <CAKuzo_hQK-Hqk_LqUegkugZAZiEBjPVqtH5qVfONhWZ-zT9FpQ@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 23 Nov 2021 19:56:50 +0200
Message-ID: <CAGyAFMV36+05+TLJ4v9vQwikVv_X4xqqmvMp+Ah-Kip5oM9hjA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Load OpenSSL config on Windows from
 trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

> Does this string concatenation like L"foo" "bar" work correctly on MSVC? I know it works on mingw, but in the past with the GUI resources we had run into issues with such usage -- iirc, MSVC wanted L"foo" L"bar".

I think so, at least result of concatenation looks correct in procmon:

> openvpn.exe 23312 CreateFile C:\Program Files\OpenVPN\ssl\openssl.cnf PATH NOT FOUND

> Is this registry value guaranteed to end with the directory separator "\\"? Should we check it? If so, it may be easier to strip it here and add in the format with no ending "\\" in the default above.

Those are set by our MSI script. But let's be on the safe side.

> On linux one needs strings on the heap or const strings for putenv() as it does not make a copy unlike setenv (with some exceptions).  Does _wputenv on Windows behave differently? Do local variables work?

At least they work in my tests. This
https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/putenv-wputenv?view=msvc-170
doesn't mention anything about automatic variables cannot be used,
contrary to "man putenv".

>> +    _wputenv(openssl_cnf);
>> +    _wputenv(openssl_engines);
>> +    _wputenv(openssl_modules);
>
>
> I think we should set these only if not already set. Otherwise the user has no way of overriding these locations which is the original purpose of env vars.

Will do.

> Commit message says this brings back config loading but the config loading in crypto_openssl.c stays disabled for Windows. An oversight?

Good catch. Interesting that it works for me even with that code in
crypto_openssl.c being disabled. It looks like our SSL context
initialization does the right thing:

> libcrypto-1_1-x64.dll!OPENSSL_init_crypto(unsigned __int64 opts, const ossl_init_settings_st * settings) Line 699 C
  libssl-1_1-x64.dll!OPENSSL_init_ssl(unsigned __int64 opts, const
ossl_init_settings_st * settings) Line 205 C
  libssl-1_1-x64.dll!SSL_CTX_new(const ssl_method_st * meth) Line 3023 C
  openvpn.exe!tls_ctx_client_new(tls_root_ctx * ctx) Line 134 C
  openvpn.exe!init_ssl(const options * options, tls_root_ctx *
new_ctx, bool in_chroot) Line 622 C
  openvpn.exe!do_init_crypto_tls_c1(context * c) Line 2741 C
  openvpn.exe!do_init_crypto_tls(context * c, const unsigned int
flags) Line 2821 C
  openvpn.exe!do_init_crypto(context * c, const unsigned int flags) Line 3084 C
  openvpn.exe!init_instance(context * c, const env_set * env, const
unsigned int flags) Line 4311 C
  openvpn.exe!init_instance_handle_signals(context * c, const env_set
* env, const unsigned int flags) Line 4124 C
  openvpn.exe!tunnel_point_to_point(context * c) Line 68 C

and opts got the correct bitflag:

#ifndef OPENSSL_NO_AUTOLOAD_CONFIG
    if ((opts & OPENSSL_INIT_NO_LOAD_CONFIG) == 0)
        opts |= OPENSSL_INIT_LOAD_CONFIG;
#endif

Does that code in crypto_openssl.c cover some unusual use case? Anyway
I can bring it back.

-- 
-Lev

