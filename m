References: <1477579059-9596-1-git-send-email-davids@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <5e4c60d0-3eaa-1280-bffb-0edb290f922f@...1435...>
Date: Thu, 27 Oct 2016 16:50:59 +0200
MIME-Version: 1.0
In-Reply-To: <1477579059-9596-1-git-send-email-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aQWtVlt4JCbe2rcdSSlH8KOwvsgJ6AVbw"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove NOP code sections in
 ssl.c:tls_process()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--aQWtVlt4JCbe2rcdSSlH8KOwvsgJ6AVbw
Content-Type: multipart/mixed; boundary="a2MxBdPIS32blobckQscNCAWivWwgu3CN";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5e4c60d0-3eaa-1280-bffb-0edb290f922f@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove NOP code sections in
	ssl.c:tls_process()
References: <1477579059-9596-1-git-send-email-davids@...515...>
In-Reply-To: <1477579059-9596-1-git-send-email-davids@...515...>

--a2MxBdPIS32blobckQscNCAWivWwgu3CN
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 27-10-16 16:37, David Sommerseth wrote:
> In tls_process() there is an if (true) {} block, which is completely
> unneeded.  Even though compilers will optimize this away, it clutters
> the code.
>=20
> Also removed two #if 0 blocks within the same scope which is truly
> only used for really low-level debugging.  The last of these blocks
> even includes some #ifdef nesting, making the code somewhat more
> unstructured.  It is hard to see any argument why to presever these
> blocks s the information they provide won't normally be that useful.
> It is aimed at very special corner case debugging.
>=20
> This patch seems bigger than it really is, due to the needed
> re-indenting when removing the if(true) scope.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/ssl.c | 439 ++++++++++++++++++++++++++----------------------=
------
>  1 file changed, 208 insertions(+), 231 deletions(-)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index c7cf78d..6703fa2 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2412,271 +2412,265 @@ tls_process (struct tls_multi *multi,
>         * CHANGED with 2.0 -> now we may send tunnel configuration
>         * info over the control channel.
>         */
> -      if (true)
> +
> +      /* Initial handshake */
> +      if (ks->state =3D=3D S_INITIAL)
>  	{
> -	  /* Initial handshake */
> -	  if (ks->state =3D=3D S_INITIAL)
> +	  buf =3D reliable_get_buf_output_sequenced (ks->send_reliable);
> +	  if (buf)
>  	    {
> -	      buf =3D reliable_get_buf_output_sequenced (ks->send_reliable);
> -	      if (buf)
> -		{
> -		  ks->must_negotiate =3D now + session->opt->handshake_window;
> -		  ks->auth_deferred_expire =3D now + auth_deferred_expire_window (sess=
ion->opt);
> +	      ks->must_negotiate =3D now + session->opt->handshake_window;
> +	      ks->auth_deferred_expire =3D now + auth_deferred_expire_window (s=
ession->opt);
>=20=20
> -		  /* null buffer */
> -		  reliable_mark_active_outgoing (ks->send_reliable, buf, ks->initial_o=
pcode);
> -		  INCR_GENERATED;
> +	      /* null buffer */
> +	      reliable_mark_active_outgoing (ks->send_reliable, buf, ks->initia=
l_opcode);
> +	      INCR_GENERATED;
>=20=20=09=20=20=20=20=20=20
> -		  ks->state =3D S_PRE_START;
> -		  state_change =3D true;
> -		  dmsg (D_TLS_DEBUG, "TLS: Initial Handshake, sid=3D%s",
> -		       session_id_print (&session->session_id, &gc));
> +	      ks->state =3D S_PRE_START;
> +	      state_change =3D true;
> +	      dmsg (D_TLS_DEBUG, "TLS: Initial Handshake, sid=3D%s",
> +		    session_id_print (&session->session_id, &gc));
>=20=20
>  #ifdef ENABLE_MANAGEMENT
> -		  if (management && ks->initial_opcode !=3D P_CONTROL_SOFT_RESET_V1)
> -		    {
> -		      management_set_state (management,
> -					    OPENVPN_STATE_WAIT,
> -					    NULL,
> -                                            NULL,
> -                                            NULL,
> -                                            NULL,
> -                                            NULL);
> -		    }
> -#endif
> +	      if (management && ks->initial_opcode !=3D P_CONTROL_SOFT_RESET_V1)
> +		{
> +		  management_set_state (management,
> +					OPENVPN_STATE_WAIT,
> +					NULL,
> +					NULL,
> +					NULL,
> +					NULL,
> +					NULL);
>  		}
> +#endif
>  	    }
> +	}
>=20=20
> -	  /* Are we timed out on receive? */
> -	  if (now >=3D ks->must_negotiate)
> +      /* Are we timed out on receive? */
> +      if (now >=3D ks->must_negotiate)
> +	{
> +	  if (ks->state < S_ACTIVE)
>  	    {
> -	      if (ks->state < S_ACTIVE)
> -		{
> -		  msg (D_TLS_ERRORS,
> -		       "TLS Error: TLS key negotiation failed to occur within %d secon=
ds (check your network connectivity)",
> -		       session->opt->handshake_window);
> -		  goto error;
> -		}
> -	      else /* assume that ks->state =3D=3D S_ACTIVE */
> -		{
> -		  dmsg (D_TLS_DEBUG_MED, "STATE S_NORMAL_OP");
> -		  ks->state =3D S_NORMAL_OP;
> -		  ks->must_negotiate =3D 0;
> -		}
> +	      msg (D_TLS_ERRORS,
> +		   "TLS Error: TLS key negotiation failed to occur within %d seconds (=
check your network connectivity)",
> +		   session->opt->handshake_window);
> +	      goto error;
>  	    }
> -
> -	  /* Wait for Initial Handshake ACK */
> -	  if (ks->state =3D=3D S_PRE_START && FULL_SYNC)
> +	  else /* assume that ks->state =3D=3D S_ACTIVE */
>  	    {
> -	      ks->state =3D S_START;
> -	      state_change =3D true;
> -	      dmsg (D_TLS_DEBUG_MED, "STATE S_START");
> +	      dmsg (D_TLS_DEBUG_MED, "STATE S_NORMAL_OP");
> +	      ks->state =3D S_NORMAL_OP;
> +	      ks->must_negotiate =3D 0;
>  	    }
> +	}
> +
> +      /* Wait for Initial Handshake ACK */
> +      if (ks->state =3D=3D S_PRE_START && FULL_SYNC)
> +	{
> +	  ks->state =3D S_START;
> +	  state_change =3D true;
> +	  dmsg (D_TLS_DEBUG_MED, "STATE S_START");
> +	}
>=20=20
> -	  /* Wait for ACK */
> -	  if (((ks->state =3D=3D S_GOT_KEY && !session->opt->server) ||
> -	       (ks->state =3D=3D S_SENT_KEY && session->opt->server)))
> +      /* Wait for ACK */
> +      if (((ks->state =3D=3D S_GOT_KEY && !session->opt->server) ||
> +	   (ks->state =3D=3D S_SENT_KEY && session->opt->server)))
> +	{
> +	  if (FULL_SYNC)
>  	    {
> -	      if (FULL_SYNC)
> -		{
> -		  ks->established =3D now;
> -		  dmsg (D_TLS_DEBUG_MED, "STATE S_ACTIVE");
> -		  if (check_debug_level (D_HANDSHAKE))
> -		    print_details (&ks->ks_ssl, "Control Channel:");
> -		  state_change =3D true;
> -		  ks->state =3D S_ACTIVE;
> -		  INCR_SUCCESS;
> +	      ks->established =3D now;
> +	      dmsg (D_TLS_DEBUG_MED, "STATE S_ACTIVE");
> +	      if (check_debug_level (D_HANDSHAKE))
> +		print_details (&ks->ks_ssl, "Control Channel:");
> +	      state_change =3D true;
> +	      ks->state =3D S_ACTIVE;
> +	      INCR_SUCCESS;
>=20=20
> -		  /* Set outgoing address for data channel packets */
> -		  link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->remot=
e_addr, session->common_name, session->opt->es);
> +	      /* Set outgoing address for data channel packets */
> +	      link_socket_set_outgoing_addr (NULL, to_link_socket_info, &ks->re=
mote_addr, session->common_name, session->opt->es);
>=20=20
> -                  /* Flush any payload packets that were buffered before=
 our state transitioned to S_ACTIVE */
> -                  flush_payload_buffer (ks);
> +	      /* Flush any payload packets that were buffered before our state =
transitioned to S_ACTIVE */
> +	      flush_payload_buffer (ks);
>=20=20
>  #ifdef MEASURE_TLS_HANDSHAKE_STATS
> -		  show_tls_performance_stats();
> +	      show_tls_performance_stats();
>  #endif
> -		}
>  	    }
> +	}
>=20=20
> -	  /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_ACK_M=
AX ACKs
> -	     for previously received packets) */
> -	  if (!to_link->len && reliable_can_send (ks->send_reliable))
> -	    {
> -	      int opcode;
> -	      struct buffer b;
> -
> -	      buf =3D reliable_send (ks->send_reliable, &opcode);
> -	      ASSERT (buf);
> -	      b =3D *buf;
> -	      INCR_SENT;
> -
> -	      write_control_auth (session, ks, &b, to_link_addr, opcode,
> -				  CONTROL_SEND_ACK_MAX, true);
> -	      *to_link =3D b;
> -	      active =3D true;
> -	      state_change =3D true;
> -	      dmsg (D_TLS_DEBUG, "Reliable -> TCP/UDP");
> -	      break;
> -	    }
> +      /* Reliable buffer to outgoing TCP/UDP (send up to CONTROL_SEND_AC=
K_MAX ACKs
> +	 for previously received packets) */
> +      if (!to_link->len && reliable_can_send (ks->send_reliable))
> +	{
> +	  int opcode;
> +	  struct buffer b;
> +
> +	  buf =3D reliable_send (ks->send_reliable, &opcode);
> +	  ASSERT (buf);
> +	  b =3D *buf;
> +	  INCR_SENT;
> +
> +	  write_control_auth (session, ks, &b, to_link_addr, opcode,
> +			      CONTROL_SEND_ACK_MAX, true);
> +	  *to_link =3D b;
> +	  active =3D true;
> +	  state_change =3D true;
> +	  dmsg (D_TLS_DEBUG, "Reliable -> TCP/UDP");
> +	  break;
> +	}
>=20=20
>  #ifndef TLS_AGGREGATE_ACK
> -	  /* Send 1 or more ACKs (each received control packet gets one ACK) */
> -	  if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
> -	    {
> -	      buf =3D &ks->ack_write_buf;
> -	      ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
> -	      write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
> -				  RELIABLE_ACK_SIZE, false);
> -	      *to_link =3D *buf;
> -	      active =3D true;
> -	      state_change =3D true;
> -	      dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
> -	      break;
> -	    }
> +      /* Send 1 or more ACKs (each received control packet gets one ACK)=
 */
