MIME-Version: 1.0
References: <20200620162206.13956-1-gert@...1296...>
 <20200623092848.21214-1-gert@...1296...>
In-Reply-To: <20200623092848.21214-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 14 Jul 2020 13:47:06 -0400
Message-ID: <CAKuzo_iX0_=o1Z+dpPUwoyQZuYyuG0RNSaAzmwBN_UGeTHedcg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add deferred authentication support
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

Sorry for the long delay in getting back to this.. A few minor
nitpicks on style follows:

On Tue, Jun 23, 2020 at 5:29 AM Gert Doering <gert@...1296...> wrote:
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
> ---
>  src/plugins/auth-pam/auth-pam.c | 124 +++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 2 deletions(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 9a11876d..2a75e5f0 100644
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
> @@ -524,12 +525,31 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
>          const char *password = get_env("password", envp);
>          const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
>
> +        /* should we do deferred auth?
> +         *  yes, if there is "auth_control_file" and "deferred_auth_pam" env
> +         */
> +        const char *auth_control_file = get_env("auth_control_file", envp);
> +        const char *deferred_auth_pam = get_env("deferred_auth_pam", envp);
> +        if ( auth_control_file != NULL && deferred_auth_pam != NULL)

We don't add spaces around parentheses, do we? A few such cases below..

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
> +static int
> +do_deferred_pam_auth(int fd, const char *ac_file_name,
> +                     const char *service, const struct user_pass *up)
> +{
> +    if (send_control(fd, RESPONSE_DEFER) == -1)
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [4]");
> +        return -1;
> +    }
> +
> +    /* double forking so we do not need to wait() for async auth kids */
> +    pid_t p1 = fork();
> +
> +    if ( p1 < 0 )
> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(1) failed");
> +        return -1;
> +    }
> +    if ( p1 != 0 )                         /* parent */

Same here..

> +    {
> +        waitpid(p1, NULL, 0);
> +        return 0;                          /* parent's job succeeded */
> +    }
> +
> +    /* child */
> +    close(fd);                              /* socketpair no longer needed */
> +
> +    pid_t p2 = fork();
> +    if ( p2 < 0 )

and here

> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
> +        exit(1);
> +    }
> +
> +    if ( p2 != 0 )                          /* new parent: exit right away */

ditto..

> +    {
> +        exit(0);
> +    }
> +
> +    /* grandchild */
> +    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: deferred auth for '%s', pid=%d",
> +               up->username, (int) getpid() );

extra space before the closing )

> +
> +    /* the rest is very simple: do PAM, write status byte to file, done */
> +    int ac_fd = open( ac_file_name, O_WRONLY );

and around here

> +    if ( ac_fd < 0 )

and here

> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot open '%s' for writing",
> +                   ac_file_name );

Space before the closing )

> +        exit(1);
> +    }
> +    int pam_success = pam_auth(service, up);
> +
> +    if ( write( ac_fd, pam_success? "1": "0", 1 ) != 1 )

and here

> +    {
> +        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot write to '%s'",
> +                   ac_file_name );

and before the last )

> +    }
> +    close(ac_fd);
> +    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: %s: deferred auth: PAM %s",
> +               up->username, pam_success? "succeeded": "rejected" );

Same here before the closing ")"

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
> @@ -867,6 +971,22 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>                  /* If password is of the form SCRV1:base64:base64 split it up */
>                  split_scrv1_password(&up);
>
> +                /* client wants deferred auth
> +                 */
> +                if ( strlen(ac_file_name) > 0 )
> +                {
> +                    if (do_deferred_pam_auth(fd, ac_file_name,
> +                                             service, &up) < 0)
> +                    {
> +                        goto done;

Do we have to abort in this case? This will exit the background
process and cripple the server while this could be a temporary memory
pressure causing the fork to fail. Why not just break and plough
along? The core will fail to get a response via the ac_file, but that
could happen if the grand-child fails as well -- the server is
supposed to cope with such failures.

> +                    }
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

Apart from these minor issues that could be corrected or ignored at
merge time, all look good.

We should put the usage info into README.auth-pam as that seems to be
the only documentation of the plugin. Also an entry in changelog?
Could be a separate patch.

Acked-by: Selva Nair <selva.nair@...277...>

