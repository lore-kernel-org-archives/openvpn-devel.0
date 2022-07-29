Date: Fri, 29 Jul 2022 12:33:51 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YuO3j/n9Ojd+9ZA6@...2678...>
References: <20220726115100.31449-1-selva.nair@...277...>
 <20220727221830.31861-1-selva.nair@...277...>
MIME-Version: 1.0
In-Reply-To: <20220727221830.31861-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] xkey_provider: fix building with
 --disable-management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, Jul 27, 2022 at 06:18:30PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> v2: also fix building test_provider
>  - ifdefs in test_provider.c
>  - include integer.h for min_int as manage.h
>    may not always pull it in

FTR, buildbot is happy now with these changes.
uncrustify is not, see below, but that can probably
be fixed on apply.

Acked-By: Frank Lichtenheld <frank@...2641...>

> diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
> index 47e7e395..d146af62 100644
> --- a/tests/unit_tests/openvpn/test_provider.c
> +++ b/tests/unit_tests/openvpn/test_provider.c
> @@ -30,6 +30,7 @@
>  
>  #include "syshead.h"
>  #include "manage.h"
> +#include "integer.h"
>  #include "xkey_common.h"
>  
>  #ifdef HAVE_XKEY_PROVIDER
> @@ -127,7 +128,9 @@ init_test()
>      /* set default propq matching what we use in ssl_openssl.c */
>      EVP_set_default_properties(NULL, "?provider!=ovpn.xkey");
>  
> +#ifdef ENABLE_MANAGEMENT
>      management = test_calloc(sizeof(*management), 1);
> +#endif
>  }
>  
>  static void
> @@ -272,6 +275,7 @@ done:
>      return sig;
>  }
>  
> +#ifdef ENABLE_MANAGEMENT
>  /* Check loading of management external key and have sign callback exercised
>   * for RSA and EC keys with and without digest support in management client.
>   * Sha256 digest used for both cases with pss padding for RSA.
> @@ -310,6 +314,7 @@ again:
>          EVP_PKEY_free(privkey);
>      }
>  }
> +#endif

uncrustify wants this
--- "b/tests/unit_tests/openvpn/test_provider.c"        2022-07-29 11:34:20.067492200 +0200
+++ "a/tests/unit_tests/openvpn/test_provider.c"        2022-07-29 11:34:20.054239000 +0200
@@ -314,7 +314,7 @@
         EVP_PKEY_free(privkey);
     }
 }
-#endif
+#endif /* ifdef ENABLE_MANAGEMENT */

 /* helpers for testing generic key load and sign */
 static int xkey_free_called;

>  /* helpers for testing generic key load and sign */
>  static int xkey_free_called;
> @@ -409,7 +414,9 @@ main(void)
>  
>      const struct CMUnitTest tests[] = {
>          cmocka_unit_test(xkey_provider_test_fetch),
> +#ifdef ENABLE_MANAGEMENT
>          cmocka_unit_test(xkey_provider_test_mgmt_sign_cb),
> +#endif
>          cmocka_unit_test(xkey_provider_test_generic_sign_cb),
>      };



-- 
  Frank Lichtenheld

