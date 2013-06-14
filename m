From: Joachim Schipper <joachim.schipper@...1435...>
Date: Fri, 14 Jun 2013 10:47:23 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9014555DB21A@...1436...>
References: <51B8CE21.6080203@...515...>
In-Reply-To: <51B8CE21.6080203@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN Versioning
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
To: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

From James Yonan <james@...515...>:
> TLS Protocol
> ------------
>
> Since day 1, OpenVPN has used TLS 1.0 as a control channel and key
> exchange mechanism.  But now we have TLS 1.1 and 1.2, each of which
> addresses significant shortcomings in its predecessor.  Fortunately,
> SSL/TLS already includes dynamic version negotiation.  So I've put
> together a patch that leverages on this, by allowing OpenVPN client
> and server to negotiate the TLS version and use the highest version
> supported by both peers.  The patch also adds a new directive "tls-
> version-min" that allows either client or server to specify a minimum
> required TLS version from the peer.
>
> https://github.com/jamesyonan/openvpn/commit/6ee8faade224cc346d67a7f17
> 1
> 6df4012782999a

Some comments on the design and implementation here. (I've just looked at t=
he code, not tested it.)

I'm confused by your comments about TLS/SSL versions used. Our own builds u=
sing PolarSSL do negotiate TLSv1.1 and TLSv1.2 between themselves and when =
interoperating with OpenSSL, logging "Control Channel: TLSv1.1, cipher XXX"=
 or even "Control Channel: TLSv1.2, cipher XXX". In general, the highest ve=
rsion supported by both client and server is used, as is normally the case =
with SSL. However, stock Ubuntu OpenVPN seems to negotiate TLSv1. Huh?

I'm not sure what purpose the "or-highest" serves. Clients already connect =
with the newest protocol supported by both client and server; if you want t=
o run a TLSv1.2-only network, just set min-version to 1.2 on the server. If=
 you're an especially competent and paranoid user, you might want to set mi=
n-version on the client, but in that case you hardly need an "or-highest", =
since you know which cipher suites your client supports.

Some of the whitespace looks odd/wrong.

Does the change to key_state_ssl_init() do anything?

The variables polar_{major,minor} in ssl_polarssl.c should be renamed, prob=
ably to something like ssl_{major,minor}_version - it's not a PolarSSL vers=
ion.

The switch(tls_version_min) needs a default case, just compile the first ca=
se/default: unconditionally.

> OpenVPN Protocol
> ----------------

> [Handshaking] could be used to negotiate other protocol capabilities
> such as cipher and HMAC digest:
>
>    IV_CIPHER=3DBF-CBC,AES-128-CBC
>    IV_AUTH=3DSHA1,SHA256,SHA512
>
> (...) There
> is also the issue of the size of the Client Capabilities List.  The
> IV_CIPHER and IV_AUTH lists might grow to be quite long (...) To
> reduce the size, we might
> consider:
>
> (a) use a single character designation for ciphers and HMAC digests,
> such as:
>
> Cipher Codes:
>   A : BF-CBC
>   B : AES-128-CBC
>   . . .
>
> Then communicate IV_CIPHER using the cipher codes:
>
>    IV_CIPHER=3DAB
>
> This would require that the OpenVPN Project standardize on set of
> codes for ciphers and HMAC digests.

This is a good idea in general, but why not use SSL cipher suites (which al=
ready have standardized binary representations)? That has the added advanta=
ge of itting AEAD suites like AES-GCM, which are getting more important. (W=
e may need to add some, but note that the { 0xff, X } "namespace" is availa=
ble for "local and experimental" cipher suites.)

Negotiating ciphers might be fatal in some configurations that were a bad i=
dea to begin with. E.g. if you use OpenVPN with a static key and --auth non=
e (which is a bad idea!), adding this negotation could allow an attacker to=
 set the cipher to none or, more dangerously, to a very weak cipher like DE=
S (provided it is mutually supported). An attacker could then bruteforce th=
e key and use his knowledge of 56 bits of the key to attack stronger protoc=
ols like AES or 3DES. (Or do we only negotiate in SSL mode? I must admit to=
 being fuzzy on the non-SSL mode.)

                Joachim

