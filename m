References: <20210722162409.231265-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e32ff2bb-1f98-ef3c-73c0-2b5d3214cba9@...2181...>
Date: Tue, 27 Jul 2021 15:42:32 +0200
MIME-Version: 1.0
In-Reply-To: <20210722162409.231265-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix OpenVPN querying user/password if
 auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/07/2021 18:24, Arne Schwabe wrote:
> The problematic behaviour happens when start a profile without
> auth-user-pass and connect to a server that pushes auth-token
> When the auth token expires OpenVPN asks for auth User and password
> again.
> 
> The problem is that the auth_user_pass_setup sets
> auth_user_pass_enabled = true; This function is called from two places.
> In ssl.c it is only called with an auth-token present or that
> variable already set. The other one is init_query_passwords.
> 
> Move setting auth_user_pass_enabled to the second place to ensure it is
> only set if we really want passwords.
> ---
>  src/openvpn/init.c | 2 ++
>  src/openvpn/ssl.c  | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a1401e805..f9083e69c 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -595,6 +595,7 @@ init_query_passwords(const struct context *c)
>      /* Auth user/pass input */
>      if (c->options.auth_user_pass_file)
>      {
> +        auth_user_pass_enabled = true;
>  #ifdef ENABLE_MANAGEMENT
>          auth_user_pass_setup(c->options.auth_user_pass_file, &c->options.sc_info);

init.c: In function ‘init_query_passwords’:
init.c:597:9: error: ‘auth_user_pass_enabled’ undeclared (first use in
this function); did you mean ‘auth_user_pass_setup’?
  597 |         auth_user_pass_enabled = true;
      |         ^~~~~~~~~~~~~~~~~~~~~~
      |         auth_user_pass_setup


anything wrong with my master branch?



-- 
Antonio Quartulli

