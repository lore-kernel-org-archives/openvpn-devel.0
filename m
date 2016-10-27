From: David Sommerseth <davids@...515...>
Date: Thu, 27 Oct 2016 16:37:39 +0200
Message-Id: <1477579059-9596-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] cleanup: Remove NOP code sections in
	ssl.c:tls_process()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

In tls_process() there is an if (true) {} block, which is completely
unneeded.  Even though compilers will optimize this away, it clutters
the code.

Also removed two #if 0 blocks within the same scope which is truly
only used for really low-level debugging.  The last of these blocks
even includes some #ifdef nesting, making the code somewhat more
unstructured.  It is hard to see any argument why to presever these
blocks s the information they provide won't normally be that useful.
It is aimed at very special corner case debugging.

This patch seems bigger than it really is, due to the needed
re-indenting when removing the if(true) scope.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ssl.c | 439 ++++++++++++++++++++++++++----------------------------
 1 file changed, 208 insertions(+), 231 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c7cf78d..6703fa2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2412,271 +2412,265 @@ tls_process (struct tls_multi *multi,
        * CHANGED with 2.0 -> now we may send tunnel configuration
        * info over the control channel.
        */
-      if (true)
+
+      /* Initial handshake */
+      if (ks->state == S_INITIAL)
 	{
-	  /* Initial handshake */
-	  if (ks->state == S_INITIAL)
+	  buf = reliable_get_buf_output_sequenced (ks->send_reliable);
+	  if (buf)
 	    {
-	      buf = reliable_get_buf_output_sequenced (ks->send_reliable);
-	      if (buf)
-		{
-		  ks->must_negotiate = now + session->opt->handshake_window;
-		  ks->auth_deferred_expire = now + auth_deferred_expire_window (session->opt);
+	      ks->must_negotiate = now + session->opt->handshake_window;
+	      ks->auth_deferred_expire = now + auth_deferred_expire_window (session->opt);
 
-		  /* null buffer */
-		  reliable_mark_active_outgoing (ks->send_reliable, buf, ks->initial_opcode);
-		  INCR_GENERATED;
+	      /* null buffer */
+	      reliable_mark_active_outgoing (ks->send_reliable, buf, ks->initial_opcode);
+	      INCR_GENERATED;
 	      
-		  ks->state = S_PRE_START;
-		  state_change = true;
-		  dmsg (D_TLS_DEBUG, "TLS: Initial Handshake, sid=%s",
-		       session_id_print (&session->session_id, &gc));
+	      ks->state = S_PRE_START;
+	      state_change = true;
+	      dmsg (D_TLS_DEBUG, "TLS: Initial Handshake, sid=%s",
+		    session_id_print (&session->session_id, &gc));
 
 #ifdef ENABLE_MANAGEMENT
-		  if (management && ks->initial_opcode != P_CONTROL_SOFT_RESET_V1)
-		    {
-		      management_set_state (management,
-					    OPENVPN_STATE_WAIT,
-					    NULL,
-                                            NULL,
-                                            NULL,
-                                            NULL,
-                                            NULL);
-		    }
-#endif
+	      if (management && ks->initial_opcode != P_CONTROL_SOFT_RESET_V1)
+		{
+		  management_set_state (management,
+					OPENVPN_STATE_WAIT,
+					NULL,
+					NULL,
+					NULL,
+					NULL,
+					NULL);
 		}
+#endif
 	    }
+	}
 
-	  /* Are we timed out on receive? */
-	  if (now >= ks->must_negotiate)
+      /* Are we timed out on receive? */
+      if (now >= ks->must_negotiate)
+	{
+	  if (ks->state < S_ACTIVE)
 	    {
-	      if (ks->state < S_ACTIVE)
-		{
-		  msg (D_TLS_ERRORS,
-		       "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
-		       session->opt->handshake_window);
-		  goto error;
-		}
-	      else /* assume that ks->state == S_ACTIVE */
-		{
-		  dmsg (D_TLS_DEBUG_MED, "STATE S_NORMAL_OP");
-		  ks->state = S_NORMAL_OP;
-		  ks->must_negotiate = 0;
-		}
+	      msg (D_TLS_ERRORS,
+		   "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
+		   session->opt->handshake_window);
+	      goto error;
 	    }
-
-	  /* Wait for Initial Handshake ACK */
-	  if (ks->state == S_PRE_START && FULL_SYNC)
+	  else /* assume that ks->state == S_ACTIVE */
 	    {
-	      ks->state = S_START;
-	      state_change = true;
-	      dmsg (D_TLS_DEBUG_MED, "STATE S_START");
+	      dmsg (D_TLS_DEBUG_MED, "STATE S_NORMAL_OP");
+	      ks->state = S_NORMAL_OP;
+	      ks->must_negotiate = 0;
 	    }
+	}
+
+      /* Wait for Initial Handshake ACK */
+      if (ks->state == S_PRE_START && FULL_SYNC)
+	{
+	  ks->state = S_START;
+	  state_change = true;
+	  dmsg (D_TLS_DEBUG_MED, "STATE S_START");
+	}
 
-	  /* Wait for ACK */
-	  if (((ks->state == S_GOT_KEY && !session->opt->server) ||
-	       (ks->state == S_SENT_KEY && session->opt->server)))
+      /* Wait for ACK */
+      if (((ks->state == S_GOT_KEY && !session->opt->server) ||
+	   (ks->state == S_SENT_KEY && session->opt->server)))
+	{
+	  if (FULL_SYNC)
 	    {
-	      if (FULL_SYNC)
-		{
-		  ks->established = now;
-		  dmsg (D_TLS_DEBUG_MED, "STATE S_ACTIVE");
-		  if (check_debug_level (D_HANDSHAKE))
-		    print_details (&ks->ks_ssl, "Control Channel:");
-		  state_change = true;
-		  ks->state = S_ACTIVE;
-		  INCR_SUCCESS;
+	      ks->established = now;
+	      dmsg (D_TLS_DEBUG_MED, "STATE S_ACTIVE");
+	      if (check_debug_level (D_HANDSHAKE))
+		print_details (&ks->ks_ssl, "Control Channel:");
+	      state_change = true;
+	      ks->state = S_ACTIVE;
+	      INCR_SUCCESS;
 
-		  /* Set outgoing address for data channel packets */
-		  link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->remote_addr, session->common_name, session->opt->es);
+	      /* Set outgoing address for data channel packets */
+	      link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->remote_addr, session->common_name, session->opt->es);
 
-                  /* Flush any payload packets that were buffered before our state transitioned to S_ACTIVE */
-                  flush_payload_buffer (ks);
+	      /* Flush any payload packets that were buffered before our state transitioned to S_ACTIVE */
+	      flush_payload_buffer (ks);
 
 #ifdef MEASURE_TLS_HANDSHAKE_STATS
-		  show_tls_performance_stats();
+	      show_tls_performance_stats();
 #endif
-		}
 	    }
+	}
 
