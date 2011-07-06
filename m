From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 6 Jul 2011 08:33:39 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901269D8E4DA@...1436...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
	<1308725496-10620-4-git-send-email-dejong@...1435...>
	<4E1353AD.5080906@...1114...>
In-Reply-To: <4E1353AD.5080906@...1114...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 3/8] Added control channel crypto docs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: dinsdag 5 juli 2011 20:11
>=20
> More comments in between ... look carefully.
>=20
Thanks, I've answered your comments inline too :)

> [...snip...]
> > + * @subsection key_generation_method_2 Key method 2
> > + *
> > + * -# The client generates random material in the following amounts:
> > + *    - Pre-master secret: 48 bytes
> > + *    - Client's PRF seed for master secret: 32 bytes
> > + *    - Client's PRF seed for %key expansion: 32 bytes
> > + * -# The client sends its share of random material to the server.
> > + * -# The server generates random material in the following amounts:
> > + *    - Server's PRF seed for master secret: 32 bytes
> > + *    - Server's PRF seed for %key expansion: 32 bytes
> > + * -# The server computes the %key expansion using its own and the
> > + *    client's random material.
> > + * -# The server sends its share of random material to the client.
> > + * -# The client computes the %key expansion using its own and the
> > + *    server's random material.
> > + *
> > + * %Key method 2 %key expansion is performed by the \c
> > + * generate_key_expansion() function.  Please refer to its source
> code for
> > + * details of the %key expansion process.
>=20
> My memory is a bit rusty ... but isn't this part of the standard KEX
> process in SSL/TLS?
>=20

Yes, but this one is used for setting up the data channel keys, not the con=
trol channel keys. I believe it's based on OpenSSL's PRF.

