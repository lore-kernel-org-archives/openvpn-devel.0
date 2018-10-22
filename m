References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1540208715-14044-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <bde19f09-605b-2f7e-b2ba-2c565b3e8a93@...2181...>
Date: Mon, 22 Oct 2018 23:58:33 +0800
MIME-Version: 1.0
In-Reply-To: <1540208715-14044-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r4zsH9MY2IOp45bCLonCe8hP4chm1RL5z"
Subject: Re: [Openvpn-devel] [PATCH v7 2/7] tls-crypt-v2: add specification
 to doc/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4zsH9MY2IOp45bCLonCe8hP4chm1RL5z
Content-Type: multipart/mixed; boundary="3YG9HoFrcA1GXTfsHWVxXHhjExmxqLENx";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bde19f09-605b-2f7e-b2ba-2c565b3e8a93@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v7 2/7] tls-crypt-v2: add specification to
 doc/
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1540208715-14044-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1540208715-14044-1-git-send-email-steffan.karger@...1435...>

--3YG9HoFrcA1GXTfsHWVxXHhjExmxqLENx
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

one little typ0 and one addition below:


On 22/10/18 19:45, Steffan Karger wrote:
> This is a preliminary description of tls-crypt-v2.  It should give a good
> impression about the reasoning and design behind tls-crypt-v2, but might
> need some polishing and updating.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v3: Include length in WKc
> v4: Clarify metadata handling
> v5: Typo fixes (thanks tincanteksup)
> v6: Change WKc length to ciphertext length (was plaintext), textual fixes
> v7: Textual fixes irt review
>=20
>  doc/tls-crypt-v2.txt | 189 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 doc/tls-crypt-v2.txt
>=20
> diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
> new file mode 100644
> index 0000000..582a2b8
> --- /dev/null
> +++ b/doc/tls-crypt-v2.txt
> @@ -0,0 +1,189 @@
> +Client-specific tls-crypt keys (--tls-crypt-v2)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes the ``--tls-crypt-v2`` option, which enables Ope=
nVPN
> +to use client-specific ``--tls-crypt`` keys.
> +
> +Rationale
> +---------
> +
> +``--tls-auth`` and ``tls-crypt`` use a pre-shared group key, which is sh=
ared
> +among all clients and servers in an OpenVPN deployment.  If any client or
> +server is compromised, the attacker will have access to this shared key,=
 and it
> +will no longer provide any security.  To reduce the risk of losing pre-s=
hared
> +keys, ``tls-crypt-v2`` adds the ability to supply each client with a uni=
que
> +tls-crypt key.  This allows large organisations and VPN providers to pro=
fit
> +from the same DoS and TLS stack protection that small deployments can al=
ready
> +achieve using ``tls-auth`` or ``tls-crypt``.
> +
> +Also, for ``tls-crypt``, even if all these peers succeed in keeping the =
key
> +secret, the key lifetime is limited to roughly 8000 years, divided by the
> +number of clients (see the ``--tls-crypt`` section of the man page).  Us=
ing
> +client-specific keys, we lift this lifetime requirement to roughly 8000 =
years
> +for each client key (which "Should Be Enough For Everybody (tm)").
> +
> +
> +Introduction
> +------------
> +
> +``tls-crypt-v2`` uses an encrypted cookie mechanism to introduce
> +client-specific tls-crypt keys without introducing a lot of server-side =
state.
> +The client-specific key is encrypted using a server key.  The server key=
 is the
> +same for all servers in a group.  When a client connects, it first sends=
 the
> +encrypted key to the server, such that the server can decrypt the key an=
d all
> +messages can thereafter be encrypted using the client-specific key.
> +
> +A wrapped (encrypted and authenticated) client-specific key can also con=
tain
> +metadata.  The metadata is wrapped together with the key, and can be use=
d to
> +allow servers to identify clients and/or key validity.  This allows the =
server
> +to abort the connection immediately after receiving the first packet, ra=
ther
> +than performing an entire TLS handshake.  Aborting the connection this e=
arly
> +greatly improves the DoS resilience and reduces attack service against
> +malicious clients that have the ``tls-crypt`` or ``tls-auth`` key.  This=
 is
> +particularly relevant for large deployments (think lost key or disgruntl=
ed
> +employee) and VPN providers (clients are not trusted).
> +
> +To allow for a smooth transition, ``tls-crypt-v2`` is designed such that=
 a
