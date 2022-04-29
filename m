Date: Fri, 29 Apr 2022 10:48:42 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1709708673.663686.1651222122635@...2642...>
In-Reply-To: <20220427223419.241904-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220427223419.241904-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Implement constructing a control
 channel reset client as standalone fucntion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Some small issues Gert might decide to fix on apply:

Typo "fucntion" in summary line of commit message.

> Arne Schwabe <arne@...1227...> hat am 28.04.2022 00:34 geschrieben:
> This implement creating a reset packet without needing to setup a full control

"implements"

> session.
[...]
> diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
> index 7233871b1..a93027505 100644
> --- a/src/openvpn/ssl_pkt.c
> +++ b/src/openvpn/ssl_pkt.c
[...]
> +    /* Add tls-auth/tls-crypt wrapping, this might replace buf */
> +    tls_wrap_control(&tas->tls_wrap, header, &buf, own_sid);
> +
> +    return buf;
> +}
> +

git am complains about "new blank line at EOF."

> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index b7a8d9c35..dd9361407 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
[...]
> @@ -157,6 +163,19 @@ read_control_auth(struct buffer *buf,
>                    const struct link_socket_actual *from,
>                    const struct tls_options *opt);
>  
> +
> +/**
> + * This function creates a reset packet using the information
> + * from the tls pre decrypt state.
> + *
> + * The returned buf need to be free with \c free_buf

"needs"

Regards,
--
Frank Lichtenheld