> > +/**
> > + * Insert a plaintext buffer into the TLS module.
> > + *
> > + * After successfully processing the data, the data in \a buf is
> zeroized,
>=20
> I believe "zeroed" is a better expression ... found more places.
>=20

Hmm, I thought zeroisation was the common term in the crypto world (http://=
en.wikipedia.org/wiki/Zeroisation).

> [...snip...]
> > + * This function cleans up a \c key_state structure.  It frees the
> > + * associated SSL-BIO, and the structures allocated for the \link
> reliable
> > + * Reliability Layer\endlink.
> > + *
> > + * @param ks           - A pointer to the \c key_state structure to
> be
> > + *                       cleaned up.
> > + * @param clear        - Whether the memory allocated for the \a ks
> object
> > + *                       should be overwritten with 0s.
>=20
> Wouldn't it be better to say "... ks object should be zeroed" ?
>=20

Cleared/zeroised would probably be better still, but I think this still mak=
es matters pretty clear.=20

>=20
> [...snip...]
> > + * @param clear        - Whether the memory allocated for the \a
> session
> > + *                       object should be overwritten with 0s.
> > + */
> >  static void
> >  tls_session_free (struct tls_session *session, bool clear)
>=20
> Same comment as above
>=20
> > -/*
> > - * OpenVPN Protocol, taken from ssl.h in OpenVPN source code.
> > - *
> > - * TCP/UDP Packet:  This represents the top-level encapsulation.
> > - *
> > - * TCP/UDP packet format:
> > - *
> > - *   Packet length (16 bits, unsigned) -- TCP only, always sent as
> > - *       plaintext.  Since TCP is a stream protocol, the packet
> > - *       length words define the packetization of the stream.
> > - *
> > - *   Packet opcode/key_id (8 bits) -- TLS only, not used in
> > - *       pre-shared secret mode.
> > - *            packet message type, a P_* constant (high 5 bits)
> > - *            key_id (low 3 bits, see key_id in struct tls_session
> > - *              below for comment).  The key_id refers to an
> > - *              already negotiated TLS session.  OpenVPN seamlessly
> > - *              renegotiates the TLS session by using a new key_id
> > - *              for the new session.  Overlap (controlled by
> > - *              user definable parameters) between old and new TLS
> > - *              sessions is allowed, providing a seamless transition
> > - *              during tunnel operation.
> > - *
> > - *   Payload (n bytes), which may be a P_CONTROL, P_ACK, or P_DATA
> > - *       message.
> > - * Message types:
> > - *
> > - *  P_CONTROL_HARD_RESET_CLIENT_V1 -- Key method 1, initial key from
> > - *    client, forget previous state.
> > - *
> > - *  P_CONTROL_HARD_RESET_SERVER_V1 -- Key method 2, initial key
> > - *    from server, forget previous state.
> > - *
> > - *  P_CONTROL_SOFT_RESET_V1 -- New key, with a graceful transition
> > - *    from old to new key in the sense that a transition window
> > - *    exists where both the old or new key_id can be used.  OpenVPN
> > - *    uses two different forms of key_id.  The first form is 64 bits
> > - *    and is used for all P_CONTROL messages.  P_DATA messages on
> the
> > - *    other hand use a shortened key_id of 3 bits for efficiency
> > - *    reasons since the vast majority of OpenVPN packets in an
> > - *    active tunnel will be P_DATA messages.  The 64 bit form
> > - *    is referred to as a session_id, while the 3 bit form is
> > - *    referred to as a key_id.
> > - *
> > - *  P_CONTROL_V1 -- Control channel packet (usually TLS ciphertext).
> > - *
> > - *  P_ACK_V1 -- Acknowledgement for P_CONTROL packets received.
> > - *
> > - *  P_DATA_V1 -- Data channel packet containing actual tunnel data
> > - *    ciphertext.
> > - *
> > - *  P_CONTROL_HARD_RESET_CLIENT_V2 -- Key method 2, initial key from
> > - *   client, forget previous state.
> > - *
> > - *  P_CONTROL_HARD_RESET_SERVER_V2 -- Key method 2, initial key from
> > - *   server, forget previous state.
> > - *
> > - * P_CONTROL* and P_ACK Payload:  The P_CONTROL message type
> > - * indicates a TLS ciphertext packet which has been encapsulated
> > - * inside of a reliability layer.  The reliability layer is
> > - * implemented as a straightforward ACK and retransmit model.
>=20
> Is this documented somewhere else?  The same goes for the following
> message
> types.  Seems to be some details here which is missing in the previous
> description of the key methods.
>=20
>=20
> > - * P_CONTROL message format:
> > - *
> > - *   local session_id (random 64 bit value to identify TLS session).
> > - *   HMAC signature of entire encapsulation header for integrity
> > - *       check if --tls-auth is specified (usually 16 or 20 bytes).
> > - *   packet-id for replay protection (4 or 8 bytes, includes
> > - *       sequence number and optional time_t timestamp).
> > - *   P_ACK packet_id array length (1 byte).
> > - *   P_ACK packet-id array (if length > 0).
> > - *   P_ACK remote session_id (if length > 0).
> > - *   message packet-id (4 bytes).
> > - *   TLS payload ciphertext (n bytes) (only for P_CONTROL).
> > - *
> > - * Once the TLS session has been initialized and authenticated,
> > - * the TLS channel is used to exchange random key material for
> > - * bidirectional cipher and HMAC keys which will be
> > - * used to secure actual tunnel packets.  OpenVPN currently
> > - * implements two key methods.  Key method 1 directly
> > - * derives keys using random bits obtained from the RAND_bytes
> > - * OpenSSL function.  Key method 2 mixes random key material
> > - * from both sides of the connection using the TLS PRF mixing
> > - * function.  Key method 2 is the preferred method and is the
> default
> > - * for OpenVPN 2.0.
> > - *
> > - * TLS plaintext content:
> > - *
> > - * TLS plaintext packet (if key_method =3D=3D 1):
> > - *
> > - *   Cipher key length in bytes (1 byte).
> > - *   Cipher key (n bytes).
> > - *   HMAC key length in bytes (1 byte).
> > - *   HMAC key (n bytes).
> > - *   Options string (n bytes, null terminated, client/server options
> > - *       string should match).
> > - *
> > - * TLS plaintext packet (if key_method =3D=3D 2):
> > - *
> > - *   Literal 0 (4 bytes).
> > - *   key_method type (1 byte).
> > - *   key_source structure (pre_master only defined for client ->
> > - *       server).
> > - *   options_string_length, including null (2 bytes).
> > - *   Options string (n bytes, null terminated, client/server options
> > - *       string must match).
> > - *   [The username/password data below is optional, record can end
> > - *       at this point.]
> > - *   username_string_length, including null (2 bytes).
> > - *   Username string (n bytes, null terminated).
> > - *   password_string_length, including null (2 bytes).
> > - *   Password string (n bytes, null terminated).
> > - *
> > - * The P_DATA payload represents encrypted, encapsulated tunnel
> > - * packets which tend to be either IP packets or Ethernet frames.
> > - * This is essentially the "payload" of the VPN.
> > - *
> > - * P_DATA message content:
> > - *   HMAC of ciphertext IV + ciphertext (if not disabled by
> > - *       --auth none).
> > - *   Ciphertext IV (size is cipher-dependent, if not disabled by
> > - *       --no-iv).
> > - *   Tunnel packet ciphertext.
> > - *
> > - * P_DATA plaintext
> > - *   packet_id (4 or 8 bytes, if not disabled by --no-replay).
> > - *       In SSL/TLS mode, 4 bytes are used because the
> implementation
> > - *       can force a TLS renegotation before 2^32 packets are sent.
> > - *       In pre-shared key mode, 8 bytes are used (sequence number
> > - *       and time_t value) to allow long-term key usage without
> > - *       packet_id collisions.
> > - *   User plaintext (n bytes).
> > - *
> > - * Notes:
> > - *   (1) ACK messages can be encoded in either the dedicated
> > - *       P_ACK record or they can be prepended to a P_CONTROL
> message.
> > - *   (2) P_DATA and P_CONTROL/P_ACK use independent packet-id
> > - *       sequences because P_DATA is an unreliable channel while
> > - *       P_CONTROL/P_ACK is a reliable channel.  Each use their
> > - *       own independent HMAC keys.
> > - *   (3) Note that when --tls-auth is used, all message types are
> > - *       protected with an HMAC signature, even the initial packets
> > - *       of the TLS handshake.  This makes it easy for OpenVPN to
> > - *       throw away bogus packets quickly, without wasting resources
> > - *       on attempting a TLS handshake which will ultimately fail.
> > - */
>=20
> Just beginning to wonder if this big block is moved over to
> doxygen/doc_protocol_overview.h?
>=20

You're right, the block was moved out to a documentation-only header to imp=
rove legibility of the actual source code. I just double checked to see if =
anything was missing, but it seems complete. (https://github.com/andj/openv=
pn-ssl-refactoring/blob/4970f1485d4d2117ccb3b1932965809fc51d8efe/doxygen/do=
c_protocol_overview.h)

> [...snip...]
>=20
> Generally looks good.  Some "typos" here, but this can be fixed in an
> additional patch.  I'm mostly concerned about the big block which this
> patch seems to remove.  If it is moved to other files, then it is fine.
>=20
> So that this needs to be solved with an additional patch and confirm
> that
> the documentation taken out of this file is not lost, then I'll give
> this
> one an ACK.
>=20

Thanks! If you think it's necessary I'll change the "should be overwritten =
with 0s." in a patch, other than that, are you satisfied with the answers?

Kind Regards,

Adriaan de Jong

