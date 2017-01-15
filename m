References: <20170114163058.20106-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d476bda5-1403-ad9d-1eb6-a1ecd5761f3c@...1856...>
Date: Sun, 15 Jan 2017 10:36:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170114163058.20106-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

Thanks, I like each version better.  Even though it adds more lines than
it removes, quite some of it is because of correcting wrapping and
adding useful comments.  I think it really improves the readability of
the code.  Some (hopefully final) minor comments still though:

On 14-01-17 17:30, Antonio Quartulli wrote:
> Carrying around the INLINE_TAG is not really efficient,
> because it requires a strcmp() to be performed every
> time we want to understand if the data is stored inline
> or not.
> 
> Convert all the *_inline attributes to bool to make the
> logic easier and checks more efficient.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Based on master + [PATCH (master)] reformatting: fix style in crypto*.{c, h}
> 
> Changes from v2:
> - fix indentation in ssl_openssl.c
> - do not attempt to push inline'd options
> - do not attempt to parse inline'd plugin
> - introduce check_file_access_inline() and check_file_access_chroot_inline()
> - introduce OPT_P_INLINE to specify when an option is allowed to
>   be inline. Options not having this permission will fail to be
>   parsed if is_inline is true.
> 
> 
> Changes from v1:
> - remove the INLINE_TAG from the options parsing logic at all. Now a
>   boolean variable is passed around.
> - add print_if_inline() helper function (to misc.c/h) to make sure we
>   never print the inline data, but only the INLINE tag. Such function
>   checks also for NULL pointers;
> - make sure print_if_inline() is always used when printing possibly
>   inline data;
> - remove the INLINE_TAG from the options parsing logic at all. Now a
>   boolean variable is passed around.
> - fix alignment error in comment;
> - remove CHKACC_INLINE from check_file_access() logic: this function
>   is now not invoked at all in case of inline data.
> 
> 
>  src/openvpn/crypto.c      |  25 +++--
>  src/openvpn/crypto.h      |   5 +-
>  src/openvpn/misc.c        |  17 ++-
>  src/openvpn/misc.h        |  15 ++-
>  src/openvpn/options.c     | 281 ++++++++++++++++++++++++++--------------------
>  src/openvpn/options.h     |  21 ++--
>  src/openvpn/plugin.c      |   6 +-
>  src/openvpn/plugin.h      |   3 +-
>  src/openvpn/push.c        |   2 +-
>  src/openvpn/push.h        |   3 +-
>  src/openvpn/ssl.c         |   6 +-
>  src/openvpn/ssl_backend.h |  64 ++++++-----
>  src/openvpn/ssl_common.h  |   2 +-
>  src/openvpn/ssl_mbedtls.c |  63 +++++------
>  src/openvpn/ssl_openssl.c |  91 ++++++++-------
>  src/openvpn/tls_crypt.c   |   2 +-
>  src/openvpn/tls_crypt.h   |   9 +-
>  17 files changed, 343 insertions(+), 272 deletions(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 944f4c5..9a7745f 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -36,6 +36,7 @@
>  #include "crypto.h"
>  #include "error.h"
>  #include "integer.h"
> +#include "misc.h"

Adding a dependency to misc.o breaks the unit tests.  Just try to run
'make check' now (after initializing the cmocka submodule).

I see that this added dependency is because you added
'print_if_inline()' in misc.c.  It seems to be used only to print key
filenames though.  What about renaming it to print_key_filename() and
moving it to crypto.c?

> +/*
> + * A wrapper for check_file_access_chroot() that returns false immediately if
> + * the file is inline (and therefore there is no access to check)
> + */
> +static bool
> +check_file_access_chroot_inline(bool is_inline, const char *chroot,
> +                                const int type, const char *file,
> +                                const int mode, const char *opt)
> +{
> +    if (is_inline)
> +    {
> +        return false;
> +    }
> +
> +    return check_file_access_chroot(chroot, type, file, mode, opt);
> +}
> +
> +/*
> + * A wrapper for check_file_access() that returns false immediately if the file
> + * is inline (and therefore there is no access to check)
> + */
> +static bool
> +check_file_access_inline(bool is_inline, const int type, const char *file,
> +                         const int mode, const char *opt)
> +{
> +    if (is_inline)
> +    {
> +        return false;
> +    }
> +
> +    return check_file_access(type, file, mode, opt);
> +}

If you start these with /**, rather than /*, they will end up nicely in
the doxygen.

>  static bool
> -check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
> +check_inline_file(struct in_src *is, char *p[], bool *is_inline,
> +                  struct gc_arena *gc)
>  {
>      bool ret = false;
> +
> +    *is_inline = false;
>      if (p[0] && !p[1])
>      {
>          char *arg = p[0];
>          if (arg[0] == '<' && arg[strlen(arg)-1] == '>')
>          {
>              struct buffer close_tag;
> +            *is_inline = true;
>              arg[strlen(arg)-1] = '\0';
>              p[0] = string_alloc(arg+1, gc);
> -            p[1] = string_alloc(INLINE_FILE_TAG, gc);
>              close_tag = alloc_buf(strlen(p[0]) + 4);
>              buf_printf(&close_tag, "</%s>", p[0]);
> -            p[2] = read_inline_file(is, BSTR(&close_tag), gc);
> -            p[3] = NULL;
> +            p[1] = read_inline_file(is, BSTR(&close_tag), gc);
> +            p[2] = NULL;
>              free_buf(&close_tag);
>              ret = true;
>          }

This function now returns the same value as is set to *is_line.  I think
we should just use the return value.  (For some reason the return value
wasn't used anywhere previously, but let's just do so now.)

>  static void
>  add_option(struct options *options,
>             char *p[],
> +           bool is_inline,
>             const char *file,
>             int line,
>             const int level,
> @@ -4506,6 +4561,7 @@ read_config_file(struct options *options,
>                   struct env_set *es)
>  {
>      const int max_recursive_levels = 10;
> +    bool is_inline;

is_inline is only used below, in the if(parse_line()) scope.  I think it
should be declared in that scope.

>      FILE *fp;
>      int line_num;
>      char line[OPTION_LINE_SIZE+1];
> @@ -4544,8 +4600,10 @@ read_config_file(struct options *options,
>                  if (parse_line(line + offset, p, SIZE(p), file, line_num, msglevel, &options->gc))
>                  {
>                      bypass_doubledash(&p[0]);
> -                    check_inline_file_via_fp(fp, p, &options->gc);
> -                    add_option(options, p, file, line_num, level, msglevel, permission_mask, option_types_found, es);
> +                    check_inline_file_via_fp(fp, p, &is_inline, &options->gc);
> +                    add_option(options, p, is_inline, file, line_num, level,
> +                               msglevel, permission_mask, option_types_found,
> +                               es);
>                  }
>              }
>              if (fp != stdin)
> @@ -4578,6 +4636,7 @@ read_config_string(const char *prefix,
>      char line[OPTION_LINE_SIZE];
>      struct buffer multiline;
>      int line_num = 0;
> +    bool is_inline;
>      buf_set_read(&multiline, (uint8_t *)config, strlen(config));
>  
> @@ -4589,8 +4648,9 @@ read_config_string(const char *prefix,
>          if (parse_line(line, p, SIZE(p), prefix, line_num, msglevel, &options->gc))
>          {
>              bypass_doubledash(&p[0]);
> -            check_inline_file_via_buf(&multiline, p, &options->gc);
> -            add_option(options, p, prefix, line_num, 0, msglevel, permission_mask, option_types_found, es);
> +            check_inline_file_via_buf(&multiline, p, &is_inline, &options->gc);
> +            add_option(options, p, is_inline, prefix, line_num, 0, msglevel,
> +                       permission_mask, option_types_found, es);
>          }
>          CLEAR(p);
>      }

Same as above, move is_inline to the scope where it's used.

> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -160,13 +160,13 @@ plugin_option_list_new(struct gc_arena *gc)
>      return ret;
>  }
>  
> -bool
> -plugin_option_list_add(struct plugin_option_list *list, char **p, struct gc_arena *gc)
> +bool plugin_option_list_add(struct plugin_option_list *list, char **p,
> +                            struct gc_arena *gc)

The return type should stay on it's own line.

-Steffan