> +server can enable both ``tls-crypt-v2`` and either ``tls-crypt`` or
> +``tls-auth``.  This is achieved by introducing a P_CONTROL_HARD_RESET_CL=
IENT_V3
> +opcode, that indicates that the client wants to use ``tls-crypt-v2`` for=
 the
> +current connection.
> +
> +For an exact specification and more details, read the Implementation sec=
tion.
> +
> +
> +Implementation
> +--------------
> +
> +When setting up a tls-crypt-v2 group (similar to generating a tls-crypt =
or
> +tls-auth key previously):
> +
> +1. Generate a tls-crypt-v2 server key using OpenVPN's ``--genkey``.  Thi=
s key

typ0:

``--genkey`` should be ``--tls-crypt-v2-genkey server``

> +   contains 2 512-bit keys, of which we use:
> +
> +   * the first 256 bits of key 1 as AES-256-CTR encryption key ``Ke``
> +   * the first 256 bits of key 2 as HMAC-SHA-256 authentication key ``Ka=
``
> +
> +   This fomat is similar to the format for regular ``tls-crypt``/``tls-a=
uth``
> +   and data channel keys, which allows us to reuse code.
> +
> +2. Add the tls-crypt-v2 server key to all server configs
> +   (``tls-crypt-v2 /path/to/server.key``)
> +
> +
> +When provisioning a client, create a client-specific tls-crypt key:
> +
> +1. Generate 2048 bits client-specific key ``Kc``

I would add something like the paragraph about the server key:

... using OpenVPN's ``--tls-crypt-v2-genkey client``

> +
> +2. Optionally generate metadata
> +
> +   The first byte of the metadata determines the type.  The initial
> +   implementation supports the following types:
> +
> +   0x00 (USER):         User-defined free-form data.
> +   0x01 (TIMESTAMP):    64-bit network order unix timestamp of key gener=
ation.
> +
> +   The timestamp can be used to reject too-old tls-crypt-v2 client keys.
> +
> +   User metadata could for example contain the users certificate serial,=
 such
> +   that the incoming connection can be verified against a CRL.
> +
> +   If no metadata is supplied during key generation, openvpn defaults to=
 the
> +   TIMESTAMP metadata type.
> +
> +3. Create a wrapped client key ``WKc``, using the same nonce-misuse-resi=
stant
> +   SIV construction we use for tls-crypt:
> +
> +   ``len =3D len(WKc)`` (16 bit, network byte order)
> +
> +   ``T =3D HMAC-SHA256(Ka, len || Kc || metadata)``
> +
> +   ``IV =3D 128 most significant bits of T``
> +
> +   ``WKc =3D T || AES-256-CTR(Ke, IV, Kc || metadata) || len``
> +
> +   Note that the length of ``WKc`` can be computed before composing ``WK=
c``,
> +   because the length of each component is known (and AES-256-CTR does n=
ot add
> +   any padding).
> +
> +4. Create a tls-crypt-v2 client key: PEM-encode ``Kc || WKc`` and store =
in a
> +   file, using the header ``-----BEGIN OpenVPN tls-crypt-v2 client key--=
---``
> +   and the footer ``-----END OpenVPN tls-crypt-v2 client key-----``.  (T=
he PEM
> +   format is simple, and following PEM allows us to use the crypto lib f=
unction
> +   for en/decoding.)
> +
> +5. Add the tls-crypt-v2 client key to the client config
> +   (``tls-crypt-v2 /path/to/client-specific.key``)
> +
> +
> +When setting up the openvpn connection:
> +
> +1. The client reads the tls-crypt-v2 key from its config, and:
> +
> +   1. loads ``Kc`` as its tls-crypt key,
> +   2. stores ``WKc`` in memory for sending to the server.
> +
> +2. To start the connection, the client creates a P_CONTROL_HARD_RESET_CL=
IENT_V3
> +   message, wraps it with tls-crypt using ``Kc`` as the key, and appends
> +   ``WKc``.  (``WKc`` must not be encrypted, to prevent a chicken-and-egg
> +   problem.)
> +
> +3. The server receives the P_CONTROL_HARD_RESET_CLIENT_V3 message, and
> +
> +   1. reads the WKc length field from the end of the message, and extrac=
ts WKc
> +      from the message
> +   2. unwraps ``WKc``
> +   3. uses unwrapped ``Kc`` to verify the remaining
> +      P_CONTROL_HARD_RESET_CLIENT_V3 message's (encryption and) authenti=
cation.
> +
> +   The message is dropped and no error response is sent when either 3.1,=
 3.2 or
