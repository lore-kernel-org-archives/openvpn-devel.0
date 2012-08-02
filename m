MIME-Version: 1.0
In-Reply-To: <1343912603-27525-1-git-send-email-heiko.hund@...1489...>
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
	<1343912603-27525-1-git-send-email-heiko.hund@...1489...>
Date: Thu, 2 Aug 2012 16:09:44 +0300
Message-ID: <CAOazyz0AZEsq2t-tL94d0e+xY=Cm_jso8KTgshn8fCqvv7v=+A@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2 v3] add API for plug-ins to write to
 openvpn log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

What about the printf style pragma?
It is very convenience to find format issue at compile times.

On Thu, Aug 2, 2012 at 4:03 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Some plugins want to add messages to the openvpn log file. The
> plugin_log() and plugin_vlog() APIs provide ways for them to do so.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>
> Changes since PATCH 2/2 v2.2:
>
>   * add plugin_vlog() API which takes a va_list
>   * pass struct openvpn_plugin_callbacks to open_v3 plug-ins
>
>  include/openvpn-plugin.h |   46 +++++++++++++++++++++++++++++++++-
>  src/openvpn/plugin.c     |   62 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 106 insertions(+), 2 deletions(-)
>
> diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
> index 1c80eec..8fd9d5e 100644
> --- a/include/openvpn-plugin.h
> +++ b/include/openvpn-plugin.h
> @@ -43,6 +43,8 @@ typedef X509 openvpn_x509_cert_t;
>  #endif
>  #endif
>
> +#include <stdarg.h>
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -145,7 +147,7 @@ typedef void *openvpn_plugin_handle_t;
>  /*
>   * For Windows (needs to be modified for MSVC)
>   */
> -#if defined(__MINGW32_VERSION) && !defined(OPENVPN_PLUGIN_H)
> +#if defined(WIN32) && !defined(OPENVPN_PLUGIN_H)
>  # define OPENVPN_EXPORT __declspec(dllexport)
>  #else
>  # define OPENVPN_EXPORT
> @@ -205,6 +207,44 @@ struct openvpn_plugin_string_list
>  #define OPENVPN_PLUGINv3_STRUCTVER 1
>
>  /**
> + * Definitions needed for the plug-in callback functions.
> + */
> +typedef enum
> +{
> +  PLOG_ERR    = (1 << 0),  /* Error condition message */
> +  PLOG_WARN   = (1 << 1),  /* General warning message */
> +  PLOG_NOTE   = (1 << 2),  /* Informational message */
> +  PLOG_DEBUG  = (1 << 3),  /* Debug message, displayed if verb >= 7 */
> +
> +  PLOG_ERRNO  = (1 << 8),  /* Add error description to message */
> +  PLOG_NOMUTE = (1 << 9),  /* Mute setting does not apply for message */
> +
> +} openvpn_plugin_log_flags_t;
> +
> +typedef void (*plugin_log_t) (openvpn_plugin_log_flags_t flags,
> +                              const char *plugin_name,
> +                              const char *format, ...);
> +typedef void (*plugin_vlog_t) (openvpn_plugin_log_flags_t flags,
> +                               const char *plugin_name,
> +                               const char *format, va_list arglist);
> +
> +/**
> + * Used by the openvpn_plugin_open_v3() function to pass callback
> + * function pointers to the plug-in.
> + *
> + * plugin_log
> + * plugin_vlog : Use these functions to add information to the OpenVPN log file.
> + *               Messages will only be displayed if the plugin_name parameter
> + *               is set. PLOG_DEBUG messages will only be displayed with plug-in
> + *               debug log verbosity (at the time of writing that's verb >= 7).
> + */
> +struct openvpn_plugin_callbacks
> +{
> +  plugin_log_t    plugin_log;
> +  plugin_vlog_t   plugin_vlog;
> +};
> +
> +/**
>   * Arguments used to transport variables to the plug-in.
>   * The struct openvpn_plugin_args_open_in is only used
>   * by the openvpn_plugin_open_v3() function.
> @@ -221,12 +261,16 @@ struct openvpn_plugin_string_list
>   *        variables in "name=value" format.  Note that for security reasons,
>   *        these variables are not actually written to the "official"
>   *        environmental variable store of the process.
> + *
> + * callbacks : a pointer to the plug-in callback function struct.
> + *
>   */
>  struct openvpn_plugin_args_open_in
>  {
>    const int type_mask;
>    const char ** const argv;
>    const char ** const envp;
> +  struct openvpn_plugin_callbacks *callbacks;
>  };
>
>
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 7ce2f5e..d785dae 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -287,6 +287,65 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
>  }
>
>  static void
> +plugin_vlog (openvpn_plugin_log_flags_t flags, const char *name, const char *format, va_list arglist)
> +{
> +  unsigned int msg_flags;
> +
> +  if (!format)
> +    return;
> +
> +  if (!name || name[0] == '\0')
> +    {
> +      msg (D_PLUGIN_DEBUG, "PLUGIN: suppressed log message from plugin with unknown name");
> +      return;
> +    }
> +
> +  if (flags & PLOG_ERR)
> +    msg_flags = M_INFO | M_NONFATAL;
> +  else if (flags & PLOG_WARN)
> +    msg_flags = M_INFO | M_WARN;
> +  else if (flags & PLOG_NOTE)
> +    msg_flags = M_INFO;
> +  else if (flags & PLOG_DEBUG)
> +    msg_flags = D_PLUGIN_DEBUG;
> +
> +  if (flags & PLOG_ERRNO)
> +    msg_flags |= M_ERRNO;
> +  if (flags & PLOG_NOMUTE)
> +    msg_flags |= M_NOMUTE;
> +
> +  if (MSG_TEST (msg_flags))
> +    {
> +      struct gc_arena gc;
> +      char* msg_fmt;
> +
> +      /* Never add instance prefix; not thread safe */
> +      msg_flags |= M_NOIPREFIX;
> +
> +      gc_init (&gc);
> +      msg_fmt = gc_malloc (ERR_BUF_SIZE, false, &gc);
> +      openvpn_snprintf (msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
> +      x_msg_va (msg_flags, msg_fmt, arglist);
> +
> +      gc_free (&gc);
> +    }
> +}
> +
> +static void
> +plugin_log (openvpn_plugin_log_flags_t flags, const char *name, const char *format, ...)
> +{
> +  va_list arglist;
> +  va_start (arglist, format);
> +  plugin_vlog (flags, name, format, arglist);
> +  va_end (arglist);
> +}
> +
> +static struct openvpn_plugin_callbacks callbacks = {
> +  plugin_log,
> +  plugin_vlog
> +};
> +
> +static void
>  plugin_open_item (struct plugin *p,
>                   const struct plugin_option *o,
>                   struct openvpn_plugin_string_list **retlist,
> @@ -312,7 +371,8 @@ plugin_open_item (struct plugin *p,
>        if (p->open3) {
>          struct openvpn_plugin_args_open_in args = { p->plugin_type_mask,
>                                                      (const char ** const) o->argv,
> -                                                    (const char ** const) envp };
> +                                                    (const char ** const) envp,
> +                                                    &callbacks };
>          struct openvpn_plugin_args_open_return retargs;
>
>          CLEAR(retargs);
> --
> 1.7.10.4
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

