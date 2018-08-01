MIME-Version: 1.0
In-Reply-To: <20170505214624.11675-1-davids@...515...>
References: <20170505214624.11675-1-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 Jul 2018 23:20:04 -0400
Message-ID: <CAKuzo_g1s9XvTrfUCPQty4Na0OuDXK6tVuOC8JpCz3QHFGQ4Kg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Now that the minor "fix" for plugin header seems settled, back to the
base64 export patch from David.

On Fri, May 5, 2017 at 5:46 PM, David Sommerseth <davids@...515...> wrote:
> This patch builds on the "Export secure_memzero() to plug-ins" patch and
> adds export of openvpn_base64_encode() and openvpn_base64_decode()
>
> This also ships with a very simple plug-in which demonstrates how to use
> the new exported functions.
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  include/openvpn-plugin.h.in           |  31 ++++++
>  sample/sample-plugins/simple/base64.c | 204 ++++++++++++++++++++++++++++++++++
>  src/openvpn/plugin.c                  |   5 +-
>  3 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100644 sample/sample-plugins/simple/base64.c

The exports are very useful an work as expected. The sample code
would be appreciated by plugin authors though it could have been
a separate patch.

I have not tested the sample code but looks right and is well documented.

Only a two of typos to nitpick over (see below) -- hopefully those
could be fixed at merge time.

So ACK from me.

