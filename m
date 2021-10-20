References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-3-arne@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <dafed1aa-b321-cfe3-d461-e3bf485e9fe1@...2507...>
Date: Wed, 20 Oct 2021 21:07:59 +0200
MIME-Version: 1.0
In-Reply-To: <20211019183127.614175-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 02/21] [OSSL 3.0] Add
 --with-openssl-engine autoconf option (auto|yes|no)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 19/10/2021 20:31, Arne Schwabe wrote:
> This allows to select engine support at configure time. For OpenSSL 1.1 the
> default is not changed and we detect if engine support is available.
> 
> Engine support is deprecated in OpenSSL 3.0 and for OpenSSL 3.0 the default
> is to disable engine support as engine support is deprecated and generates
> compiler warnings which in turn also break -Werror.
> 
> By using --with-openssl-engine=no or --with-openssl-engine=yes engine support
> can be forced on or off. If it is enabled but not detected an error will be
> thown.
> 
> This commit cleans up the configurelogic a bit and removes the ENGINE_cleanup
> checks as we can just assume that it will be also available as macro or function
> if the other engine functions are available. Before the cleanup we would only
> check for the existance of engine.h if ENGINE_cleanup was not found.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Looks good to me. My one nitpick is that the part below uses a mix of 
spaces and tabs for indentation. But the entire file doesn't seem 
terribly consistent about that.

> +    if test "${with_openssl_engine}" = "auto"; then
> +        AC_COMPILE_IFELSE(
> +        			[AC_LANG_PROGRAM(
> +        				[[
> +        #include <openssl/opensslv.h>
> +        				]],
> +        				[[
> +        /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
> +        #if OPENSSL_VERSION_NUMBER >= 0x30000000L
> +        #error Engine supported disabled by default in OpenSSL 3.0+
> +        #endif
> +        				]]
> +        			)],
> +        			[have_openssl_engine="yes"],
> +        			[have_openssl_engine="no"]
> +        )
> +        if test "${have_openssl_engine}" = "yes"; then
> +            AC_CHECK_FUNCS(
> +                [ \
> +                    ENGINE_load_builtin_engines \
> +                    ENGINE_register_all_complete \
> +                ],
> +                ,
> +                [have_openssl_engine="no"; break]
> +            )
> +        fi
> +    else
> +        have_openssl_engine="${with_openssl_engine}"
> +        if test "${have_openssl_engine}" = "yes"; then
> +            AC_CHECK_FUNCS(
> +                [ \
> +                    ENGINE_load_builtin_engines \
> +                    ENGINE_register_all_complete \
> +                ],
> +                ,
> +                [AC_MSG_ERROR([OpenSSL engine support not found])]
> +            )
> +        fi
> +    fi
>   	if test "${have_openssl_engine}" = "yes"; then
>   		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
>   	fi
> 

