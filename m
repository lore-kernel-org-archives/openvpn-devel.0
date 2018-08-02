References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-2-git-send-email-steffan.karger@...1435...>
 <6e984a18-d12b-0934-6c90-af712197c96b@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <e5bcbb69-2b69-4f57-c541-35dd403f6199@...1435...>
Date: Thu, 2 Aug 2018 17:38:14 +0200
MIME-Version: 1.0
In-Reply-To: <6e984a18-d12b-0934-6c90-af712197c96b@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tKj4sK3cnd4NUcVp4P84v6Hklp4elBSsD"
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--tKj4sK3cnd4NUcVp4P84v6Hklp4elBSsD
Content-Type: multipart/mixed; boundary="UZ7h68k7RtYmpFpq1vVyj64k2eajtTH0E";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e5bcbb69-2b69-4f57-c541-35dd403f6199@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/7] tls-crypt-v2: add specification to
 doc/
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
 <1532534933-3858-2-git-send-email-steffan.karger@...1435...>
 <6e984a18-d12b-0934-6c90-af712197c96b@...2181...>
In-Reply-To: <6e984a18-d12b-0934-6c90-af712197c96b@...2181...>

--UZ7h68k7RtYmpFpq1vVyj64k2eajtTH0E
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 02-08-18 12:59, Antonio Quartulli wrote:
> On 26/07/18 00:08, Steffan Karger wrote:
>> This is a preliminary description of tls-crypt-v2.  It should give a good
>> impression about the reasoning and design behind tls-crypt-v2, but might
>> need some polishing and updating.
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>> ---
>> v3: Include length in WKc
>>
>>  doc/tls-crypt-v2.txt | 170 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 170 insertions(+)
>>  create mode 100644 doc/tls-crypt-v2.txt
>>
>> diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
>> new file mode 100644
>> index 0000000..cc6453c
>> --- /dev/null
>> +++ b/doc/tls-crypt-v2.txt
>> @@ -0,0 +1,170 @@
>> +Client-specific tls-crypt keys (--tls-crypt-v2)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +This document describes the ``--tls-crypt-v2`` option, which enables Op=
enVPN
>> +to use client-specific ``--tls-crypt`` keys.
>> +
>> +Rationale
>> +---------
>> +
>> +``--tls-auth`` and ``tls-crypt`` use a pre-shared group key, which is s=
hared
>> +among all clients and servers in an OpenVPN deployment.  If any client =
or
>> +server is compromised, the attacker will have access to this shared key=
, and it
>> +will no longer provide any security.  To reduce the risk of loosing pre=
-shared
>> +keys, ``tls-crypt-v2`` adds the ability to supply each client with a un=
ique
>> +tls-crypt key.  This allows large organisations and VPN providers to pr=
ofit
>> +from the same DoS and TLS stack protection that small deployments can a=
lready
>> +achieve using ``tls-auth`` or ``tls-crypt``.
>> +
>> +Also, for ``tls-crypt``, even if all these peers succeed in keeping the=
 key
>> +secret, the key lifetime is limited to roughly 8000 years, divided by t=
he
>> +number of clients (see the ``--tls-crypt`` section of the man page).  U=
sing
>> +client-specific keys, we lift this lifetime requirement to roughly 8000=
 years
>> +for each client key (which "Should Be Enough For Everybody (tm)").
>> +
>> +
>> +Introduction
>> +------------
>> +
>> +``tls-crypt-v2`` uses an encrypted cookie mechanism to introduce
>> +client-specific tls-crypt keys without introducing a lot of server-side=
 state.
>> +The client-specific key is encrypted using a server key.  The server ke=
y is the
>> +same for all servers in a group.  When a client connects, it first send=
s the
>> +encrypted key to the server, such that the server can decrypt the key a=
nd all
>> +messages can thereafter be encrypted using the client-specific key.
>> +
>> +A wrapped (encrypted and authenticated) client-specific key can also co=
ntain
>> +metadata.  The metadata is wrapped together with the key, and can be us=
ed to
>> +allow servers to identify clients and/or key validity.  This allows the=
 server
