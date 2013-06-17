From: Joachim Schipper <joachim.schipper@...1435...>
Date: Mon, 17 Jun 2013 09:32:35 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901455BF6C4F@...1436...>
References: <CALkG1NxZC7DT+SZHuSYemyyaH8dVsx_0PAm-7pTYY9EYMbZBgQ@...278...>
In-Reply-To: <CALkG1NxZC7DT+SZHuSYemyyaH8dVsx_0PAm-7pTYY9EYMbZBgQ@...278...>
Content-Language: en-US
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0032_01CE6B3D.9951E020"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Adding support for AEAD cipher modes (AES-GCM,
	et al.)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kenny Root <kenny@...1827...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0032_01CE6B3D.9951E020
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Kenny Root [mailto:kenny@...1827...]
> Sent: dinsdag 4 juni 2013 2:15
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] Adding support for AEAD cipher modes 
> (AES-GCM, et al.)
> 
> I wrote a patch to add AEAD cipher modes to OpenVPN. This is one of 
> NIST's recommended modes and newer Intel chips supporting the AES-NI 
> (with PCLMULQDQ) have excellent support for acceleration in this mode.
> I posted the initial version at
> https://community.openvpn.net/openvpn/ticket/301 and that ticket has 
> some of the performance numbers on an Ivy Bridge class chip.
> 
> It also doesn't appear PolarSSL has added AES-GCM to their main crypto 
> API yet.
> 
> (You can also comment at Github at
> https://github.com/kruton/openvpn/commit/a8c6701c8b47429c32da5c01f4398
> f
> 9e0b293c01)

Cool to see support for GCM in the data channel!

PolarSSL does support GCM (since 1.2, see include/polarssl/gcm.h), and
indeed OpenVPN-NL exclusively uses a GCM SSL ciphersuite in the control
channel. However, it would be very neat to also have it in the data channel,
so I looked at your patch with great interest. It's really neat, but I do
have some comments.

I don't really see the benefit of adding CCM support; I'm not aware of any
new protocol using it, since GCM is generally faster/nicer/more common, and
- on recent Intel chips - benefits from hardware support (GCLMULQDQ). That
said, it's not hard, so...

XTS seems rather unsuited for this application; it's an unauthenticated
tweakable block cipher used for disk encryption. The fact that it uses the
same API as GCM/CCM is yet another instance of OpenSSL perfectly aligning a
gun with your foot.

The prng_bytes() on src/openvpn/crypto.c:144 seems odd in various ways. I'll
continue reviewing tonight and tomorrow morning, and I'll take a good look
at this chunk of code then. (Sorry for the slow review; life and spotty
internet in the train got in the way.)

I don't understand src/openvpn/crypto.c:194 either, but I'll take another
look tonight.

Some further minor comments:

src/openvpn/crypto.c:311: MAX_HMAC_KEY_LENGTH is a rather strange name for
the length of a variable holding the authentication tag.

src/openvpn/crypto.c 322: whitespace error

src/openvpn/crypto.c 430: #ifndef ALLOW_NON_CBC_CIPHERS, we still allow
AEAD? That seems odd.

Src/openvpn/crypto_backend.h:271: "message authentication code". In general,
neither the function name nor the doxygen makes it obvious that this
function is valid only for AEAD modes.

Again, thanks for the patch! I'm no contributor, but I do think it's really
cool.

		Joachim

------=_NextPart_000_0032_01CE6B3D.9951E020
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
r+52KJflPxUC2xVI2L0EOwAAAAAAAA==

------=_NextPart_000_0032_01CE6B3D.9951E020--

