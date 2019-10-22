References: <20190613144113.6418-1-arne@...1227...>
 <20190613144113.6418-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d47685f2-7a6c-0571-1045-bf4d67f6ebce@...2080...>
Date: Tue, 22 Oct 2019 22:37:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190613144113.6418-4-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 3/5] Implement support for signalling
 IV_SSO to server
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 13/06/2019 16:41, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 640808f9..45806553 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2343,7 +2343,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>                  if ((((strncmp(e->string, "UV_", 3)==0
>                         || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=")-1)==0)
>                        && session->opt->push_peer_info_detail >= 2)
> -                     || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0))
> +                     || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0)
> +                     || (strncmp(e->string,"IV_SSO=",sizeof("IV_SSO=")-1)==0)
> +                     )
>                      && buf_safe(&out, strlen(e->string)+1))
>                  {
>                      buf_printf(&out, "%s\n", e->string);
> 

These new lines breaks the coding style of spaces around '==' and after comma
in the strncmp() arguments, but so does the existing code.  This needs to be
fixed, but lets handle that outside of this patch set.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