>> +to abort the connection immediately after receiving the first packet, r=
ather
>> +than performing an entire TLS handshake.  Aborting the connection this =
early
>> +greatly improves the DoS resilience and reduces attack service against
>> +malicious clients that have the ``tls-crypt`` or ``tls-auth`` key.  Thi=
s is
>> +particularly relevant for large deployments (think lost key or disgrunt=
led
>> +employee) and VPN providers (clients are not trusted).
>> +
>> +To allow for a smooth transition, ``tls-crypt-v2`` is designed such tha=
t a
>> +server can enable both ``tls-crypt-v2`` and either ``tls-crypt`` or
>> +``tls-auth``.  This is achieved by introducing a P_CONTROL_HARD_RESET_C=
LIENT_V3
>> +opcode, that indicates that the client wants to use ``tls-crypt-v2`` fo=
r the
>> +current connection.
>> +
>> +For an exact specification and more details, read the Implementation se=
ction.
>> +
>> +
>> +Implementation
>> +--------------
>> +
>> +When setting up a tls-crypt-v2 group (similar to generating a tls-crypt=
 or
>> +tls-auth key previously):
>> +
>> +1. Generate a tls-crypt-v2 server key using OpenVPN's ``--genkey``.  Th=
is key
>> +   contains 4 512-bit keys, of which we use:
>> +
>> +   * the first 256 bits of key 1 as AES-256-CTR encryption key ``Ke``
>> +   * the first 256 bits of key 2 as HMAC-SHA-256 authentication key ``K=
a``
>> +
>> +2. Add the tls-crypt-v2 server key to all server configs
>> +   (``tls-crypt-v2 /path/to/server.key``)
>> +
>> +
>> +When provisioning a client, create a client-specific tls-crypt key:
>> +
>> +1. Generate 2048 bits client-specific key ``Kc``
>> +2. Optionally generate metadata
>> +3. Create a wrapped client key ``WKc``, using the same nonce-misuse-res=
istant
>> +   SIV conruction we use for tls-crypt:
>> +
>> +   ``len =3D len(Kc || metadata)`` (16 bit, network byte order)
>> +
>> +   ``T =3D HMAC-SHA256(Ka, len || Kc || metadata)``
>> +
>> +   ``IV =3D 128 most significant bits of T``
>> +
>> +   ``WKc =3D T || AES-256-CTR(Ke, IV, Kc || metadata || len)``
>> +
>> +4. Create a tls-crypt-v2 client key: PEM-encode ``Kc || WKc`` and store=
 in a
>> +   file, using the header ``-----BEGIN OpenVPN tls-crypt-v2 client key-=
----``
>> +   and the footer ``-----END OpenVPN tls-crypt-v2 client key-----``.  (=
The PEM
>> +   format is simple, and following PEM allows us to use the crypto lib =
function
>> +   for en/decoding.)
>> +5. Add the tls-crypt-v2 client key to the client config
>> +   (``tls-crypt-v2 /path/to/client-specific.key``)
>> +
>> +
>> +When setting up the openvpn connection:
>> +
>> +1. The client reads the tls-crypt-v2 key from its config, and:
>> +
>> +   1. loads ``Kc`` as its tls-crypt key,
>> +   2. stores ``WKc`` in memory for sending to the server.
>> +
>> +2. To start the connection, the client creates a P_CONTROL_HARD_RESET_C=
LIENT_V3
>> +   message, wraps it with tls-crypt using ``Kc`` as the key, and appends
>> +   ``WKc``.  (``WKc`` must not be encrypted, to prevent a chicken-and-e=
gg
>> +   problem.)
>> +
>> +3. The server receives the P_CONTROL_HARD_RESET_CLIENT_V3 message, and
>> +
>> +   1. reads the WKc length field from the end of the message, and extra=
cts WKc
>> +      from the message
>=20
> I think this is not possible until after point 2, because the length is
> encrypted inside WKc, so we must unwrap the latter first, no?
>=20
> However, if we append something new, how do we know before hand how long
> WKc is? Maybe you intended to "len" right after T? so that it could
> immediately be retrieved before doing any unwrapping?