> +   3.3 fails (DoS protection).
> +
> +4. Server optionally checks metadata using a --tls-crypt-v2-verify script
> +
> +   This allows early abort of connection, *before* we expose any of the
> +   notoriously dangerous TLS, X.509 and ASN.1 parsers and thereby reduce=
s the
> +   attack surface of the server.
> +
> +   The metadata is checked *after* the OpenVPN three-way handshake has
> +   completed, to prevent DoS attacks.  (That is, once the client has pro=
ved to
> +   the server that it possesses Kc, by authenticating a packet that cont=
ains the
> +   session ID picked by the server.)
> +
> +   A server should not send back any error messages if metadata verifica=
tion
> +   fails, to reduce attack surface and maximize DoS resilience.
> +
> +6. Client and server use ``Kc`` for (un)wrapping any following control c=
hannel
> +   messages.
> +
> +
> +Considerations
> +--------------
> +
> +To allow for a smooth transition, the server implementation allows
> +``tls-crypt`` or ``tls-auth`` to be used simultaneously with ``tls-crypt=
-v2``.
> +This specification does not allow simultaneously using ``tls-crypt-v2`` =
and
> +connections without any control channel wrapping, because that would bre=
ak DoS
> +resilience.
> +
> +WKc includes a length field, so we leave the option for future extension=
 of the
> +P_CONTROL_HEAD_RESET_CLIENT_V3 message open.  (E.g. add payload to the r=
eset to
> +indicate low-level protocol features.)
> +
> +``tls-crypt-v2`` uses fixed crypto algorithms, because:
> +
> + * The crypto is used before we can do any negotiation, so the algorithm=
s have
> +   to be predefined.
> + * The crypto primitives are chosen conservatively, making problems with=
 these
> +   primitives unlikely.
> + * Making anything configurable adds complexity, both in implementation =
and
> +   usage.  We should not add any more complexity than is absolutely nece=
ssary.
> +
> +Potential ``tls-crypt-v2`` risks:
> +
> + * Slightly more work on first connection (``WKc`` unwrap + hard reset u=
nwrap)
> +   than with ``tls-crypt`` (hard reset unwrap) or ``tls-auth`` (hard res=
et auth).
> + * Flexible metadata allow mistakes
> +   (So we should make it easy to do it right.  Provide tooling to create=
 client
> +   keys based on cert serial + CA fingerprint, provide script that uses =
CRL (if
> +   available) to drop revoked keys.)
>=20


I hope they can be fixed on the fly. Other than that:


Acked-by: Antonio Quartulli <antonio@...515...>


--=20
Antonio Quartulli


--3YG9HoFrcA1GXTfsHWVxXHhjExmxqLENx--

--r4zsH9MY2IOp45bCLonCe8hP4chm1RL5z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlvN86kACgkQ9FVsWUWD
Dm0Stg/+OHq0AeymAhS+WotKdN2EirNM+D6ei2FaiLHs8dfqu4wUQ9/DiQS4w2ro
NIlTBIGpVDGREUSHkuYFbSweVRKsKM+eEiR17uaHdhASg0PmYlSt/kunT7Ok/Ezp
32sViRdUHWnYs9TMf4Pnqa6cHae/SFQOAR68vUfM7zjJA4/aqA1C+foIpo9b06Dg
6px8Vf+4XNlvUAJ/Pi9bFsl+3MuJLAqr8YlGb9kwCk23Hnh9nD5S2auVtS01HMiE
95Vq+4rfeWfaiHlsal1fBeT4FXeErSA1GaomX9AtnlxLxHqHV6YoSoeV0aDsboeh
1BgjV7BPcY+YBes0wWPYzNF1yHw41RWeBYvO4obR7JBbrHlY14ThfGycz/925Oo+
d3Bzg6vpdZqfc/6cmHzJkuTrh+8MaBD3qtpzYMgqocfdoLqihiqzFLzNY6LDYhKu
d4bPV2JT+TXjeDb5EALETGjFJu/Rp+SYI96kP66gIKRdgnMM5yoHCEuAI87MHq4F
/Sf+TkTJAO/K6zvQOGGJTEa79jfUeC01w4+4Ye9YuA4TyyRpEjSZOsqu8xOQ0n/8
Z86Vqyk4X+53DMNIc2YZqKrKuO+L12ruyOfA/WB4/7ybDZTD/kiannQSI+kQvjt9
hsHcsC9s2bmRwl52hnkghFhreasgtbbh0Eyc9F7MFesdve0ahYg=
=f/es
-----END PGP SIGNATURE-----

--r4zsH9MY2IOp45bCLonCe8hP4chm1RL5z--

