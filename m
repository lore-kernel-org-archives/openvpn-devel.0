References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-6-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e65178fc-cc6e-4e99-b790-78aa3f1972ab@...2181...>
Date: Thu, 22 Apr 2021 02:36:20 +0200
MIME-Version: 1.0
In-Reply-To: <20210421134348.1950392-6-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 6/7] Replace OS_SPECIFIC_DIRSEP with
 PATH_SEPARATOR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 21/04/2021 15:43, Arne Schwabe wrote:
> We have two define that do exactly the same. Also move the check
> from configure.ac to syshead.h since it is really only checking
> for Windows.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>




> ---
>  configure.ac             | 8 --------
>  src/openvpn/platform.c   | 2 +-
>  src/openvpn/ssl_verify.c | 2 +-
>  src/openvpn/syshead.h    | 6 ++++--
>  4 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index a67bf2595..3b4d3cbc7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1133,14 +1133,6 @@ if test -n "${GIT}" -a -d "${srcdir}/.git"; then
>  fi
>  AC_MSG_RESULT([${GIT_CHECKOUT}])
>  
> -if test -n "${SP_PLATFORM_WINDOWS}"; then
> -	AC_DEFINE_UNQUOTED([PATH_SEPARATOR], ['\\\\'], [Path separator]) #"
> -	AC_DEFINE_UNQUOTED([PATH_SEPARATOR_STR], ["\\\\"], [Path separator]) #"
> -else
> -	AC_DEFINE_UNQUOTED([PATH_SEPARATOR], ['/'], [Path separator])
> -	AC_DEFINE_UNQUOTED([PATH_SEPARATOR_STR], ["/"], [Path separator])
> -fi
> -
>  dnl enable --x509-username-field feature if requested
>  if test "${enable_x509_alt_username}" = "yes"; then
>  	if test "${with_crypto_library}" = "mbedtls" ; then
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index c63c1d994..bf7b1aa0a 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -486,7 +486,7 @@ platform_gen_path(const char *directory, const char *filename,
>          struct buffer out = alloc_buf_gc(outsize, gc);
>          char dirsep[2];
>  
> -        dirsep[0] = OS_SPECIFIC_DIRSEP;
> +        dirsep[0] = PATH_SEPARATOR;
>          dirsep[1] = '\0';
>  
>          if (directory)
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 7608155cd..14aaf2bf7 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -616,7 +616,7 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert,
>          goto cleanup;
>      }
>  
> -    if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
> +    if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial))
>      {
>          msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
>          goto cleanup;
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index a964ffd35..28ccca087 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -432,9 +432,11 @@ typedef unsigned short sa_family_t;
>   * Directory separation char
>   */
>  #ifdef _WIN32
> -#define OS_SPECIFIC_DIRSEP '\\'
> +#define PATH_SEPARATOR '\\'
> +#define PATH_SEPARATOR_STR "\\"

Do we still need the define in config-msvc.h now that we have it here?

config-msvc.h:85:#define PATH_SEPARATOR     '\\'
config-msvc.h:86:#define PATH_SEPARATOR_STR "\\"


Regards,

>  #else
> -#define OS_SPECIFIC_DIRSEP '/'
> +#define PATH_SEPARATOR '/'
> +#define PATH_SEPARATOR_STR "/"
>  #endif
>  
>  /*
> 

-- 
Antonio Quartulli

