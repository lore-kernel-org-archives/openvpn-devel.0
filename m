References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-2-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6e984a18-d12b-0934-6c90-af712197c96b@...2181...>
Date: Thu, 2 Aug 2018 18:59:29 +0800
MIME-Version: 1.0
In-Reply-To: <1532534933-3858-2-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U4EF00jBYcJXXSPA6BGx82Xs88aHacP9F"
Subject: Re: [Openvpn-devel] [PATCH v3 2/7] tls-crypt-v2: add specification
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
--U4EF00jBYcJXXSPA6BGx82Xs88aHacP9F
Content-Type: multipart/mixed; boundary="RvrideAzqaRST7os8dKDS6pwe32dExptp";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6e984a18-d12b-0934-6c90-af712197c96b@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/7] tls-crypt-v2: add specification to
 doc/
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1532534933-3858-2-git-send-email-steffan.karger@...1435...>

--RvrideAzqaRST7os8dKDS6pwe32dExptp
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/07/18 00:08, Steffan Karger wrote:
> This is a preliminary description of tls-crypt-v2.  It should give a good
> impression about the reasoning and design behind tls-crypt-v2, but might
> need some polishing and updating.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v3: Include length in WKc
>=20
>  doc/tls-crypt-v2.txt | 170 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 doc/tls-crypt-v2.txt
>=20
> diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
> new file mode 100644
> index 0000000..cc6453c
> --- /dev/null
> +++ b/doc/tls-crypt-v2.txt
> @@ -0,0 +1,170 @@
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
> +   ``len =3D len(Kc || metadata)`` (16 bit, network byte order)
> +
> +   ``T =3D HMAC-SHA256(Ka, len || Kc || metadata)``
> +
> +   ``IV =3D 128 most significant bits of T``
> +
> +   ``WKc =3D T || AES-256-CTR(Ke, IV, Kc || metadata || len)``
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

I think this is not possible until after point 2, because the length is
encrypted inside WKc, so we must unwrap the latter first, no?

However, if we append something new, how do we know before hand how long
WKc is? Maybe you intended to "len" right after T? so that it could
immediately be retrieved before doing any unwrapping?

However, it feels to me like we are slowly moving towards a TLV
(type-length-value) approach, with the type implicitly represented by
the order of the additional payloads.

Although I like this approach (as it saves packet type IDs and attempts
to keep format backwards compatible) I have the feeling this adds
useless complexity to part of the code which is currently meant to be
DoS resistant.

Do you think we really need this potential (since we currently don't use
the length) complexity? Or should we rather keep it as simple as
possible until we have any real plan to introduce something more
complex? (and then we can easily add another RESET_Vx with this feature)


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
> +   Metadata could for example contain the users certificate serial, such=
 that
> +   the incoming connection can be verified against a CRL, or a notAfter
> +   timestamp that limits the key's validity period.

Am I wrong or at some point we agreed on having some "format" for the
metadata container?
This way openvpn could decide if the payload is something to forward to
the verify script or if it is something to be handled internally?
Or did we drop this mechanism (can't remember right now)?


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
> +   RFC: should the server send a 'key rejected' message if the key is e.=
g.
> +   revoked or expired?  That allows for better client-side error reporti=
ng, but
> +   also reduces the DoS resilience.

I am "pro silence" for two reasons:
1) reuce attack surface
2) hide OpenVPN as much as possible - it should not reply anything in
case of potential malicious connection.

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

just a thought: how do we handle the process running the verify script?
Might users "bomb" with connections to keep openvpn busy spawning
processes and running them?

Cheers,

>=20

--=20
Antonio Quartulli


--RvrideAzqaRST7os8dKDS6pwe32dExptp--

--U4EF00jBYcJXXSPA6BGx82Xs88aHacP9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlti5BEACgkQB6U8WA7y
zXT4RQ//aBlBEzgZSydiBVO04As6Unk4Shpohhe3G4H+27wxleIZNN/TFqCaVHdh
hbHdGURrdBoNxTSKFcnIWLpOR8Vnm8sZHOCkXqK3dzw9kI3Ueq2UdnbcsmKfAEQH
5qFuebDc2htC6kMeqjjbSNbKVlurI14t42J3cGiA/UidMCDVctEK/I/3Ko8pGhF7
7KVbKq6Y5tWApWNpkaEpeKAP9CIKTK0q0I9Dz1Yspv+tgeG/pD0cI/SGY1tQ05Ye
g8slMBstG8/fCL9EmRibmKIagLVozLH6/kVryRyTmG+yuDFIWFp1iFpVcYMgClzv
fSi7RIfQGLGq3iYPQ5DhjJV6z5KiQd0pM15HXcXK46y1ARdyhaG1E4rP+bf/9EX7
EVL3Hdvqazqlng7gDsYkg+A5bEjBMyevM9b44D5+YKo4G0MyEh6a3GtWnaHCOcW1
UkCE6CLse1hbiA3e377GPOjjl5T4FVwNoytu4PzHz/QF2VzHMnAbAV2jlmrGBc6k
zfa+dlYaccUML98Us+If5GUZ4sSC0mxeohKEnPu9kp7R05imgatHwCSbpEKu1P5q
KyFs3uYfGxQjVQH9IZZcKriMn3Mq9MQqDe7YmJVdFfNY1o/AHnIzfxkh8Kd04vS5
mqGXqRedtB/yDzwU0kopOz+kbg+F9PSsfJ7r8O+gr4z/EzjoMyY=
=cVKm
-----END PGP SIGNATURE-----

--U4EF00jBYcJXXSPA6BGx82Xs88aHacP9F--