Hrmpf, len should not have been inside the encrypted blob.  The line
above should have read:

   ``WKc =3D T || AES-256-CTR(Ke, IV, Kc || metadata) || len``

> However, it feels to me like we are slowly moving towards a TLV
> (type-length-value) approach, with the type implicitly represented by
> the order of the additional payloads.
>=20
> Although I like this approach (as it saves packet type IDs and attempts
> to keep format backwards compatible) I have the feeling this adds
> useless complexity to part of the code which is currently meant to be
> DoS resistant.
>=20
> Do you think we really need this potential (since we currently don't use
> the length) complexity? Or should we rather keep it as simple as
> possible until we have any real plan to introduce something more
> complex? (and then we can easily add another RESET_Vx with this feature)

The trick here is that we have "a v3 reset packet", which might be just
what it is now or any new format we come up with, concatenated with a
WKc.  By including the length of WKc as plaintext at the end of WKc
itself, we can easily read it from the end and truncate the data to end
up with just the packet.  This allows us to postpone the discussion
about protocol extension of the packets themselves to when we actually
need that.

And yes, I think we are going to need this to be able to improve the
control channel performance at some point without a hard protocol
switch.  Also, I think that we'll need to do that to cope with heavier
(e.g. post-quantum) key exchanges or larger configurations.

Adding another RESET_Vx to achieve this makes it harder to make the
protocol upgrade transparent to the user, because older clients will
simply not reply to the new opcodes.  If we extend the payload packet
otoh, older clients (at least openvpn2, don't know what v3 does) will
just ignore the payload.  We can turn that into a handshake by having
newer servers reply with payload in the reset response, and use that to
determine which protocol extensions the server support.  But as said
before, just including the length gives to the time to think this through.

All in all, I think adding the length to WKc is such a simple addition
that it is easily justified by the flexibility we get in return.

>> +   2. unwraps ``WKc``
>> +   3. uses unwrapped ``Kc`` to verify the remaining
>> +      P_CONTROL_HARD_RESET_CLIENT_V3 message's (encryption and) authent=
ication.
>> +
>> +   The message is dropped and no error response is sent when either 3.1=
, 3.2 or
>> +   3.3 fails (DoS protection).
>> +
>> +4. Server optionally checks metadata using a --tls-crypt-v2-verify scri=
pt
>> +
>> +   Metadata could for example contain the users certificate serial, suc=
h that
>> +   the incoming connection can be verified against a CRL, or a notAfter
>> +   timestamp that limits the key's validity period.
>=20
> Am I wrong or at some point we agreed on having some "format" for the
> metadata container?
> This way openvpn could decide if the payload is something to forward to
> the verify script or if it is something to be handled internally?
> Or did we drop this mechanism (can't remember right now)?

Yes and no.  We did agree on introducing the metadata type, and the
implementation does that.  If no metadata is supplied when generation
the key, the current implementation defaults to adding a key generation
timestamp.

For verification however, we don't act on the type.  We just pass the
type to the external script through the metadata_type env var.  This was
done to not pull in too much extra work, as it allows us to later
implement internal handling if we want to.

But, none of this was documented properly here, so I'll update the doc.

>> +
>> +   This allows early abort of connection, *before* we expose any of the
>> +   notoriously dangerous TLS, X.509 and ASN.1 parsers and thereby reduc=
es the
>> +   attack surface of the server.
>> +
>> +   The metadata is checked *after* the OpenVPN three-way handshake has
>> +   completed, to prevent DoS attacks.  (That is, once the client has pr=
oved to
>> +   the server that it possesses Kc, by authenticating a packet that con=
tains the
>> +   session ID picked by the server.)
>> +
>> +   RFC: should the server send a 'key rejected' message if the key is e=
.g.
>> +   revoked or expired?  That allows for better client-side error report=
ing, but
>> +   also reduces the DoS resilience.
>=20
> I am "pro silence" for two reasons:
> 1) reuce attack surface
> 2) hide OpenVPN as much as possible - it should not reply anything in
> case of potential malicious connection.

