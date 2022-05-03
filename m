Date: Tue, 3 May 2022 11:46:01 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1913103764.36168.1651571161812@...2642...>
In-Reply-To: <20220502160945.839283-1-arne@...1227...>
References: <20220422142953.3805364-13-arne@...1227...>
 <20220502160945.839283-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Implement HMAC based session id for
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

Still found a few typos and whitespace issues, but no code issues.

Overall this looks okay to me but I'm hesitant to actually ack it
because I'm not sure of the potential implications of all the protocol
hacks (i.e. the packet id flags and the TLV payload).

> Arne Schwabe <arne@...1227...> hat am 02.05.2022 18:09 geschrieben:
[...]
> @@ -58,37 +82,62 @@ do_pre_decrypt_check(struct multi_context *m,
>      struct openvpn_sockaddr *from = &m->top.c2.from.dest;
>      int handwindow = m->top.options.handshake_window;
>  
> -
>      if (verdict == VERDICT_VALID_RESET_V3)
>      {
> -        /* For tls-crypt-v2 we need to keep the state of the first packet to
> -         * store the unwrapped key */
> -        return true;
> +        /* Extract the packet id to check if it has the special format that
> +         * indicates early negotiation support */
> +        struct packet_id_net pin;
> +        struct buffer tmp = m->top.c2.buf;
> +        ASSERT(buf_advance(&tmp, 1 + SID_SIZE));
> +        ASSERT(packet_id_read(&pin, &tmp, true));
> +
> +        /* The most significant byte ist 0x0f if early negotiation is supported */

Your German is showing ;) "is"

[...]
> diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
> index 9c8154b12..2376446ee 100644
> --- a/src/openvpn/ssl_pkt.c
> +++ b/src/openvpn/ssl_pkt.c
[...]
> @@ -434,8 +443,17 @@ tls_reset_standalone(struct tls_auth_standalone *tas,
>  
>      ASSERT(buf_write(&buf, &net_pid, sizeof(net_pid)));
>  
> +    /* Add indication for tls-crypt-v2 to resend the packet with the with

Redundant "with"

> +     * reply */
[...]
> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index ae92f6b33..9426fb1d8 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
[...]
> @@ -261,4 +272,23 @@ packet_opcode_name(int op)
>              return "P_???";
>      }
>  }
> +
> +/* initial packet id (instead of 0) that indicates that the peer supports
> + * early protocol negotiation. This will make the packet id turn a bit faster
> + * but the network time part of the packet id could take care of that. And
> + * this is also a rather theoretical scenario as it still needs more than
> + * 2^31 control channel packets to happen */
> +#define EARLY_NEG_MASK          0xff000000
> +#define EARLY_NEG_START         0x0a000000
> +
> +#define EARLY_NEG_RESENDWKC     0x00010000
> +
> +
> +/* Early negotiation that part of the server response in the RESET_V2 packet.
> + * Since clients that announce early negotiation support will treat the payload
> + * of reset packets special and parse it as TLV messages.
> + * as TLV (type, length, value) */
> +#define EARLY_NEG_TLV_FLAG          0x01
> +#define EARLY_NEG_FLAG_RESEND_WKC   0x01
>  #endif /* ifndef SSL_PKT_H */
> +

new blank line at EOF.

> diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
> index 36812628e..f3fddf870 100644
> --- a/tests/unit_tests/openvpn/test_pkt.c
> +++ b/tests/unit_tests/openvpn/test_pkt.c
[...]
> @@ -580,11 +580,11 @@ test_generate_reset_packet_tls_auth(void **ut_state)
>  
>      /* Assure repeated generation of reset is deterministic/stateless*/
>      reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
> -    struct buffer buf2 = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
> +    struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header,false);
>      assert_int_equal(BLEN(&buf), BLEN(&buf2));
>      assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
> +    

Trailing whitespace:
--- "a/tests/unit_tests/openvpn/test_pkt.c"^I2022-05-03 11:17:01.179037300 +0200$
+++ "b/tests/unit_tests/openvpn/test_pkt.c"^I2022-05-03 11:17:02.013292900 +0200$
@@ -583,7 +583,7 @@$
     struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header,false);$
     assert_int_equal(BLEN(&buf), BLEN(&buf2));$
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));$
-    $
+$
     free_buf(&buf2);$
     free_tls_pre_decrypt_state(&state);$

>      free_buf(&buf2);
> -
>      free_tls_pre_decrypt_state(&state);
>  
>      packet_id_free(&tas_client.tls_wrap.opt.packet_id);

Regards,
--
Frank Lichtenheld

