References: <20171203131651.622-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <8607686f-75ac-ab6a-21a9-5aab8aea34c3@...1856...>
Date: Sun, 3 Dec 2017 16:02:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171203131651.622-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] reload HTTP proxy credentials when
 moving to the next connection profile
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
To: openvpn-devel@lists.sourceforge.net

Hi,

Feature-ACK, but one implementation concern:

On 03-12-17 14:16, Antonio Quartulli wrote:
> The HTTP proxy credentials are stored in a static variable that is
> possibly initialized before each connection attempt.
> 
> However, the variable is never "released" therefore get_user_pass()
> refuses to overwrite its content and leaves it as it is.
> Consequently, if the user config contains multiple connection profiles
> with different http-proxy, each having its own credentials, only the
> first user/pass couple is loaded and the others are all ignored.
> This leads to connection failures because the proper credentials are
> not associated with the right proxy server.
> 
> The root of the misbehaviour seems to be located in the fact that,
> despite the argument force passed to get_user_pass_http() being true,
> no action is taken to release the static object containing the
> credentials.
> 
> Fix the misbehaviour by releasing the http-proxy credential object
> when the reload is "forced".
> 
> Trac: #836
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> v2:
> - rebased on current master
> 
>  src/openvpn/proxy.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index fdc73b4a..cfc1d11c 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -255,7 +255,16 @@ username_password_as_base64(const struct http_proxy_info *p,
>  static void
>  get_user_pass_http(struct http_proxy_info *p, const bool force)
>  {
> -    if (!static_proxy_user_pass.defined || force)
> +    /*
> +     * in case of forced (re)load, make sure the static storage is set as
> +     * undefined, otherwise get_user_pass() won't try to load any credential
> +     */
> +    if (force)
> +    {
> +        static_proxy_user_pass.defined = false;
> +    }

I'm wondering, shouldn't we clear the username/password in the struct if
we set defined=false as a hardening measure?  And shouldn't we then just
replace this if(force) block with a call to purge_user_pass(up, force)?
Or should we be careful to not clear the other members of
static_proxy_user_pass?

-Steffan

