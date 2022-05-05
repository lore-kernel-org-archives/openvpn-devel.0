Date: Thu, 5 May 2022 15:34:29 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1196523451.256289.1651757669825@...2642...>
In-Reply-To: <20220505130348.1183195-1-arne@...1227...>
References: <20220422142953.3805364-13-arne@...1227...>
 <20220505130348.1183195-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v4] Implement HMAC based session id for
 tls-crypt v2
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

> Arne Schwabe <arne@...1227...> hat am 05.05.2022 15:03 geschrieben:
>
[...] 
> diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
> index 810b189e9..dad65e26a 100644
> --- a/src/openvpn/ssl_pkt.c
> +++ b/src/openvpn/ssl_pkt.c
[...]
> @@ -434,8 +443,17 @@ tls_reset_standalone(struct tls_auth_standalone *tas,
>  
>      ASSERT(buf_write(&buf, &net_pid, sizeof(net_pid)));
>  
> +    /* Add indication for tls-crypt-v2 to resend the packet with the with
> +     * reply */

You didn't fix this comment. In my v3 review I thought the second "with" was
redundant, but now I think you probably meant "with the key with the reply"?

> +    if (request_resend_wkc)
> +    {
> +        buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
> +        buf_write_u16(&buf, sizeof(uint16_t));
> +        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
> +    }
> +
>      /* Add tls-auth/tls-crypt wrapping, this might replace buf */
> -    tls_wrap_control(&tas->tls_wrap, header, &buf, own_sid);
> +    tls_wrap_control(ctx, header, &buf, own_sid);
>  
>      return buf;
>  }

Regards,
--
Frank Lichtenheld

