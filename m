MIME-Version: 1.0
References: <CAGyAFMWGUfXeiw6sp5LE1SsH88-TF_K20y6z62MYrOJ_PcMLGg@...278...>
 <20210201150235.19226-1-arne@...1227...>
In-Reply-To: <20210201150235.19226-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 2 Feb 2021 09:50:08 +0200
Message-ID: <CAGyAFMV1-o=v1SCf7Q1WcSuQ0DfMMqEhpkKpZub8kVjryVU9Ag@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Implement server side of
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

Almost there.

Here we still need context, not tls_multi.

> -bool send_auth_pending_messages(struct context *c, const char *extra);
> +bool
> +send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
> +                           unsigned int timeout);


>C:\Users\lev\Projects\openvpn\src\openvpn\multi.c(3907,59): error C2220: the following warning is treated as an error
>C:\Users\lev\Projects\openvpn\src\openvpn\multi.c(3907,59): warning C4133: 'function': incompatible types - from 'context *' to 'tls_multi *'

