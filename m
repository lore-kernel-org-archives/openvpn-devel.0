MIME-Version: 1.0
References: <20200620162206.13956-1-gert@...1296...>
In-Reply-To: <20200620162206.13956-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Jun 2020 18:23:15 -0400
Message-ID: <CAKuzo_g0eLCFXHgP=g47Q2j3mbY09+VKMXbZeJSEZV3z+Dy-KA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add deferred authentication support to
 plugin-auth-pam
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

On Sat, Jun 20, 2020 at 12:23 PM Gert Doering <gert@...1296...> wrote:
>
> If OpenVPN signals deferred authentication support (by setting the
> internal environment variable "auth_control_file"), do not wait
> for PAM stack to finish.  Instead, the privileged PAM process
> returns RESPONSE_DEFER via the control socket, which gets turned
> into OPENVPN_PLUGIN_FUNC_DEFERRED towards openvpn.
>
> The PAM process will then fork() and handle all the PAM auth in the
> new process, signalling success/failure back by means of the
> auth_control_file (forking twice, to simplify wait() handling).
>
> With the extra fork(), multiple deferred authentications can run at
> the same time - otherwise the first one would block the next auth
> call (because the child would not be ready again to read from the
> control socket).

I have no doubt this will work, but can we avoid the double fork? Instead,
we could set a handler for SIGCHLD and reap all child pids there using
a non blocking waitpid(-1, NULL, WNOHANG). Will have to also check for
EINTR and retry in recv_control() and possibly recv_string().

Fork is probably not expensive, but two of them per auth event look
excessive and not very elegant, somehow.

>
> Lightly tested on Linux.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/plugins/auth-pam/auth-pam.c | 88 ++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 9a11876d..777957fa 100644
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
> @@ -524,12 +525,21 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
>          const char *password = get_env("password", envp);
>          const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
>
> +        /* get auth_control_file filename from envp string array*/
> +        const char *auth_control_file = get_env("auth_control_file", envp);
> +        if ( auth_control_file == NULL )
> +        {
> +            auth_control_file = "";
> +        }
> +        plugin_log(PLOG_NOTE, MODULE, "deferred auth '%s'", auth_control_file);
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
> @@ -540,6 +550,11 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
>                  {
>                      return OPENVPN_PLUGIN_FUNC_SUCCESS;
>                  }
> +                if (status == RESPONSE_DEFER)
> +                {
> +                    plugin_log(PLOG_NOTE, MODULE, "deferred authentication active");
> +                    return OPENVPN_PLUGIN_FUNC_DEFERRED;
> +                }
>                  if (status == -1)
>                  {
>                      plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error receiving auth confirmation from background process");
> @@ -789,6 +804,7 @@ static void
>  pam_server(int fd, const char *service, int verb, const struct name_value_list *name_value_list)
>  {
>      struct user_pass up;
> +    char ac_file_name[PATH_MAX];
>      int command;
>  #ifdef USE_PAM_DLOPEN
>      static const char pam_so[] = "libpam.so";
> @@ -847,7 +863,8 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>              case COMMAND_VERIFY:
>                  if (recv_string(fd, up.username, sizeof(up.username)) == -1
>                      || recv_string(fd, up.password, sizeof(up.password)) == -1
> -                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1)
> +                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1
> +                    || recv_string(fd, ac_file_name, sizeof(ac_file_name)) == -1)
>                  {
>                      plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
>                              command);
> @@ -867,6 +884,73 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>                  /* If password is of the form SCRV1:base64:base64 split it up */
>                  split_scrv1_password(&up);
>
> +                /* client wants deferred auth
> +                 * TODO: put this into its own function
> +                 */

TODOs seldom get attended to, it's now or never :)

> +                if ( strlen(ac_file_name) > 0 )
> +                {
> +                    if (send_control(fd, RESPONSE_DEFER) == -1)
> +                    {
> +                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [4]");
> +                        goto done;
> +                    }
> +
> +                    /* double forking so we do not need to wait() for
> +                     * async auth kids
> +                     */
> +                    pid_t p1 = fork();
> +
> +                    if ( p1 < 0 )
> +                    {
> +                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(1) failed");
> +                        goto done;
> +                    }
> +                    if ( p1 != 0 )                         /* parent */
> +                    {
> +                        waitpid(p1, NULL, 0);
> +                        /* plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: fork(1), parent=%d, waitpid(%d) done, loop on", (int) getpid(), (int) p1 ); */
> +                        break;
> +                    }
> +
> +                    /* child */
> +                    pid_t p2 = fork();
> +
> +                    if ( p2 < 0 )
> +                    {
> +                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
> +                        goto done;
> +                    }
> +
> +                    if ( p2 != 0 )                        /* parent-child */
> +                    {
> +                        /* plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: fork(2), mid=%d, exiting", (int) getpid() ); */
> +                        exit(0);
> +                    }
> +
> +                    /* grandchild */
> +                    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: deferred auth handler, pid=%d", (int) getpid() );

I think the scoket in the parent could be closed here. The child
doesn't need it.

> +
> +                    /* simple: do PAM, write status byte to file, done */
> +                    int ac_fd = open( ac_file_name, O_WRONLY );
> +                    if ( ac_fd < 0 )
> +                    {
> +                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot open '%s' for writing", ac_file_name );
> +                        exit(1);
> +                    }
> +                    int pam_success = pam_auth(service, &up);
> +
> +                    if ( write( ac_fd, pam_success? "1": "0", 1 ) != 1 )
> +                    {
> +                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot write to '%s'", ac_file_name );
> +                    }
> +                    close(ac_fd);
> +                    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: deferred auth finished" );
> +                    exit(0);
> +                }
> +
> +                /* non-deferred auth: wait for pam result and send
> +                 * result back via control socketpair
> +                 */
>                  if (pam_auth(service, &up)) /* Succeeded */
>                  {
>                      if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
> --
> 2.26.2

Looks good otherwise.

As auth_control_file is always generated by the core built with
PLUGIN_DEF_AUTH, the patch appears to make deferred auth the default
with this plugin. So PLUGIN_DEF_AUTH takes a new meaning now.

Not a fault of this patch, but I noticed that the auth_control_file is
removed only during the next auth cycle for the same client, or while
restarting the client, not promptly after an auth success or failure.


Selva

