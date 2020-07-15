MIME-Version: 1.0
References: <20200623092848.21214-1-gert@...1296...>
 <20200715090105.22296-1-gert@...1296...>
In-Reply-To: <20200715090105.22296-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 15 Jul 2020 12:08:54 -0400
Message-ID: <CAKuzo_j6tSPDnd0oR6KCRuU4XUUH0+G_8MPfnPV4U=Ep-z_xrQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add deferred authentication support
 to plugin-auth-pam
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Thanks for v3. All good except Changes.rst has diverged, so the patch
doesn't apply as is. Can be fixed at merge time.

The code is unchanged from the last version and the added text in
README is clear and detailed. A minor grammar thingy:

"all forwarding for all other client" -- > "all forwarding for all
other clients"

Acked-by: Selva Nair <selva.nair@...277...>

On Wed, Jul 15, 2020 at 5:02 AM Gert Doering <gert@...1296...> wrote:
>
> If OpenVPN signals deferred authentication support (by setting
> the internal environment variables "auth_control_file" and
> "deferred_auth_pam"), do not wait for PAM stack to finish.  Instead,
> the privileged PAM process returns RESPONSE_DEFER via the control
> socket, which gets turned into OPENVPN_PLUGIN_FUNC_DEFERRED towards
> openvpn.
>
> The PAM process will then fork() and handle all the PAM auth in
> the new process, signalling success/failure back by means of the
> auth_control_file (forking twice, to simplify wait() handling).
>
> With the extra fork(), multiple deferred authentications can run at
> the same time - otherwise the first one would block the next auth
> call (because the child would not be ready again to read from the
> control socket).
>
> Lightly tested on Linux.
>
> Signed-off-by: Gert Doering <gert@...1296...>
>
> --
> v2:
>   - only do deferred auth if "deferred_auth_pam" is set (env)
>   - put deferred auth logic into do_deferred_pam_auth()
>   - line-wrap lines where needed
>   - close "background end" of socketpair in deferred auth process
>   - remove leftover /* plugin_log() */ lines from initial testing
>   - tested over a few hundred "15s delayed" authentication cycles
>
> v3:
>   - uncrustify new code
>   - do not abort background process if do_deferred_pam_auth() fails
>     (this can only happen if fork() fails, which is assumed to be
>     temporary, or if something is wrong with the socketpair which we
>     should notice on the next read()) --> change do_deferred_pam_auth()
>     to "void"
>   - add documentation to README.auth-pam and Changes.rst
> ---
>  Changes.rst                          |   3 +
>  src/plugins/auth-pam/README.auth-pam |  35 ++++++++
>  src/plugins/auth-pam/auth-pam.c      | 122 ++++++++++++++++++++++++++-
>  3 files changed, 157 insertions(+), 3 deletions(-)
>
> diff --git a/Changes.rst b/Changes.rst
> index 00dd6ed8..8d9d74c1 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -13,6 +13,9 @@ ChaCha20-Poly1305 cipher support
>      Added support for using the ChaCha20-Poly1305 cipher in the OpenVPN data
>      channel.
>
> +Asynchronous (deferred) authentication support for auth-pam plugin.
> +    See src/plugins/auth-pam/README.auth-pam for details.
> +
>
>  Overview of changes in 2.4
>  ==========================
> diff --git a/src/plugins/auth-pam/README.auth-pam b/src/plugins/auth-pam/README.auth-pam
> index 4d3d4ecc..e604d5a8 100644
> --- a/src/plugins/auth-pam/README.auth-pam
> +++ b/src/plugins/auth-pam/README.auth-pam
> @@ -73,6 +73,41 @@ underlying PAM module.  This is a useful debugging tool to figure
>  out which queries a given PAM module is making, so that you can
>  craft the appropriate plugin directive to answer it.
>
> +Since running OpenVPN with verb 7 is quite verbose, alternatively
> +you can put
> +
> +   verb 3
> +   setenv verb 9
> +
> +in the openvpn config which will only increase logging for this plugin.
> +
> +
> +ASYNCHRONOUS OPERATION
> +
> +Sometimes PAM modules take very long to complete (for example, a LDAP
> +or Radius query might timeout trying to connect an unreachable external
> +server).  Normal plugin auth operation will block the whole OpenVPN
> +process in this time, that is, all forwarding for all other client stops.
> +
> +The auth-pam plugin can operate asynchronously ("deferred authentication")
> +to remedy this situation.  To enable this, put
> +
> +  setenv deferred_auth_pam 1
> +
> +in your openvpn server config.  If set, this will make the "PAM background
> +process" fork() and do its job detached from OpenVPN.  When finished, a
> +status file is written, which OpenVPN will then pick up and read the
> +success/failure result from it.
> +
> +While the plugin is working in the background, OpenVPN will continue to
> +service other clients normally.
> +
> +Asynchronous operation is recommended for all PAM queries that could
> +"take time" (LDAP, Radius, NIS, ...).  If only local files are queried
> +(passwd, pam_userdb, ...), synchronous operation has slightly lower
> +overhead, so this is still the default mode of operation.
> +
> +
>  CAVEATS
>
>  This module will only work on *nix systems which support PAM,
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 9a11876d..f537652e 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -62,6 +62,7 @@
>  #define RESPONSE_INIT_FAILED      11
>  #define RESPONSE_VERIFY_SUCCEEDED 12
>  #define RESPONSE_VERIFY_FAILED    13
> +#define RESPONSE_DEFER            14
>
>  /* Pointers to functions exported from openvpn */
>  static plugin_log_t plugin_log = NULL;
> @@ -69,7 +70,7 @@ static plugin_secure_memzero_t plugin_secure_memzero = NULL;
>  static plugin_base64_decode_t plugin_base64_decode = NULL;
>
>  /* module name for plugin_log() */
> -static char * MODULE = "AUTH-PAM";
> +static char *MODULE = "AUTH-PAM";
>
>  /*
>   * Plugin state, used by foreground
> @@ -524,12 +525,31 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
>          const char *password = get_env("password", envp);
>          const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
>
> +        /* should we do deferred auth?
> +         *  yes, if there is "auth_control_file" and "deferred_auth_pam" env
> +         */
> +        const char *auth_control_file = get_env("auth_control_file", envp);
> +        const char *deferred_auth_pam = get_env("deferred_auth_pam", envp);
> +        if (auth_control_file != NULL && deferred_auth_pam != NULL)
> +        {
> +            if (DEBUG(context->verb))
> +            {
> +                plugin_log(PLOG_NOTE, MODULE, "do deferred auth '%s'",
> +                           auth_control_file);
> +            }
> +        }
> +        else
> +        {
> +            auth_control_file = "";
> +        }
> +
>          if (username && strlen(username) > 0 && password)
>          {
>              if (send_control(context->foreground_fd, COMMAND_VERIFY) == -1
>                  || send_string(context->foreground_fd, username) == -1
>                  || send_string(context->foreground_fd, password) == -1
> -                || send_string(context->foreground_fd, common_name) == -1)
> +                || send_string(context->foreground_fd, common_name) == -1
> +                || send_string(context->foreground_fd, auth_control_file) == -1)
>              {
>                  plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error sending auth info to background process");
>              }
> @@ -540,6 +560,14 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
>                  {
>                      return OPENVPN_PLUGIN_FUNC_SUCCESS;
>                  }
> +                if (status == RESPONSE_DEFER)
> +                {
> +                    if (DEBUG(context->verb))
> +                    {
> +                        plugin_log(PLOG_NOTE, MODULE, "deferred authentication");
> +                    }
> +                    return OPENVPN_PLUGIN_FUNC_DEFERRED;
> +                }
>                  if (status == -1)
>                  {
>                      plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error receiving auth confirmation from background process");
> @@ -782,6 +810,80 @@ pam_auth(const char *service, const struct user_pass *up)
>      return ret;
>  }
>
> +/*
> + * deferred auth handler
> + *   - fork() (twice, to avoid the need for async wait / SIGCHLD handling)
> + *   - query PAM stack via pam_auth()
> + *   - send response back to OpenVPN via "ac_file_name"
> + *
> + * parent process returns "0" for "fork() and wait() succeeded",
> + *                        "-1" for "something went wrong, abort program"
> + */
> +
> +static void
> +do_deferred_pam_auth(int fd, const char *ac_file_name,
> +                     const char *service, const struct user_pass *up)
> +{
> +    if (send_control(fd, RESPONSE_DEFER) == -1)
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [4]");
> +        return;
> +    }
> +
> +    /* double forking so we do not need to wait() for async auth kids */
> +    pid_t p1 = fork();
> +
> +    if (p1 < 0)
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(1) failed");
> +        return;
> +    }
> +    if (p1 != 0)                           /* parent */
> +    {
> +        waitpid(p1, NULL, 0);
> +        return;                            /* parent's job succeeded */
> +    }
> +
> +    /* child */
> +    close(fd);                              /* socketpair no longer needed */
> +
> +    pid_t p2 = fork();
> +    if (p2 < 0)
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
> +        exit(1);
> +    }
> +
> +    if (p2 != 0)                            /* new parent: exit right away */
> +    {
> +        exit(0);
> +    }
> +
> +    /* grandchild */
> +    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: deferred auth for '%s', pid=%d",
> +               up->username, (int) getpid() );
> +
> +    /* the rest is very simple: do PAM, write status byte to file, done */
> +    int ac_fd = open( ac_file_name, O_WRONLY );
> +    if (ac_fd < 0)
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot open '%s' for writing",
> +                   ac_file_name );
> +        exit(1);
> +    }
> +    int pam_success = pam_auth(service, up);
> +
> +    if (write( ac_fd, pam_success ? "1" : "0", 1 ) != 1)
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot write to '%s'",
> +                   ac_file_name );
> +    }
> +    close(ac_fd);
> +    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: %s: deferred auth: PAM %s",
> +               up->username, pam_success ? "succeeded" : "rejected" );
> +    exit(0);
> +}
> +
>  /*
>   * Background process -- runs with privilege.
>   */
> @@ -789,6 +891,7 @@ static void
>  pam_server(int fd, const char *service, int verb, const struct name_value_list *name_value_list)
>  {
>      struct user_pass up;
> +    char ac_file_name[PATH_MAX];
>      int command;
>  #ifdef USE_PAM_DLOPEN
>      static const char pam_so[] = "libpam.so";
> @@ -847,7 +950,8 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>              case COMMAND_VERIFY:
>                  if (recv_string(fd, up.username, sizeof(up.username)) == -1
>                      || recv_string(fd, up.password, sizeof(up.password)) == -1
> -                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1)
> +                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1
> +                    || recv_string(fd, ac_file_name, sizeof(ac_file_name)) == -1)
>                  {
>                      plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
>                              command);
> @@ -867,6 +971,18 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>                  /* If password is of the form SCRV1:base64:base64 split it up */
>                  split_scrv1_password(&up);
>
> +                /* client wants deferred auth
> +                 */
> +                if (strlen(ac_file_name) > 0)
> +                {
> +                    do_deferred_pam_auth(fd, ac_file_name, service, &up);
> +                    break;
> +                }
> +
> +
> +                /* non-deferred auth: wait for pam result and send
> +                 * result back via control socketpair
> +                 */
>                  if (pam_auth(service, &up)) /* Succeeded */
>                  {
>                      if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
> --
> 2.26.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

