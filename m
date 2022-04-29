Date: Fri, 29 Apr 2022 15:40:22 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1660158989.694251.1651239622072@...2642...>
In-Reply-To: <20220422142953.3805364-13-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-13-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 22/28] Implement HMAC based session id
 for tls-crypt v2
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

One additional small issue:

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
[...]
> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index 75cdc1c58..48b94e952 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
> @@ -218,10 +224,12 @@ read_control_auth(struct buffer *buf,
>   * The returned buf need to be free with \c free_buf
>   */
>  struct buffer
> -tls_reset_standalone(struct tls_auth_standalone *tas,
> +tls_reset_standalone(struct tls_wrap_ctx *ctx,
> +                     struct tls_auth_standalone *tas,
>                       struct session_id *own_sid,
>                       struct session_id *remote_sid,
> -                     uint8_t header);
> +                     uint8_t header,
> +                     bool b);

"b" -> "tlscryptv2"

Regards,
--
Frank Lichtenheld