-	  /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs
-	     for previously received packets) */
-	  if (!to_link->len && reliable_can_send (ks->send_reliable))
-	    {
-	      int opcode;
-	      struct buffer b;
-
-	      buf = reliable_send (ks->send_reliable, &opcode);
-	      ASSERT (buf);
-	      b = *buf;
-	      INCR_SENT;
-
-	      write_control_auth (session, ks, &b, to_link_addr, opcode,
-				  CONTROL_SEND_ACK_MAX, true);
-	      *to_link = b;
-	      active = true;
-	      state_change = true;
-	      dmsg (D_TLS_DEBUG, "Reliable -> TCP/UDP");
-	      break;
-	    }
+      /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_MAX ACKs
+	 for previously received packets) */
+      if (!to_link->len && reliable_can_send (ks->send_reliable))
+	{
+	  int opcode;
+	  struct buffer b;
+
+	  buf = reliable_send (ks->send_reliable, &opcode);
+	  ASSERT (buf);
+	  b = *buf;
+	  INCR_SENT;
+
+	  write_control_auth (session, ks, &b, to_link_addr, opcode,
+			      CONTROL_SEND_ACK_MAX, true);
+	  *to_link = b;
+	  active = true;
+	  state_change = true;
+	  dmsg (D_TLS_DEBUG, "Reliable -> TCP/UDP");
+	  break;
+	}
 
 #ifndef TLS_AGGREGATE_ACK
-	  /* Send 1 or more ACKs (each received control packet gets one ACK) */
-	  if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
-	    {
-	      buf = &ks->ack_write_buf;
-	      ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
-	      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
-				  RELIABLE_ACK_SIZE, false);
-	      *to_link = *buf;
-	      active = true;
-	      state_change = true;
-	      dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
-	      break;
-	    }
+      /* Send 1 or more ACKs (each received control packet gets one ACK) */
+      if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
+	{
+	  buf = &ks->ack_write_buf;
+	  ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
+	  write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
+			      RELIABLE_ACK_SIZE, false);
+	  *to_link = *buf;
+	  active = true;
+	  state_change = true;
+	  dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
+	  break;
+	}
 #endif
 
