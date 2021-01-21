MIME-Version: 1.0
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-5-arne@...1227...>
In-Reply-To: <20200930131317.1299-5-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 21 Jan 2021 13:41:19 +0200
Message-ID: <CAGyAFMVn_E6cqnUgmdNiDq1rWheR8uHT5VEPK6puMjTxbP603w@...278...>
Subject: Re: [Openvpn-devel] [PATCH 03/11] Implement server side of
 AUTH_PENDING with extending timeout
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Note that I didn't manage to apply this patch on the latest master so
I had to apply commit from
https://github.com/schwabe/openvpn/commit/42ae41d812668c4c00badaf592825684fa387d9d

> +static bool
> +parse_kid(const char *str, unsigned int *kid)
<snip>
> +        && parse_uint(timeout_str, "TIMEOUT", &timeout))

Since you've added wrapper "parse_kid", why not add "parse_timeout"
for consistency?

> +        bool ret = send_auth_pending_messages(&mi->context, extra, timeout);

>C:\Users\lev\Projects\openvpn\src\openvpn\multi.c(3907,68): error C2220: the following warning is treated as an error
>C:\Users\lev\Projects\openvpn\src\openvpn\multi.c(3907,68): warning C4020: 'send_auth_pending_messages': too many actual parameters


> -send_auth_pending_messages(struct context *c, const char *extra)
> +send_auth_pending_messages(struct context *c, const char *extra,
> +                           unsigned int timeout)
>  {
> -    send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
> +    struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];

>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(354,1): error C2220: the following warning is treated as an error
>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(354,1): warning C4029: declared formal parameter list different from definition
>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(355,38): error C2065: 'tls_multi': undeclared identifier
>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(355,40): error C2223: left of '->session' must point to struct/union

> +        size_t len = 20 + 1 + sizeof(auth_pre);
<snip>
>      size_t len = strlen(extra)+1 + sizeof(info_pre);

Whitespace inconsistency.


> +unsigned int
> +extract_iv_proto(const char *peer_info)
> +{
> +
> +    const char *optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;

Unnecessary line break.

-- 
-Lev

