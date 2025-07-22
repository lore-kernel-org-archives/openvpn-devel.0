Message-ID: <baac2bee-c7ed-4bbd-a982-62625df7f7ff@...2889...>
Date: Tue, 22 Jul 2025 13:11:51 +0200
MIME-Version: 1.0
References: <gerrit.1750855087000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
 <0ce8cd0299fe59653b623aa0f39ebf25341ff1eb-EmailReplacePatchSet-HTML@...2715...>
Content-Language: en-US, sv-SE, nl
From: Walter Doekes <walter.openvpn@...2889...>
In-Reply-To: <0ce8cd0299fe59653b623aa0f39ebf25341ff1eb-EmailReplacePatchSet-HTML@...2715...>
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: Check message
 id/acked ids too when doing sessionid cookie checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

Anything I can do to get this moving along?

Cheers,
Walter


On 26-06-2025 10:14, plaisthos (Code Review) wrote:
> Attention is currently required from: flichtenheld.
> 
> plaisthos *uploaded patch set #3* to this change.
> 
> View Change <http://gerrit.openvpn.net/c/openvpn/+/1067?usp=email>
> 
> Check message id/acked ids too when doing sessionid cookie checks
> 
> This fixes that control packets on a floating client can trigger
> creating a new session in special circumstances:
> 
> To trigger this circumstance a connection needs to
> 
> - starts on IP A
> - successfully floats to IP B by data packet
> - then has a control packet from IP A before any
>    data packet can trigger the float back to IP A
> 
> and all of this needs to happen in the 60s time
> that hmac cookie is valid in the default
> configuration.
> 
> In this scenario we would trigger a new connection as the HMAC
> session id would be valid.
> 
> This patch adds checking also of the message-id and acked ids to
> discern packet from the initial three-way handshake where these
> ids 0 or 1 from any later packet.
> 
> This will now trigger (at verb 4 or higher) a messaged like:
> 
>     Packet (P_ACK_V1) with invalid or missing SID
> 
> instead.
> 
> Reported-By: Walter Doekes <walter.openvpn@...2889...>
> Tested-By: Walter Doekes <walter.openvpn@...2889...>
> 
> Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
> M src/openvpn/mudp.c
> M src/openvpn/ssl_pkt.c
> M src/openvpn/ssl_pkt.h
> M tests/unit_tests/openvpn/test_pkt.c
> 4 files changed, 112 insertions(+), 6 deletions(-)
> 
> git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1067/3
> 
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 93e65e0..9cd667c 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -63,7 +63,6 @@
> msg(D_MULTI_DEBUG, "Reset packet from client, sending HMAC based reset 
> challenge");
> }
> 
> -
> /* Returns true if this packet should create a new session */
> static bool
> do_pre_decrypt_check(struct multi_context *m,
> @@ -155,7 +154,8 @@
> * need to contain the peer id */
> struct gc_arena gc = gc_new();
> 
> - bool ret = check_session_id_hmac(state, from, hmac, handwindow);
> + bool pkt_is_ack = (verdict == VERDICT_VALID_ACK_V1);
> + bool ret = check_session_id_hmac(state, from, hmac, handwindow, 
> pkt_is_ack);
> 
> const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
> uint8_t pkt_firstbyte = *BPTR( &m->top.c2.buf);
> @@ -171,6 +171,7 @@
> msg(D_MULTI_DEBUG, "Valid packet (%s) with HMAC challenge from peer (%s), "
> "accepting new connection.", packet_opcode_name(op), peer);
> }
> +
> gc_free(&gc);
> 
> return ret;
> diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
> index bfd405f..0bbc465 100644
> --- a/src/openvpn/ssl_pkt.c
> +++ b/src/openvpn/ssl_pkt.c
> @@ -293,6 +293,7 @@
> }
> }
> 
> +
> /*
> * This function is similar to tls_pre_decrypt, except it is called
> * when we are in server mode and receive an initial incoming
> @@ -530,7 +531,8 @@
> check_session_id_hmac(struct tls_pre_decrypt_state *state,
> const struct openvpn_sockaddr *from,
> hmac_ctx_t *hmac,
> - int handwindow)
> + int handwindow,
> + bool pkt_is_ack)
> {
> if (!from)
> {
> @@ -545,6 +547,36 @@
> return false;
> }
> 
> + /* Check if the packet ID of the packet or ACKED packet is <= 1 */
> + for (int i = 0; i < ack.len; i++)
> + {
> + /* This packet ACKs a packet that has a higher packet id than the
> + * ones expected in the three-way handshake, consider it as invalid
> + * for the session */
> + if (ack.packet_id[i] > 1)
> + {
> + return false;
> + }
> + }
> +
> + if (!pkt_is_ack)
> + {
> + packet_id_type message_id;
> + /* Extract the packet ID from the packet */
> + if (!reliable_ack_read_packet_id(&buf, &message_id))
> + {
> + return false;
> + }
> +
> + /* similar check. Anything larger than 1 is not considered part of the
> + * three-way handshake */
> + if (message_id > 1)
> + {
> + return false;
> + }
> + }
> +
> +
> /* check adjacent timestamps too */
> for (int offset = -2; offset <= 1; offset++)
> {
> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index 98a39d3..1b6bcc0 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
> @@ -180,17 +180,24 @@
> /**
> * Checks if a control packet has a correct HMAC server session id
> *
> + * This will also consider packets that have a packet id higher
> + * than 1 or ack packets higher than 1 to be invalid as they are
> + * not part of the initial three way handshake of OpenVPN and should
> + * not create a new connection.
> + *
> * @param state session information
> * @param from link_socket from the client
> * @param hmac the hmac context to use for the calculation
> * @param handwindow the quantisation of the current time
> + * @param pkt_is_ack the packet being checked is a P_ACK_V1
> * @return the expected server session id
> */
> bool
> check_session_id_hmac(struct tls_pre_decrypt_state *state,
> const struct openvpn_sockaddr *from,
> hmac_ctx_t *hmac,
> - int handwindow);
> + int handwindow,
> + bool pkt_is_ack);
> 
> /*
> * Write a control channel authentication record.
> diff --git a/tests/unit_tests/openvpn/test_pkt.c 
> b/tests/unit_tests/openvpn/test_pkt.c
> index ebffabe..56ed842 100644
> --- a/tests/unit_tests/openvpn/test_pkt.c
> +++ b/tests/unit_tests/openvpn/test_pkt.c
> @@ -170,6 +170,27 @@
> 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
> };
> 
> +/* no tls-auth, P_ACK_V1, acks 0,1, and 2 */
> +const uint8_t client_ack_123_none_random_id[] = {
> + 0x28,
> + 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,
> + 0x03,
> + 0x00, 0x00, 0x00, 0x00,
> + 0x00, 0x00, 0x00, 0x01,
> + 0x00, 0x00, 0x00, 0x02,
> + 0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
> +};
> +
> +/* no tls-auth, P_CONTROL_V1, acks 0, msg-id 2 */
> +const uint8_t client_control_none_random_id[] = {
> + 0x20,
> + 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,
> + 0x01,
> + 0x00, 0x00, 0x00, 0x00,
> + 0x02
> +};
> +
> +
> struct tls_auth_standalone
> init_tas_auth(int key_direction)
> {
> @@ -439,7 +460,7 @@
> assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
> 
> /* This is a valid packet but containing a random id instead of an HMAC id*/
> - bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30);
> + bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30, false);
> assert_false(valid);
> 
> free_tls_pre_decrypt_state(&state);
> @@ -470,7 +491,7 @@
> verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
> assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
> 
> - bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30);
> + bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30, true);
> assert_true(valid);
> 
> free_tls_pre_decrypt_state(&state);
> @@ -479,6 +500,50 @@
> hmac_ctx_free(hmac);
> }
> 
> +static void
> +test_verify_hmac_none_out_of_range_ack(void **ut_state)
> +{
> + hmac_ctx_t *hmac = session_id_hmac_init();
> +
> + struct link_socket_actual from = { 0 };
> + from.dest.addr.sa.sa_family = AF_INET;
> +
> + struct tls_auth_standalone tas = { 0 };
> + struct tls_pre_decrypt_state state = { 0 };
> +
> + struct buffer buf = alloc_buf(1024);
> + enum first_packet_verdict verdict;
> +
> + tas.tls_wrap.mode = TLS_WRAP_NONE;
> +
> + buf_reset_len(&buf);
> + buf_write(&buf, client_ack_123_none_random_id, 
> sizeof(client_ack_123_none_random_id));
> +
> +
> + verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
> + assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
> +
> + /* should fail because it acks 2 */
> + bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30, true);
> + assert_false(valid);
> +
> + /* Try test with the control with a too high message id now */
> + buf_reset_len(&buf);
> + buf_write(&buf, client_control_none_random_id, 
> sizeof(client_control_none_random_id));
> +
> + verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
> + assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
> +
> + /* should fail because it has message id 2 */
> + valid = check_session_id_hmac(&state, &from.dest, hmac, 30, true);
> + assert_false(valid);
> +
> + free_tls_pre_decrypt_state(&state);
> + free_buf(&buf);
> + hmac_ctx_cleanup(hmac);
> + hmac_ctx_free(hmac);
> +}
> +
> static hmac_ctx_t *
> init_static_hmac(void)
> {
> @@ -667,6 +732,7 @@
> cmocka_unit_test(test_calc_session_id_hmac_static),
> cmocka_unit_test(test_verify_hmac_none),
> cmocka_unit_test(test_verify_hmac_tls_auth),
> + cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
> cmocka_unit_test(test_generate_reset_packet_plain),
> cmocka_unit_test(test_generate_reset_packet_tls_auth),
> cmocka_unit_test(test_extract_control_message)
> 
> To view, visit change 1067 
> <http://gerrit.openvpn.net/c/openvpn/+/1067?usp=email>. To unsubscribe, 
> or for help writing mail filters, visit settings 
> <http://gerrit.openvpn.net/settings>.
> 
> Gerrit-Project: openvpn
> Gerrit-Branch: master
> Gerrit-Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
> Gerrit-Change-Number: 1067
> Gerrit-PatchSet: 3
> Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
> Gerrit-Reviewer: flichtenheld <frank@...2641...>
> Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Gerrit-Attention: flichtenheld <frank@...2641...>
> Gerrit-MessageType: newpatchset
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

