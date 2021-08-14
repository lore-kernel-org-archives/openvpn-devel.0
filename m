References: <20210814044834.2236-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bc0d8acb-4fb9-5c04-3307-62e950c9ea8f@...1227...>
Date: Sat, 14 Aug 2021 13:30:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210814044834.2236-1-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix client-pending-auth help message in
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 14.08.21 um 06:48 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Add the missing timeout value that is required (not optional)
> - Split the long line
> - Also make the AUTH_PENDING state message format in
>   management-notes.txt more precise.
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  doc/management-notes.txt | 2 +-
>  src/openvpn/manage.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index c2034429..5b920fa5 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -658,7 +658,7 @@ implementations the name IV_SSO is kept in lieu of a better name.
>  The management interface of the client receives notification of
>  pending auth via
>  
> ->STATE:datetime,AUTH_PENDING,[timeout number]
> +>STATE:datetime,AUTH_PENDING,[timeout number],,,,,
>  
>  If {EXTRA} is present the client is informed using INFOMSG
>  notification as
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 86584c4b..f86c87f2 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -104,8 +104,8 @@ man_help(void)
>      msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
>      msg(M_CLIENT, "client-deny CID KID R [CR] : Deny auth client-id/key-id CID/KID with log reason");
>      msg(M_CLIENT, "                             text R and optional client reason text CR");
> -    msg(M_CLIENT, "client-pending-auth CID MSG : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg"
> -        "                          to the client and wait for a final client-auth/client-deny");
> +    msg(M_CLIENT, "client-pending-auth CID MSG timeout : Instruct OpenVPN to send AUTH_PENDING and INFO_PRE msg");
> +    msg(M_CLIENT, "                                      to the client and wait for a final client-auth/client-deny");
>      msg(M_CLIENT, "client-kill CID [M]    : Kill client instance CID with message M (def=RESTART)");
>      msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
>  #ifdef MANAGEMENT_PF
> 

Acked-By: Arne Schwabe <arne@...1227...>