>
> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
> index ec83f3a6..68180d62 100644
> --- a/include/openvpn-plugin.h.in
> +++ b/include/openvpn-plugin.h.in
> @@ -221,6 +221,8 @@ struct openvpn_plugin_string_list
>   *           OpenVPN to plug-ins.
>   *
>   *    4      Exported secure_memzero() as plugin_secure_memzero()
> + *           Exported openvpn_base64_encode() as plugin_base64_encode()
> + *           Exported openvpn_base64_decode() as plugin_base64_decode()
>   */
>  #define OPENVPN_PLUGINv3_STRUCTVER 4
>
> @@ -269,6 +271,33 @@ typedef void (*plugin_vlog_t)(openvpn_plugin_log_flags_t flags,
>   */
>  typedef void (*plugin_secure_memzero_t)(void *data, size_t len);
>
> +/**
> + *  Export of openvpn_base64_encode() to be used inside plug-ins
> + *
> + *  @param data   Pointer to data to BASE64 encode
> + *  @param size   Length of data, in bytes
> + *  @param *str   Pointer to the return buffer.  This needed memory is
> + *                allocated by openvpn_base64_encode() and needs to be free()d
> + *                after use.
> + *
> + *  @return int   Returns the length of the buffer created, or -1 on error.
> + *
> + */
> +typedef int (*plugin_base64_encode_t)(const void *data, int size, char **str);
> +
> +/**
> + *  Export of openvpn_base64_decode() to be used inside plug-ins
> + *
> + *  @param str    Pointer to the BASE64 encoded data
> + *  @param data   Pointer to the buffer where save the decoded data
> + *  @param size   Size of the destination buffer
> + *
> + *  @return int   Returns the length of the decoded data, or -1 on error or
> + *                if the destination buffer is too small.
> + *
> + */
> +typedef int (*plugin_base64_decode_t)(const char *str, void *data, int size);
> +
>
>  /**
>   * Used by the openvpn_plugin_open_v3() function to pass callback
> @@ -291,6 +320,8 @@ struct openvpn_plugin_callbacks
>      plugin_log_t plugin_log;
>      plugin_vlog_t plugin_vlog;
>      plugin_secure_memzero_t plugin_secure_memzero;
> +    plugin_base64_encode_t plugin_base64_encode;
> +    plugin_base64_decode_t plugin_base64_decode;
>  };
>
>  /**
> diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
> new file mode 100644
> index 00000000..503b5ba0
> --- /dev/null
> +++ b/sample/sample-plugins/simple/base64.c
> @@ -0,0 +1,204 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single TCP/UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2017  David Sommerseth <davids@...515...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#include "openvpn-plugin.h"
> +
> +#define PLUGIN_NAME "base64.c"
> +
> +/* Exported plug-in v3 API functions */
> +plugin_log_t ovpn_log = NULL;                      /**< Pointer to the OpenVPN log function.  See plugin_log() */
> +plugin_vlog_t ovpn_vlog = NULL;                    /**< Pointer to the OpenVPN vlog function. See plugin_vlog() */
> +plugin_base64_encode_t ovpn_base64_encode = NULL;  /**< Pointer to the openvpn_base64_encode () function */
> +plugin_base64_decode_t ovpn_base64_decode = NULL;  /**< Pointer to the openvpn_base64_decode () function */
> +
> +/**
> + * Search the environment pointer for a specific env var name
> + *
> + * PLEASE NOTE! The result is not valid outside the local
> + * scope of the calling function.  Once the calling function
> + * returns, any returned pointers are invalid.
> + *
> + * @param name  String containing the env.var name to search for
> + * @param envp  String array pointer to the environment variable
> + *
> + * @return Returns a pointer to the value in the environment variable
> + *         table on successful match.  Otherwise NULL is returned
> + *
> + */
> +static const char *
> +get_env(const char *name, const char *envp[])
> +{
> +    if (envp)
> +    {
> +        int i;
> +        const int namelen = strlen(name);
> +        for (i = 0; envp[i]; ++i)
> +        {
> +            if (!strncmp(envp[i], name, namelen))
> +            {
> +                const char *cp = envp[i] + namelen;
> +                if (*cp == '=')
> +                {
> +                    return cp + 1;
> +                }
> +            }
> +        }
> +    }
> +    return NULL;
> +}
> +
> +
> +/**
> + * This function is called when OpenVPN loads the plug-in.
> + * The purpose is to initialize the plug-in and tell OpenVPN
> + * which plug-in hooks this plug-in wants to be involved in
> + *
> + * For the arguments, see the include/openvpn-plugin.h file
> + * for details on the function parameters
> + *
> + * @param v3structver  An integer containing the API version of
> + *                     the plug-in structs OpenVPN uses
> + * @param args         A pointer to the argument struct for
> + *                     information and features provided by
> + *                     OpenVPN to the plug-in
> + * @param ret          A pointer to the struct OpenVPN uses to
> + *                     receive information back from the plug-in
> + *
> + * @return Must return OPENVPN_PLUGIN_FUNC_SUCCESS when everything
> + *         completed successfully.  Otherwise it must be returned
> + *         OPENVPN_PLUGIN_FUNC_ERROR, which will stop OpenVPN
> + *         from running
> + *
> + */
> +OPENVPN_EXPORT int
> +openvpn_plugin_open_v3(const int v3structver,
> +                       struct openvpn_plugin_args_open_in const *args,
> +                       struct openvpn_plugin_args_open_return *ret)
> +{
> +    /* Check that we are API compatible */
> +    if (v3structver != OPENVPN_PLUGINv3_STRUCTVER)
> +    {
> +        printf("base64.c: ** ERROR ** Incompatible plug-in interface between this plug-in and OpenVPN\n");
> +        return OPENVPN_PLUGIN_FUNC_ERROR;
> +    }
> +
> +    /*  Which callbacks to intercept.  */
> +    ret->type_mask =
> +        OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
> +        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2);
> +
> +    /* we don't need a plug-in context in this example, but OpenVPN expects "something" */
> +    ret->handle = calloc(1, 1);
> +
> +    /* Hook into the exported functions from OpenVPN */
> +    ovpn_log = args->callbacks->plugin_log;
> +    ovpn_vlog = args->callbacks->plugin_vlog;
> +    ovpn_base64_encode = args->callbacks->plugin_base64_encode;
> +    ovpn_base64_decode = args->callbacks->plugin_base64_decode;
> +
> +    /* Print some version information about the OpenVPN process using this plug-in */
> +    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OpenVPN %s  (Major: %i, Minor: %i, Patch: %s)\n",
> +             args->ovpn_version, args->ovpn_version_major,
> +             args->ovpn_version_minor, args->ovpn_version_patch);
> +
> +    return OPENVPN_PLUGIN_FUNC_SUCCESS;
> +}
> +
> +
> +/**
> + * This function is called by OpenVPN each time the OpenVPN reaches
> + * a point where plug-in calls should happen.  It only happens for those
> + * plug-in hooks enabled in openvpn_plugin_open_v3().
> + *
> + * For the arguments, see the include/openvpn-plugin.h file
> + * for details on the function parameters
> + *
> + * @param args        Pointer to a struct with details about the plug-in
> + *                    call from the main OpenVPN process.
> + * @param returndata  Pointer to a struct where the plug-in can provide
> + *                    information back to OpenVPN to be processed
> + *
> + * @return  Must return OPENVPN_PLUGIN_FUNC_SUCCESS or
> + *          OPENVPN_PLUGIN_FUNC_DEFERRED on success.  Otherwise it
> + *          should return OPENVPN_FUNC_ERROR, which will stop and reject
> + *          the client session from progressing.
> + *
> + */
> +
> +OPENVPN_EXPORT int
> +openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
> +{
> +    if (type != OPENVPN_PLUGIN_TLS_VERIFY
> +        && type != OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
> +    {
> +        ovpn_log(PLOG_ERR, PLUGIN_NAME, "Unsupported plug-in hook call attempted");
> +        return OPENVPN_PLUGIN_FUNC_ERROR;
> +    }
> +
> +    /* get username/password from envp string array */
> +    const char *clcert_cn = get_env("X509_0_CN", envp);
> +    if (!clcert_cn)
> +    {
> +        /* Ignore certificate checks not being a client certificate */
> +        return OPENVPN_PLUGIN_FUNC_SUCCESS;
> +    }
> +
> +    /* test the BAS64 encode function */

typo: BAS64 --> BASE64

> +    char *buf = NULL;
> +    int r = ovpn_base64_encode(clcert_cn, strlen(clcert_cn), &buf);
> +    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "BASE64 encoded '%s' (return value %i):  '%s'",
> +             clcert_cn, r, buf);
> +
> +    /* test the BAS64 encode function */

typo: BAS64 encode --> BASE64 decode

> +    char buf2[256] = {0};
> +    r = ovpn_base64_decode(buf, &buf2, 255);
> +    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "BASE64 decoded '%s' (return value %i):  '%s'",
> +             buf, r, buf2);
> +
> +    /* Verify the result, and free the buffer allocated by ovpn_base64_encode() */
> +    r = strcmp(clcert_cn, buf2);
> +    free(buf);
> +
> +    return (r == 0) ? OPENVPN_PLUGIN_FUNC_SUCCESS : OPENVPN_PLUGIN_FUNC_ERROR;
> +}
> +
> +
> +/**
> + * This cleans up the last part of the plug-in, allows it to
> + * shut down cleanly and release the plug-in global context buffer
> + *
> + * @param handle   Pointer to the plug-in global context buffer, which
> + *                 need to be released by this function
> + */
> +OPENVPN_EXPORT void
> +openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
> +{
> +    struct plugin_context *context = (struct plugin_context *) handle;
> +    free(context);
> +}
> +
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index a652d528..ca278af1 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -44,6 +44,7 @@
>  #include "misc.h"
>  #include "plugin.h"
>  #include "ssl_backend.h"
> +#include "base64.h"
>  #include "win32.h"
>  #include "memdbg.h"
>
> @@ -411,7 +412,9 @@ plugin_log(openvpn_plugin_log_flags_t flags, const char *name, const char *forma
>  static struct openvpn_plugin_callbacks callbacks = {
>      plugin_log,
>      plugin_vlog,
> -    secure_memzero   /* plugin_secure_memzero */
> +    secure_memzero,         /* plugin_secure_memzero */
> +    openvpn_base64_encode,  /* plugin_base64_encode */
> +    openvpn_base64_decode,  /* plugin_base64_decode */
>  };
>
>
> --
> 2.11.0
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

Acked by: selva.nair@...277...

