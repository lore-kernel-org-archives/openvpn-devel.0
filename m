From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 19 Apr 2013 12:13:29 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9013BC630D62@...1436...>
References: <5170496A.6000000@...1737...>
	<20130418204455.GW29506@...1296...>
	<1CED409804E2164C8104F9E623B08B9013BC630BF0@...1436...>
	<51711363.4070802@...1737...>
In-Reply-To: <51711363.4070802@...1737...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Support for libsodium?
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
To: Ed W <lists@...1737...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



> -----Original Message-----
> From: Ed W [mailto:lists@...1737...]
> Sent: vrijdag 19 april 2013 11:50
> To: Adriaan de Jong
> Cc: Gert Doering; openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Support for libsodium?
>=20
> Hi
>=20
> I think I'm missing some of the subtleties of your reply, please
> forgive probable ignorance!
>=20
>=20
> > There's a few issues that we need to overcome though:
> >
> >   - Unfortunately as far as I know there's no TLS support in NaCl. I
> guess it could work as a crypto library for the data channel and TLS-
> Auth parts of OpenVPN though. The control channel could then still be
> managed by PolarSSL/OpenSSL.
>=20
> I don't understand what part of TLS you would miss here?  The actual
> encryption and hmac protocol would be fixed (salsa20/poly1305). The key
> exchange would be done using elliptic curves (although in fact you
> would
> normally just use the crypto_box interface and it would handle key
> generation and authentication for you.
>=20

As far as I can see, what's missing is the TLS protocol itself :). This cou=
ld use the primitives in libsodium, but is still not easy to implement (see=
 my last comment).=20

> The magic of curve25519 is that there is nothing special about the
> choice of public/private keys. Any 32 byte random bytes are a valid
> key.
> This leads to very compact key exchanges (and easy key generation, pick
> 32 random bytes).
>=20
> Sender and receiver can compute the same private session key from only
> the other side's public key and your own private key (you end up with
> the same key on both sides). This means there is a mechanism to
> implicitly exchange a shared secret key for the symmetric cipher.
>=20

This isn't supported in TLS, as far as I know. You'd have to change the con=
trol channel to use a different protocol (see my last comment).

> Libsodium introduces signing, but the library itself is a little weak
> on
> handling of signed public keys, so it's certainly true that we have the
> bootstrapping problem of securing the public channel, that said I
> should
> think most users of openvpn are NOT currently using signed ssl certs? I
> guess we could introduce the idea of known/fixed server certificates to
> mitigate this, or at least a distributed signing key which is used to
> sign the certs (introducing traditional key signing brings back
> open/polarssl, so I propose we discount that?). I think this is
> workable
> though.
>=20

Certs are always signed, but by a CA of their own making. This way, multi-c=
lient setups are made possible. They're just not signed by a central cert a=
uthority.

Some sort of PKI is probably a good idea for a hub-and-spoke VPN model.

> Finally, because the encryption algorithm is effectively stateless, an
> interesting option presents, which is to have a completely
> connectionless encrypted stream - this has some possible benefits with
> regards to multi-homing and disconnected clients, eg you could
> trivially
> pass your encrypted packets across multiple internet connections, as
> long as the server receives them via some interface, there is no reason
> to care which interface they came in on. This may have some useful
> applications?
>=20
> >   - Maintenance is an issue, are you (or do you know someone :))
> willing to take responsibility for writing the required patches and
> maintaining them?
>=20
> Tentatively...
>=20
>=20
> >   - As Gert said, he default algorithm in OpenVPN is Blowfish with a
> SHA-1 HMAC. There's no support for auto-negotiation, so using NaCl will
> break compatibility with an OpenSSL/PolarSSL-based OpenVPN. This is
> minor though, as it's easy to work around this as an end-user by
> specifying the algorithms in the client and server config files.
>=20
> Yes, I see this as a completely fixed implementation choice for crypto
> algorithms.
>=20
> Lets argue this quickly. The crypto *will* show signs of weakness at
> some future point, TLS allows dropping in some new algorithm and
> keeping
> the basic protocol the same... in theory... But in practice there have
> been a number of significant weakenesses found in TLS and SSL recently
> which has in turn forced a requirement to redeploy compiled code to
> clients.
>=20
> So I would claim, in practice requiring an occasional redeployment of
> clients and servers with fixed implementation of crypto algorithms is
> probably workable for *many* users (not all). The choices made for the
> crypto are *probably* good choices with a multi-year view, so we aren't
> suggesting something with known reasons that regular redeployments
> would
> be required.
>=20
> To me the tradeoff looks reasonable, simpler crypto code that should
> change less frequently, but in return any change will likely require a
> full redeployment of all servers and clients.
>=20
>=20
> > I don't want to sound overly negative though, the crypto abstraction
> in OpenVPN is flexible enough to support this sort of hybrid multi-
> library implementation now. At first glance, it would just require some
> tweaks to the build system, and some glue for libsodium.
>=20
> Yeah, hopefully, because crypto-box supplies almost all of the crypto
> needs, I'm hoping that it will be possible to compile out a significant
> chunk of openvpn.
>=20
> Why even both with openvpn? Well there is curvetun, which is a simple
> tun implementation using exactly the nacl library. A quick look at the
> code shows that it's 90% handling the tun device, setting things up,
> handling udp negotiations, etc, ie boiler plate. Openvpn already has
> all
> that handling for fragmenting packets, MTU, session setup, it's control
> channel, etc, that it would be no fun re-implementing all of that.
>=20
> OpenVPN with libsodium would create a kind of locked down
> implementation, with certain predefined crypto choices made for you. I
> think this has some potential benefits for many situations?
>=20
>=20
> OK, so what big picture feature did I misunderstand that TLS is
> providing that I don't get from libsodium...?
>=20

I misunderstood your wish to completely get rid of TLS. That would require =
a major overhaul in the way the control channel in OpenVPN is handled. Open=
VPN is completely centered around the idea of a TLS control channel across =
which data channel keys are negotiated. Although I'd love to see that kind =
of flexibility in OpenVPN, the code base is nowhere near ready for that. It=
's a nice challenge though :).

Another, more philosophical, question is whether the product is still OpenV=
PN after such a change. It's certainly not line-compatible with OpenVPN.

Adriaan