-	  /* Write incoming ciphertext to TLS object */
-	  buf = reliable_get_buf_sequenced (ks->rec_reliable);
-	  if (buf)
-	    {
-	      int status = 0;
-	      if (buf->len)
-		{
-		  status = key_state_write_ciphertext (&ks->ks_ssl, buf);
-		  if (status == -1)
-		    {
-		      msg (D_TLS_ERRORS,
-			   "TLS Error: Incoming Ciphertext -> TLS object write error");
-		      goto error;
-		    }
-		}
-	      else
-		{
-		  status = 1;
-		}
-	      if (status == 1)
-		{
-		  reliable_mark_deleted (ks->rec_reliable, buf, true);
-		  state_change = true;
-		  dmsg (D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
-		}
-	    }
-
-	  /* Read incoming plaintext from TLS object */
-	  buf = &ks->plaintext_read_buf;
-	  if (!buf->len)
+      /* Write incoming ciphertext to TLS object */
+      buf = reliable_get_buf_sequenced (ks->rec_reliable);
+      if (buf)
+	{
+	  int status = 0;
+	  if (buf->len)
 	    {
-	      int status;
-
-	      ASSERT (buf_init (buf, 0));
-	      status = key_state_read_plaintext (&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
-	      update_time ();
+	      status = key_state_write_ciphertext (&ks->ks_ssl, buf);
 	      if (status == -1)
 		{
-		  msg (D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
+		  msg (D_TLS_ERRORS,
+		       "TLS Error: Incoming Ciphertext -> TLS object write error");
 		  goto error;
 		}
-	      if (status == 1)
-		{
-		  state_change = true;
-		  dmsg (D_TLS_DEBUG, "TLS -> Incoming Plaintext");
-		}
-#if 0 /* show null plaintext reads */
-	      if (!status)
-		msg (M_INFO, "TLS plaintext read -> NULL return");
-#endif
 	    }
-
-	  /* Send Key */
-	  buf = &ks->plaintext_write_buf;
-	  if (!buf->len && ((ks->state == S_START && !session->opt->server) ||
-			    (ks->state == S_GOT_KEY && session->opt->server)))
+	  else
 	    {
-	      if (session->opt->key_method == 1)
-		{
-		  if (!key_method_1_write (buf, session))
-		    goto error;
-		}
-	      else if (session->opt->key_method == 2)
-		{
-		  if (!key_method_2_write (buf, session))
-		    goto error;
-		}
-	      else
-		{
-		  ASSERT (0);
-		}
+	      status = 1;
+	    }
+	  if (status == 1)
+	    {
+	      reliable_mark_deleted (ks->rec_reliable, buf, true);
+	      state_change = true;
+	      dmsg (D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
+	    }
+	}
 
+      /* Read incoming plaintext from TLS object */
+      buf = &ks->plaintext_read_buf;
+      if (!buf->len)
+	{
+	  int status;
+
+	  ASSERT (buf_init (buf, 0));
+	  status = key_state_read_plaintext (&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
+	  update_time ();
+	  if (status == -1)
+	    {
+	      msg (D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
+	      goto error;
+	    }
+	  if (status == 1)
+	    {
 	      state_change = true;
-	      dmsg (D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
-	      ks->state = S_SENT_KEY;
+	      dmsg (D_TLS_DEBUG, "TLS -> Incoming Plaintext");
 	    }
+	}
 
-	  /* Receive Key */
-	  buf = &ks->plaintext_read_buf;
-	  if (buf->len
-	      && ((ks->state == S_SENT_KEY && !session->opt->server)
-		  || (ks->state == S_START && session->opt->server)))
+      /* Send Key */
+      buf = &ks->plaintext_write_buf;
+      if (!buf->len && ((ks->state == S_START && !session->opt->server) ||
+			(ks->state == S_GOT_KEY && session->opt->server)))
+	{
+	  if (session->opt->key_method == 1)
 	    {
-	      if (session->opt->key_method == 1)
-		{
-		  if (!key_method_1_read (buf, session))
-		    goto error;
-		}
-	      else if (session->opt->key_method == 2)
-		{
-		  if (!key_method_2_read (buf, multi, session))
-		    goto error;
-		}
-	      else
-		{
-		  ASSERT (0);
-		}
+	      if (!key_method_1_write (buf, session))
+		goto error;
+	    }
+	  else if (session->opt->key_method == 2)
+	    {
+	      if (!key_method_2_write (buf, session))
+		goto error;
+	    }
+	  else
+	    {
+	      ASSERT (0);
+	    }
+
+	  state_change = true;
+	  dmsg (D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
+	  ks->state = S_SENT_KEY;
+	}
+
+      /* Receive Key */
+      buf = &ks->plaintext_read_buf;
+      if (buf->len
+	  && ((ks->state == S_SENT_KEY && !session->opt->server)
+	      || (ks->state == S_START && session->opt->server)))
+	{
+	  if (session->opt->key_method == 1)
+	    {
+	      if (!key_method_1_read (buf, session))
+		goto error;
+	    }
+	  else if (session->opt->key_method == 2)
+	    {
+	      if (!key_method_2_read (buf, multi, session))
+		goto error;
+	    }
+	  else
+	    {
+	      ASSERT (0);
+	    }
 
+	  state_change = true;
+	  dmsg (D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
+	  ks->state = S_GOT_KEY;
+	}
+
+      /* Write outgoing plaintext to TLS object */
+      buf = &ks->plaintext_write_buf;
+      if (buf->len)
+	{
+	  int status = key_state_write_plaintext (&ks->ks_ssl, buf);
+	  if (status == -1)
+	    {
+	      msg (D_TLS_ERRORS,
+		   "TLS ERROR: Outgoing Plaintext -> TLS object write error");
+	      goto error;
+	    }
+	  if (status == 1)
+	    {
 	      state_change = true;
-	      dmsg (D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
-	      ks->state = S_GOT_KEY;
+	      dmsg (D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
 	    }
+	}
 
-	  /* Write outgoing plaintext to TLS object */
-	  buf = &ks->plaintext_write_buf;
-	  if (buf->len)
+      /* Outgoing Ciphertext to reliable buffer */
+      if (ks->state >= S_START)
+	{
+	  buf = reliable_get_buf_output_sequenced (ks->send_reliable);
+	  if (buf)
 	    {
-	      int status = key_state_write_plaintext (&ks->ks_ssl, buf);
+	      int status = key_state_read_ciphertext (&ks->ks_ssl, buf, PAYLOAD_SIZE_DYNAMIC (&multi->opt.frame));
 	      if (status == -1)
 		{
 		  msg (D_TLS_ERRORS,
-		       "TLS ERROR: Outgoing Plaintext -> TLS object write error");
+		       "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
 		  goto error;
 		}
 	      if (status == 1)
 		{
+		  reliable_mark_active_outgoing (ks->send_reliable, buf, P_CONTROL_V1);
+		  INCR_GENERATED;
 		  state_change = true;
-		  dmsg (D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
-		}
-	    }
-
-	  /* Outgoing Ciphertext to reliable buffer */
-	  if (ks->state >= S_START)
-	    {
-	      buf = reliable_get_buf_output_sequenced (ks->send_reliable);
-	      if (buf)
-		{
-		  int status = key_state_read_ciphertext (&ks->ks_ssl, buf, PAYLOAD_SIZE_DYNAMIC (&multi->opt.frame));
-		  if (status == -1)
-		    {
-		      msg (D_TLS_ERRORS,
-			   "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
-		      goto error;
-		    }
-		  if (status == 1)
-		    {
-		      reliable_mark_active_outgoing (ks->send_reliable, buf, P_CONTROL_V1);
-		      INCR_GENERATED;
-		      state_change = true;
-		      dmsg (D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
-		    }
+		  dmsg (D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
 		}
 	    }
 	}
@@ -3018,23 +3012,6 @@ tls_pre_decrypt (struct tls_multi *multi,
 		  gc_free (&gc);
 		  return ret;
 		}
-#if 0 /* keys out of sync? */
-	      else
-		{
-		  dmsg (D_TLS_ERRORS, "TLS_PRE_DECRYPT: [%d] dken=%d rkid=%d lkid=%d auth=%d def=%d match=%d",
-			i,
-			DECRYPT_KEY_ENABLED (multi, ks),
-			key_id,
-			ks->key_id,
-			ks->authenticated,
-#ifdef ENABLE_DEF_AUTH
-			ks->auth_deferred,
-#else
-			-1,
-#endif
-			link_socket_actual_match (from, &ks->remote_addr));
-		}
-#endif
 	    }
 
 	  msg (D_TLS_ERRORS,
-- 
1.8.3.1