> +      if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
> +	{
> +	  buf =3D &ks->ack_write_buf;
> +	  ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
> +	  write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
> +			      RELIABLE_ACK_SIZE, false);
> +	  *to_link =3D *buf;
> +	  active =3D true;
> +	  state_change =3D true;
> +	  dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
> +	  break;
> +	}
>  #endif
>=20=20
> -	  /* Write incoming ciphertext to TLS object */
> -	  buf =3D reliable_get_buf_sequenced (ks->rec_reliable);
> -	  if (buf)
> -	    {
> -	      int status =3D 0;
> -	      if (buf->len)
> -		{
> -		  status =3D key_state_write_ciphertext (&ks->ks_ssl, buf);
> -		  if (status =3D=3D -1)
> -		    {
> -		      msg (D_TLS_ERRORS,
> -			   "TLS Error: Incoming Ciphertext -> TLS object write error");
> -		      goto error;
> -		    }
> -		}
> -	      else
> -		{
> -		  status =3D 1;
> -		}
> -	      if (status =3D=3D 1)
> -		{
> -		  reliable_mark_deleted (ks->rec_reliable, buf, true);
> -		  state_change =3D true;
> -		  dmsg (D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
> -		}
> -	    }
> -
> -	  /* Read incoming plaintext from TLS object */
> -	  buf =3D &ks->plaintext_read_buf;
> -	  if (!buf->len)
> +      /* Write incoming ciphertext to TLS object */
> +      buf =3D reliable_get_buf_sequenced (ks->rec_reliable);
> +      if (buf)
> +	{
> +	  int status =3D 0;
> +	  if (buf->len)
>  	    {
> -	      int status;
> -
> -	      ASSERT (buf_init (buf, 0));
> -	      status =3D key_state_read_plaintext (&ks->ks_ssl, buf, TLS_CHANNE=
L_BUF_SIZE);
> -	      update_time ();
> +	      status =3D key_state_write_ciphertext (&ks->ks_ssl, buf);
>  	      if (status =3D=3D -1)
>  		{
> -		  msg (D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read=
 error");
> +		  msg (D_TLS_ERRORS,
> +		       "TLS Error: Incoming Ciphertext -> TLS object write error");
>  		  goto error;
>  		}
> -	      if (status =3D=3D 1)
> -		{
> -		  state_change =3D true;
> -		  dmsg (D_TLS_DEBUG, "TLS -> Incoming Plaintext");
> -		}
> -#if 0 /* show null plaintext reads */
> -	      if (!status)
> -		msg (M_INFO, "TLS plaintext read -> NULL return");
> -#endif
>  	    }
> -
> -	  /* Send Key */
> -	  buf =3D &ks->plaintext_write_buf;
> -	  if (!buf->len && ((ks->state =3D=3D S_START && !session->opt->server)=
 ||
> -			    (ks->state =3D=3D S_GOT_KEY && session->opt->server)))
> +	  else
>  	    {
> -	      if (session->opt->key_method =3D=3D 1)
> -		{
> -		  if (!key_method_1_write (buf, session))
> -		    goto error;
> -		}
> -	      else if (session->opt->key_method =3D=3D 2)
> -		{
> -		  if (!key_method_2_write (buf, session))
> -		    goto error;
> -		}
> -	      else
> -		{
> -		  ASSERT (0);
> -		}
> +	      status =3D 1;
> +	    }
> +	  if (status =3D=3D 1)
> +	    {
> +	      reliable_mark_deleted (ks->rec_reliable, buf, true);
> +	      state_change =3D true;
> +	      dmsg (D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
> +	    }
> +	}
>=20=20
> +      /* Read incoming plaintext from TLS object */
> +      buf =3D &ks->plaintext_read_buf;
> +      if (!buf->len)
> +	{
> +	  int status;
> +
> +	  ASSERT (buf_init (buf, 0));
> +	  status =3D key_state_read_plaintext (&ks->ks_ssl, buf, TLS_CHANNEL_BU=
F_SIZE);
> +	  update_time ();
> +	  if (status =3D=3D -1)
> +	    {
> +	      msg (D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext r=
ead error");
> +	      goto error;
> +	    }
> +	  if (status =3D=3D 1)
> +	    {
>  	      state_change =3D true;
> -	      dmsg (D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
> -	      ks->state =3D S_SENT_KEY;
> +	      dmsg (D_TLS_DEBUG, "TLS -> Incoming Plaintext");
>  	    }
> +	}
>=20=20
> -	  /* Receive Key */
> -	  buf =3D &ks->plaintext_read_buf;
> -	  if (buf->len
> -	      && ((ks->state =3D=3D S_SENT_KEY && !session->opt->server)
> -		  || (ks->state =3D=3D S_START && session->opt->server)))
> +      /* Send Key */
> +      buf =3D &ks->plaintext_write_buf;
> +      if (!buf->len && ((ks->state =3D=3D S_START && !session->opt->serv=
er) ||
> +			(ks->state =3D=3D S_GOT_KEY && session->opt->server)))
> +	{
> +	  if (session->opt->key_method =3D=3D 1)
>  	    {
> -	      if (session->opt->key_method =3D=3D 1)
> -		{
> -		  if (!key_method_1_read (buf, session))
> -		    goto error;
> -		}
> -	      else if (session->opt->key_method =3D=3D 2)
> -		{
> -		  if (!key_method_2_read (buf, multi, session))
> -		    goto error;
> -		}
> -	      else
> -		{
> -		  ASSERT (0);
> -		}
> +	      if (!key_method_1_write (buf, session))
> +		goto error;
> +	    }
> +	  else if (session->opt->key_method =3D=3D 2)
> +	    {
> +	      if (!key_method_2_write (buf, session))
> +		goto error;
> +	    }
> +	  else
> +	    {
> +	      ASSERT (0);
> +	    }
> +
> +	  state_change =3D true;
> +	  dmsg (D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
> +	  ks->state =3D S_SENT_KEY;
> +	}
> +
> +      /* Receive Key */
> +      buf =3D &ks->plaintext_read_buf;
> +      if (buf->len
> +	  && ((ks->state =3D=3D S_SENT_KEY && !session->opt->server)
> +	      || (ks->state =3D=3D S_START && session->opt->server)))
> +	{
> +	  if (session->opt->key_method =3D=3D 1)
> +	    {
> +	      if (!key_method_1_read (buf, session))
> +		goto error;
> +	    }
> +	  else if (session->opt->key_method =3D=3D 2)
> +	    {
> +	      if (!key_method_2_read (buf, multi, session))
> +		goto error;
> +	    }
> +	  else
> +	    {
> +	      ASSERT (0);
> +	    }
>=20=20
> +	  state_change =3D true;
> +	  dmsg (D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
> +	  ks->state =3D S_GOT_KEY;
> +	}
> +
> +      /* Write outgoing plaintext to TLS object */
> +      buf =3D &ks->plaintext_write_buf;
> +      if (buf->len)
> +	{
> +	  int status =3D key_state_write_plaintext (&ks->ks_ssl, buf);
> +	  if (status =3D=3D -1)
> +	    {
> +	      msg (D_TLS_ERRORS,
> +		   "TLS ERROR: Outgoing Plaintext -> TLS object write error");
> +	      goto error;
> +	    }
> +	  if (status =3D=3D 1)
> +	    {
>  	      state_change =3D true;
> -	      dmsg (D_TLS_DEBUG_MED, "STATE S_GOT_KEY");
> -	      ks->state =3D S_GOT_KEY;
> +	      dmsg (D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
>  	    }
> +	}
>=20=20
> -	  /* Write outgoing plaintext to TLS object */
> -	  buf =3D &ks->plaintext_write_buf;
> -	  if (buf->len)
> +      /* Outgoing Ciphertext to reliable buffer */
> +      if (ks->state >=3D S_START)
> +	{
> +	  buf =3D reliable_get_buf_output_sequenced (ks->send_reliable);
> +	  if (buf)
>  	    {
> -	      int status =3D key_state_write_plaintext (&ks->ks_ssl, buf);
> +	      int status =3D key_state_read_ciphertext (&ks->ks_ssl, buf, PAYLO=
AD_SIZE_DYNAMIC (&multi->opt.frame));
>  	      if (status =3D=3D -1)
>  		{
>  		  msg (D_TLS_ERRORS,
> -		       "TLS ERROR: Outgoing Plaintext -> TLS object write error");
> +		       "TLS Error: Ciphertext -> reliable TCP/UDP transport read error=
");
>  		  goto error;
>  		}
>  	      if (status =3D=3D 1)
>  		{
> +		  reliable_mark_active_outgoing (ks->send_reliable, buf, P_CONTROL_V1);
> +		  INCR_GENERATED;
>  		  state_change =3D true;
> -		  dmsg (D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
> -		}
> -	    }
> -
> -	  /* Outgoing Ciphertext to reliable buffer */
> -	  if (ks->state >=3D S_START)
> -	    {
> -	      buf =3D reliable_get_buf_output_sequenced (ks->send_reliable);
> -	      if (buf)
> -		{
> -		  int status =3D key_state_read_ciphertext (&ks->ks_ssl, buf, PAYLOAD_=
SIZE_DYNAMIC (&multi->opt.frame));
> -		  if (status =3D=3D -1)
> -		    {
> -		      msg (D_TLS_ERRORS,
> -			   "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
> -		      goto error;
> -		    }
> -		  if (status =3D=3D 1)
> -		    {
> -		      reliable_mark_active_outgoing (ks->send_reliable, buf, P_CONTROL=
_V1);
> -		      INCR_GENERATED;
> -		      state_change =3D true;
> -		      dmsg (D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
> -		    }
> +		  dmsg (D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
>  		}
>  	    }
>  	}
> @@ -3018,23 +3012,6 @@ tls_pre_decrypt (struct tls_multi *multi,
>  		  gc_free (&gc);
>  		  return ret;
>  		}
> -#if 0 /* keys out of sync? */
> -	      else
> -		{
> -		  dmsg (D_TLS_ERRORS, "TLS_PRE_DECRYPT: [%d] dken=3D%d rkid=3D%d lkid=
=3D%d auth=3D%d def=3D%d match=3D%d",
> -			i,
> -			DECRYPT_KEY_ENABLED (multi, ks),
> -			key_id,
> -			ks->key_id,
> -			ks->authenticated,
> -#ifdef ENABLE_DEF_AUTH
> -			ks->auth_deferred,
> -#else
> -			-1,
> -#endif
> -			link_socket_actual_match (from, &ks->remote_addr));
> -		}
> -#endif
>  	    }
>=20=20
>  	  msg (D_TLS_ERRORS,
>=20

No functional change, removes dead bitrotted code.  ACK.

Easy to see when looking at the git diff --ignore-all-space output:

--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2474,8 +2474,7 @@ tls_process (struct tls_multi *multi,
        * CHANGED with 2.0 -> now we may send tunnel configuration
        * info over the control channel.
        */
-      if (true)
-       {
+
       /* Initial handshake */
       if (ks->state =3D=3D S_INITIAL)
        {
@@ -2644,10 +2643,6 @@ tls_process (struct tls_multi *multi,
              state_change =3D true;
              dmsg (D_TLS_DEBUG, "TLS -> Incoming Plaintext");
            }
-#if 0 /* show null plaintext reads */
-             if (!status)
-               msg (M_INFO, "TLS plaintext read -> NULL return");
-#endif
        }

       /* Send Key */
@@ -2742,7 +2737,6 @@ tls_process (struct tls_multi *multi,
            }
        }
     }
-    }
   while (state_change);

   update_time ();
@@ -3080,23 +3074,6 @@ tls_pre_decrypt (struct tls_multi *multi,
                  gc_free (&gc);
                  return ret;
                }
-#if 0 /* keys out of sync? */
-             else
-               {
-                 dmsg (D_TLS_ERRORS, "TLS_PRE_DECRYPT: [%d] dken=3D%d
rkid=3D%d lkid=3D%d auth=3D%d def=3D%d match=3D%d",
-                       i,
-                       DECRYPT_KEY_ENABLED (multi, ks),
-                       key_id,
-                       ks->key_id,
-                       ks->authenticated,
-#ifdef ENABLE_DEF_AUTH
-                       ks->auth_deferred,
-#else
-                       -1,
-#endif
-                       link_socket_actual_match (from, &ks->remote_addr));
-               }
-#endif
            }

          msg (D_TLS_ERRORS,


-Steffan


--a2MxBdPIS32blobckQscNCAWivWwgu3CN--

--aQWtVlt4JCbe2rcdSSlH8KOwvsgJ6AVbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEhRTAAoJEEEwndWOY1w5GMoIAIFDxrZOaXPXaqkBxjmWLzZ9
2EBhc8hVTTLZZEu+fEgUrpzF53sKpg/nw38q/iu4efzI0ipsTcq930t3FJB8QKyO
aLEd19l8BBW9BlZtDQOF1wBB2LoFRM2OzbilgfcrtQO+U22FC10LsFjAJ5xlVi43
3ltN2s/rvkXx/VP7zWBN+4MTo+hGjN7jdtfdC9Bspn71Xyk7A6n4L03fQupP4Dvp
aiZ/2nqbjL5sKCAv+qvv5gGSNBY6tY8I18mF+E6WHWRL693qK4eBIn69WLAX5w7N
mBt7G4/TMkNyQvdCqnTTUpX0CcWtyII7c7l+738z3qoT6bIU8ah1I7hiOS2VlSc=
=q7AK
-----END PGP SIGNATURE-----

--aQWtVlt4JCbe2rcdSSlH8KOwvsgJ6AVbw--