Me too - let's go that way.  I'll update the doc.

>> +
>> +6. Client and server use ``Kc`` for (un)wrapping any following control =
channel
>> +   messages.
>> +
>> +
>> +Considerations
>> +--------------
>> +
>> +To allow for a smooth transition, the server implementation allows
>> +``tls-crypt`` or ``tls-auth`` to be used simultaneously with ``tls-cryp=
t-v2``.
>> +This specification does not allow simultaneously using ``tls-crypt-v2``=
 and
>> +connections without any control channel wrapping, because that would br=
eak DoS
>> +resilience.
>> +
>> +WKc includes a length field, so we leave the option for future extensio=
n of the
>> +P_CONTROL_HEAD_RESET_CLIENT_V3 message open.  (E.g. add payload to the =
reset to
>> +indicate low-level protocol features.)
>> +
>> +``tls-crypt-v2`` uses fixed crypto algorithms, because:
>> +
>> + * The crypto is used before we can do any negotiation, so the algorith=
ms have
>> +   to be predefined.
>> + * The crypto primitives are chosen conservatively, making problems wit=
h these
>> +   primitives unlikely.
>> + * Making anything configurable adds complexity, both in implementation=
 and
>> +   usage.  We should not add anymore complexity than is absolutely nece=
ssary.
>> +
>> +Potential ``tls-crypt-v2`` risks:
>> +
>> + * Slightly more work on first connection (``WKc`` unwrap + hard reset =
unwrap)
>> +   than with ``tls-crypt`` (hard reset unwrap) or ``tls-auth`` (hard re=
set auth).
>> + * Flexible metadata allow mistakes
>> +   (So we should make it easy to do it right.  Provide tooling to creat=
e client
>> +   keys based on cert serial + CA fingerprint, provide script that uses=
 CRL (if
>> +   available) to drop revoked keys.)
>=20
> just a thought: how do we handle the process running the verify script?
> Might users "bomb" with connections to keep openvpn busy spawning
> processes and running them?

Only users with a valid (both plain text and wrapped) tls-crypt-v2 key
can do that, because they need to complete the three-way handshake.
That's why metadata verification is done only after the handshake
(proof-of-possession) completes and not immediately after receiving (and
unwrapping) WKc.  There's not much more we can do without introducing
even more crypto tricks (like, proof-of-work or so).  Still, it should
be a better than doing an entire TLS handshake (including all the attack
surface there) :-)

Thanks!
-Steffan


--UZ7h68k7RtYmpFpq1vVyj64k2eajtTH0E--

--tKj4sK3cnd4NUcVp4P84v6Hklp4elBSsD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbYyVmAAoJEEEwndWOY1w5wdEIAIpUJgKFDA//rFxqJUSc3pWR
DChqj71qnj3DPE/7gPIDBz9Hx92bEYr/aJ6cTOBxDa3SXt/ogMVQhCJ/YAZk/x2e
pLTW/EVUMJzHeBkn58HeMZwfBkeo4eSLg7+nqVeYtVuQWNSP+n2LiK/KjX1MlJTn
0znoRFl/qNqw6nncUhc0r9SaEfAeFX11i6cNgpRXw18Kzqxc/tuJcgMozGr76vEA
NxpQ/nJKyMZ4dCimQGM/VVGkWAPviQKRBWMfWOkzDWFxtutKYW9VYQKfTmEcGBwf
2fJ/Ra5P+A2pnu8Dv5jZ4Ezsqa3pex7in/BqjeXcLaACJka+fTaLlMnov2QacqY=
=VPfl
-----END PGP SIGNATURE-----

--tKj4sK3cnd4NUcVp4P84v6Hklp4elBSsD--

