MIME-Version: 1.0
References: <20191025110631.15540-1-wardragon78@...277...>
In-Reply-To: <20191025110631.15540-1-wardragon78@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Oct 2019 10:42:38 -0400
Message-ID: <CAKuzo_gYw3qJBYp7osam-kbAxANFKQLHv6jA6n0eqyNTYxKarw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] [PATCH v2] Insert client connection
 data into PAM environment
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
To: Paolo Cerrito <wardragon78@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, lorenzo.catucci@...2517..., paolo <paolo.cerrito@...2517...>

On Fri, Oct 25, 2019 at 7:08 AM <wardragon78@...277...> wrote:
>
> From: Paolo Cerrito <wardragon78@...277...>
>
> Without this patch, the PAM environment lacks any information about the remote client address.
>
> syslog output for auth and authpriv facilities changes
> from:
>    Oct 25 11:52:02 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
>                    logname=root uid=0 euid=0 tty= ruser= rhost=
>    Oct 25 11:52:33 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
>                    logname=root uid=0 euid=0 tty= ruser= rhost=  user=****
> to:
>    Oct 25 10:56:11 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
>                    logname=root uid=0 euid=0 tty= ruser= rhost=198.51.100.10
>    Oct 25 10:57:02 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
>                    logname=root uid=0 euid=0 tty= ruser= rhost=198.51.100.10 user=****
>
> Furthermore, the presence of the remote client address in PAM
> environment, enables usage of pam modules like pam_recent
> [https://github.com/az143/pam_recent].
>
> Signed-off-by: Paolo Cerrito <wardragon78@...277...>

So, apart from the commit message, what are the changes in v2?

I don't see that my comment about ensuring remote read from env is not NULL
addressed, nor any response to a number of other points raised by David.

> ---
>  src/plugins/auth-pam/auth-pam.c | 39 ++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
> index 88b53204..f7b39e36 100644
> --- a/src/plugins/auth-pam/auth-pam.c
> +++ b/src/plugins/auth-pam/auth-pam.c
> @@ -115,6 +115,7 @@ struct user_pass {
>      char password[128];
>      char common_name[128];
>      char response[128];
> +    char remote[40];

Textual ipv6 address buffer is usually defined to be at least 46 bytes
including NUL (not 40) to handle all cases.
(cf. INET6_ADDRSTRLEN = 46 in <netinet/in.h>)


Selva

