References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-3-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <12f1f4f7-0b03-3f45-c06b-aec77e4e1ef1@...2181...>
Date: Thu, 8 Mar 2018 15:34:41 +0800
MIME-Version: 1.0
In-Reply-To: <1512734870-17133-3-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3EElgZWX5xUpQ7j9MEo0EbaVx8FoOApL3"
Subject: Re: [Openvpn-devel] [PATCH 02/10] tls-crypt-v2: add specification
 to doc/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3EElgZWX5xUpQ7j9MEo0EbaVx8FoOApL3
Content-Type: multipart/mixed; boundary="pKhS3G357NV9Z8xFutXFUQR4lU3lC9wnI";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <12f1f4f7-0b03-3f45-c06b-aec77e4e1ef1@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 02/10] tls-crypt-v2: add specification to
 doc/
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-3-git-send-email-steffan.karger@...1435...>

--pKhS3G357NV9Z8xFutXFUQR4lU3lC9wnI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/12/17 20:07, Steffan Karger wrote:
> This is a preliminary description of tls-crypt-v2.  It should give a good
> impression about the reasoning and design behind tls-crypt-v2, but might
> need some polishing and updating.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  doc/tls-crypt-v2.txt | 164 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 doc/tls-crypt-v2.txt
>=20
> diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
> new file mode 100644
> index 0000000..578b2f9
> --- /dev/null
> +++ b/doc/tls-crypt-v2.txt
> @@ -0,0 +1,164 @@
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
> +will no longer provide any security.  To reduce the risk of loosing pre-=
shared

did you really mean "loosing"? or is it a misspelled "losing"?

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
> +   contains 4 512-bit keys, of which we use:
> +
> +   * the first 256 bits of key 1 as AES-256-CTR encryption key ``Ke``
> +   * the first 256 bits of key 2 as HMAC-SHA-256 authentication key ``Ka=
``
> +
> +2. Add the tls-crypt-v2 server key to all server configs
> +   (``tls-crypt-v2 /path/to/server.key``)
> +
> +
> +When provisioning a client, create a client-specific tls-crypt key:
> +
> +1. Generate 2048 bits client-specific key ``Kc``
> +2. Optionally generate metadata
> +3. Create a wrapped client key ``WKc``, using the same nonce-misuse-resi=
stant
> +   SIV conruction we use for tls-crypt:
> +
> +   ``T =3D HMAC-SHA256(Ka, Kc || metadata)``
> +
> +   ``IV =3D 128 most significant bits of T``
> +
> +   ``WKc =3D T || AES-256-CTR(Ke, IV, Kc || metadata)``
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
> +5. Add the tls-crypt-v2 client key to the client config
> +   (``tls-crypt-v2 /path/to/client-specific.key``)

For the server key you've said "using OpenVPN's ``--genkey``", while for
the client key you haven't mentioned the ``--tls-crypt-v2-genkey``
introduced in patch 3/10. Any reason for that?

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
> +   message without payload, wraps it with tls-crypt using ``Kc`` as the =
key,
> +   and appends ``WKc``.  (``WKc`` must not be encrypted, to prevent a
> +   chicken-and-egg problem.)
> +
> +3. The server receives the P_CONTROL_HARD_RESET_CLIENT_V3 message, and
> +
> +   a. unwraps ``WKc`` and strips ``WKc`` from the message.
> +   b. uses unwrapped ``Kc`` to verify the remaining
> +      P_CONTROL_HARD_RESET_CLIENT_V3 message's authentication.
> +
> +   The message is dropped and no error response is sent when either a or=
 b
> +   fails (DoS protection).
> +
> +4. Server optionally checks metadata using a --tls-crypt-v2-verify script
> +
> +   Metadata could for example contain the users certificate serial, such=
 that
> +   the incoming connection can be verified against a CRL, or a notAfter
> +   timestamp that limits the key's validity period.
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

just a thought here: the metadata is actually created by the
server/provider and it is authenticated/encrypted with the server key.

Isn't this enough to ensure that its content is not malicious and thus
allow the server to parse it right after having received the
HARD_RESET_V3 (instead of performing a "three-way handshake" first)?

> +
> +   RFC: should the server send a 'key rejected' message if the key is e.=
g.
> +   revoked or expired?  That allows for better client-side error reporti=
ng, but
> +   also reduces the DoS resilience.
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
> +resilience.  RFC: should we add an option along the lines of
> +--tls-crypt-v2-allow-insecure-fallback to allow admins to enable this an=
yway?
> +It might help with transitioning.

good question, but I think people are already fighting with this now
while transitioning to tls-crypt, thus I would vote for not introducing
more code complexity.

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
> +   usage.  We should not add anymore complexity than is absolutely neces=
sary.
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


The rest looks good! Thanks for this exhaustive description!

Cheers,

--=20
Antonio Quartulli


--pKhS3G357NV9Z8xFutXFUQR4lU3lC9wnI--

--3EElgZWX5xUpQ7j9MEo0EbaVx8FoOApL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlqg55EACgkQB6U8WA7y
zXRx2RAAt/IqgnnH8TmTnpqNvucCaXlr3yXr1DiDrSG8sj4WzAWrdjFMq3q6MPwh
l8Dml8q9ieSg7Vn6BgdFFLROlllQblS7AzLdNDaMGUJS1Ul0SUjYrLE1e3OJeqrl
hl0xIZxzK6WsbZYhW1ZeXITrJfz+EB14d3losv14aE06PCz3cEVVACiCqKsZ0ubr
P/6mNW7rdliRa9ddgAgHo89NzqpmIoyX7vW1JAZR+OuTIdHUsuTDim0iRWXqXnk1
SPkbn1bEGYCDFxAb66vYXIib85TWXZBKWLklIlC3LiOBU/JLkiqdLl1iqT92tHD9
YE27uIiLrVEjD3jF707tag0F79ruzacKb54NKiiZB42qillTeWoHztUWFcJVhP0O
aeTnda5HRH//wcfYQJ/DxazjVX2HXc59+uvUzivRpwTcQQGR2G/0+7U6dZp0jryK
qmL2SDUhiyFPcxy1ToRYc/HRwGPIFyDe5KALJW7jWeIIhhkAzIXGKFB51dqy3tFV
JrxCxxkTb17OZaGMhuT1pxz3tfM59PzMGzHJnLA8K28N0L45+ZhYI3P+klFNs1Yi
bTXnahBUmH6aNBGfUHZ20eW1rKJHq5CmyS0BJAkKpp5BQPG3L9xAmzTK0J7aXcj1
iTTi7oHJbSnDrhAYeAP20YHGHUCpAo6t+YV8p4mYrkU+p3D8tbI=
=I5tY
-----END PGP SIGNATURE-----

--3EElgZWX5xUpQ7j9MEo0EbaVx8FoOApL3--

