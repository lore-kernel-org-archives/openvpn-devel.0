References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-14-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <82c2d70f-e2f9-f810-2c55-788358a0cb08@...277...>
Date: Mon, 13 Jul 2020 14:45:52 +0100
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-14-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5 14/14] client-connect: Add
 documentation for the deferred client connect feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Because this is documentation I have been a little harder on grammar.

These are only suggestions to improve readability.

On 11/07/2020 10:36, Arne Schwabe wrote:
> Patch V5: Fix typos, clarify man page section about deferred client-connect
>            script. Add section to Changes.rst
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                 |  4 +++
>   doc/openvpn.8               | 55 +++++++++++++++++++++++++++++++++++--
>   include/openvpn-plugin.h.in | 21 ++++++++++----
>   3 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index 42f0d190..47fa6883 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -3,6 +3,10 @@ Overview of changes in 2.5
>   
>   New features
>   ------------
> +Deferred client-connect
> +    client-connect and the connect plugin API allow now asynchronous/deferred

allow now -> now allow


> +    return of the configuration file in the same way as the auth-plugin.
> +
>   Client-specific tls-crypt keys (``--tls-crypt-v2``)
>       ``tls-crypt-v2`` adds the ability to supply each client with a unique
>       tls-crypt key.  This allows large organisations and VPN providers to profit
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 03ae5ac5..7a0080bf 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -3422,6 +3422,13 @@ is significant.  If
>   .B script
>   returns a non\-zero error status, it will cause the client
>   to be disconnected.
> +
> +If a
> +.B \-\-client\-connect cmd
> +wants to defer the generating of the configuration the script, should

wants to defer the generating of the configuration then the script should


> +use the client_connect_deferred_file and client_connect_config_file
> +environment variables and write status accordingly into these files

environment variables. And write status accordingly into these files

> +(See the environment section below for more details).
>   .\"*********************************************************
>   .TP
>   .B \-\-client\-disconnect cmd
> @@ -3505,12 +3512,18 @@ This directory will be used by in the following cases:
>   
>   *
>   .B \-\-client\-connect
> -scripts to dynamically generate client\-specific
> -configuration files.
> +scripts and
> +.B OPENVPN_PLUGIN_CLIENT_CONNECT
> +plugin hook
> +to dynamically generate client\-specific configuration files
> +and return success/failure via client_connect_deferred_file
> +when using deferred client connect method
>   
>   *
>   .B OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
> -plugin hook to return success/failure via auth_control_file
> +and
> +
> +plugin hook to return success/failure via auth_control_file/
>   when using deferred auth method
>   
>   *
> @@ -6654,6 +6667,42 @@ Set prior to execution of the
>   script.
>   .\"*********************************************************
>   .TP
> +.B client_connect_config_file
> +The path to the configuration file that should be written by
> +the
> +.B \-\-client\-connect
> +script. The content of this environment variable is identical
> +to the file as a argument of the called

as an argument

> +.B \-\-client\-connect
> +script.
> +.\"*********************************************************
> +.TP
> +.B client_connect_deferred_file
> +This file can be optionally written to communicate a status
> +code of the
> +.TP
> +.B \-\-client\-connect
> +script. If used for deferring, this file must be written
> +before the
> +.B \-\-client\-connect
> +script exits. The first character in the file has to be

must be either:


> +'1' is to indicate normal script execution, '0' indicates an
> +error (in the same way that a non zero exit status does) and
> +'2' indicates that the script deferred returning the config
> +file. When the script defers returning the configuration, it
> +must also write '2' to to the file to indicate the deferral.
> +A background process or similar must then take care of writing the
> +configuration to the file indicated by the
> +.B
> +client_connect_config_file
> +environment variable and when finished, write the a '1' to this
> +file (or '0' in case of an error).
> +
> +The absence of any character in the file when the script finishes
> +executing is interpreted the same as '1'. This allows script that

This allows scripts

> +are not written to support the defer mechanism to be used unmodified.
> +.\"*********************************************************
> +.TP
>   .B common_name
>   The X509 common name of an authenticated client.
>   Set prior to execution of
> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
> index 38fbe097..64b20886 100644
> --- a/include/openvpn-plugin.h.in
> +++ b/include/openvpn-plugin.h.in
> @@ -557,12 +557,21 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
>    * OPENVPN_PLUGIN_FUNC_SUCCESS on success, OPENVPN_PLUGIN_FUNC_ERROR on failure
>    *
>    * In addition, OPENVPN_PLUGIN_FUNC_DEFERRED may be returned by
> - * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY.  This enables asynchronous
> - * authentication where the plugin (or one of its agents) may indicate
> - * authentication success/failure some number of seconds after the return
> - * of the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY handler by writing a single
> - * char to the file named by auth_control_file in the environmental variable
> - * list (envp).
> + * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, OPENVPN_PLUGIN_CLIENT_CONNECT and
> + * OPENVPN_PLUGIN_CLIENT_CONNECT_V2. This enables asynchronous
> + * authentication or client connect  where the plugin (or one of its agents)
> + * may indicate authentication success/failure or client configuration some
> + * number of seconds after the return of the function handler.
> + * For OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY and OPENVPN_PLUGIN_CLIENT_CONNECT
> + * this is done by writing a single char to the file named by
> + * auth_control_file/client_connect_deferred_file
> + * in the environmental variable list (envp).
> + *
> + * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and
> + * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to
> + * get the deferred result. For a V2 call implementing this function is

For a V2 call implementing this function it is

> + * required as information is not passed by files. For the normal version

required because information

> + * the call is optional.
>    *
>    * first char of auth_control_file:
>    * '0' -- indicates auth failure
> 

