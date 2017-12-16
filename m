MIME-Version: 1.0
In-Reply-To: <1513450642-29687-1-git-send-email-Michael.Karvan@...277...>
References: <1513450642-29687-1-git-send-email-Michael.Karvan@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 16 Dec 2017 16:48:51 -0500
Message-ID: <CAKuzo_h5j47vjO65KUSmXwm5zwTnzNpaJCmLeGh-6Uq5nZnxVA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add common_name to the conv method.
 This allows the common_name to be accessible in PAM.
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
To: Michael Karvan <michael.karvan@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sat, Dec 16, 2017 at 1:57 PM, Michael Karvan
<michael.karvan@...277...> wrote:
> ---
>  src/plugins/auth-pam/auth-pam.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index ae514d7..c64e14b 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -637,9 +637,16 @@ my_conv(int n, const struct pam_message **msg_array,
>                          ret = PAM_CONV_ERR;
>                      }
>                      break;
> +
> +                case PAM_TEXT_INFO:
> +                    aresp[i].resp = strdup(up->common_name);
> +                    if (aresp[i].resp == NULL)
> +                    {
> +                        ret = PAM_CONV_ERR;
> +                    }
> +                    break;

The purpose of PAM_TEXT_INFO is for the module to send an info message
to the user. Using it to send the common name back to the module is
hackish. Yes, it can work in a custom module but its not right to
interpret every
PAM_TEXT_INFO msg as a request for common name.

Why not prompt for it just like username and have the plugin return it?

Selva

