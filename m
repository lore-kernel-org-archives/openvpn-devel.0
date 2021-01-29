MIME-Version: 1.0
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-4-arne@...1227...>
In-Reply-To: <20210125125628.30364-4-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 29 Jan 2021 10:22:20 +0200
Message-ID: <CAGyAFMWGUfXeiw6sp5LE1SsH88-TF_K20y6z62MYrOJ_PcMLGg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 03/11] Implement server side of
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

Looks fine, except

> -    send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
> +    struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];

>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(350,1): error C2220: the following warning is treated as an error
>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(350,1): warning C4029: declared formal parameter list different from definition
>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(351,38): error C2065: 'tls_multi': undeclared identifier
>C:\Users\lev\Projects\openvpn\src\openvpn\push.c(351,40): error C2223: left of '->session' must point to struct/union

-Lev

