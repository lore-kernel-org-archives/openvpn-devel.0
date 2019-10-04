References: <20191001120652.31898-1-wardragon78@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4f8d5227-54c3-1685-2f6a-9dad13ca4c4a@...2080...>
Date: Fri, 4 Oct 2019 20:09:37 +0200
MIME-Version: 1.0
In-Reply-To: <20191001120652.31898-1-wardragon78@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Insert client connection data into PAM
 environment
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
To: Paolo Cerrito <wardragon78@...277...>, openvpn-devel@lists.sourceforge.net
Cc: paolo <paolo.cerrito@...2517...>

Hi Paolo,

Thank you very much for this patch.  Selva has already given this a
feature-ack, which I agree to.  So lets continue here.

First of all, it is really important that the commit message is good on
patches.  Please read this really good blog post on this topic:
<https://chris.beams.io/posts/git-commit/>

And as an example of a reasonably good commit message in OpenVPN is for
example this one:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17870.html>

The keypoints in a commit message are:

 - Subject line
   A straight to the point what this change is about

 - Commit message:
   Explain *why* this change is needed, *what* does change this give us.
   Don't describe how, as that need to be clear in the commit diff below the
   commit message.

   And having the "Signed-off-by: " line in the commit message is also really
   important.

Secondly, when you next time submit a patch, please ensure it has a proper
version identifier if you update a patch you have already sent.

And now ... the review of your patch, please follow in between the diff lines
below.

On 01/10/2019 14:06, Paolo Cerrito wrote:
> From: paolo <paolo.cerrito@...2517...>
> 
> ---
>  src/plugins/auth-pam/auth-pam.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 88b53204..9d8dfb95 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -115,6 +115,7 @@ struct user_pass {
>      char password[128];
>      char common_name[128];
>      char response[128];
> +    char remote[128];

Why 128 bytes?  Unless I'm mistaken, an IPv6 address can be up to 39
characters and an IPv4 will never be longer than 15 characters.  So having 40
bytes should be reasonable enough, as that give space for a \0 terminator too.

>      const struct name_value_list *name_value_list;
>  };
> @@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
>          const char *username = get_env("username", envp);
>          const char *password = get_env("password", envp);
>          const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
> +        const char *remote = get_env("untrusted_ip", envp) ? get_env("untrusted_ip", envp) : get_env("untrusted_ip6", envp);

I know we don't do this in the get_env() lines below, but we should really try
to restrict the number of bytes we extract from the env table.

This isn't functionally important in this code here, but more a generic and
common way.  IPv6 is generally preferred over IPv4 by the OS, so you should
check if untrusted_ip6 is present and then only extract the IPv4 address if
there is no IPv6 address.


>          if (username && strlen(username) > 0 && password)
>          {
>              if (send_control(context->foreground_fd, COMMAND_VERIFY) == -1
>                  || send_string(context->foreground_fd, username) == -1
>                  || send_string(context->foreground_fd, password) == -1
> -                || send_string(context->foreground_fd, common_name) == -1)
> +                || send_string(context->foreground_fd, common_name) == -1
> +                || send_string(context->foreground_fd, remote) == -1)
>              {
>                  fprintf(stderr, "AUTH-PAM: Error sending auth info to background process\n");
>              }
> @@ -750,8 +753,16 @@ pam_auth(const char *service, const struct user_pass *up)
>      status = pam_start(service, name_value_list_provided ? NULL : up->username, &conv, &pamh);
>      if (status == PAM_SUCCESS)
>      {
> +        /* Set PAM_RHOST environment variable */
> +        if (*(up->remote))
> +        {
> +            status = pam_set_item(pamh, PAM_RHOST, up->remote);
> +        }
>          /* Call PAM to verify username/password */
> -        status = pam_authenticate(pamh, 0);
> +        if (status == PAM_SUCCESS)
> +        {
> +            status = pam_authenticate(pamh, 0);
> +        }

I understand the importance of this call.  But can this break anything for
existing configurations already using auth-pam?  I think this check should be
enabled by an option given to the auth-pam module in the 'plugin' OpenVPN
statement.  You will see that argument in the char **argv array pointer found
in struct openvpn_plugin_args_open_in in the openvpn_plugin_open_v3()
function.  I suggest an option as simple as "call-pam-auth" or something like
that.

>          if (status == PAM_SUCCESS)
>          {
>              status = pam_acct_mgmt(pamh, 0);
> @@ -839,7 +850,8 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>              case COMMAND_VERIFY:
>                  if (recv_string(fd, up.username, sizeof(up.username)) == -1
>                      || recv_string(fd, up.password, sizeof(up.password)) == -1
> -                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1)
> +                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1
> +                    || recv_string(fd, up.remote, sizeof(up.remote)) == -1)
>                  {
>                      fprintf(stderr, "AUTH-PAM: BACKGROUND: read error on command channel: code=%d, exiting\n",
>                              command);
> @@ -853,6 +865,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
>                              up.username, up.password);
>  #else
>                      fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
> +                    fprintf(stderr, "AUTH-PAM: BACKGROUND: REMOTE: %s\n", up.remote);

Two things.  I think it would be good to have the up.remote in the same line
as up.username.   But you it should probably be empty ("") if up.remote is
NULL.  And I suggest using the same format as found in other parts of the
OpenVPN logging ... "USERNAME/IP-ADDRESS".   If IP address is not available,
use just "USERNAME".

If you have any questions or comments, feel free to reach out.  And also feel
free to join the #openvpn-devel IRC channel on FreeNode; there are several of
us community and corporate developers there so it is a chance to get quicker
replies there (most of us are in the EU time zones).


-- 
kind regards,

David Sommerseth
OpenVPN Inc


