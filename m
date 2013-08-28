From: Joachim Schipper <joachim.schipper@...1435...>
Date: Wed, 28 Aug 2013 09:20:12 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9014B44C3159@...1436...>
References: <CALkG1NxZC7DT+SZHuSYemyyaH8dVsx_0PAm-7pTYY9EYMbZBgQ@...278...>
	<1CED409804E2164C8104F9E623B08B901455BF6C4F@...1436...>
	<1CED409804E2164C8104F9E623B08B901455BF71F4@...1436...>
	<521C46D6.7090501@...515...>
In-Reply-To: <521C46D6.7090501@...515...>
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0005_01CEA3C6.FC9EA2F0"
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
To: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------=_NextPart_000_0005_01CEA3C6.FC9EA2F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

[My apologies for any formatting issues; my employer likes Outlook.]

James Yonan wrote:
> On 18/06/2013 01:23, Joachim Schipper wrote:
> > Joachim Schipper wrote [I'm continuing my own message here]:
> >> Kenny Root wrote:
> >>> I wrote a patch to add AEAD cipher modes to OpenVPN.
> >>>
> >>> It also doesn't appear PolarSSL has added AES-GCM to their main
> >>> crypto API yet.
> >>
> >> Cool to see support for GCM in the data channel!
> >>
> >> PolarSSL does support GCM (since 1.2, see include/polarssl/gcm.h),
> >> and indeed OpenVPN-NL exclusively uses a GCM SSL ciphersuite in the
> >> control channel. However, it would be very neat to also have it in
> >> the data channel, so I looked at your patch with great interest.
> >> It's really neat, but I do have some comments.
> >
> >> The prng_bytes() on src/openvpn/crypto.c:144 [...]
> >
> > Continuing this train of thought, both GCM and CCM need non-repeating
> > (but possibly predictable) IVs. As long as net_time and net_id are
> > unique to the current packet, your code works fine; and you should
> > still have 32 bits of randomness left to guard against Bad Things
> > happening to the clock. So this code is just fine.
> >
> >> I don't understand src/openvpn/crypto.c:194 either, but I'll take
> >> another look tonight.
> >
> > After another reading, I understand just fine. Consider adding "else
> > ASSERT(outlen == 0)", but ok.
> >
> >> Again, thanks for the patch! I'm no contributor, but I do think it's
> >> really cool.
> >
> > Let me reiterate: thanks! I've just taken a quick look, but it looks
> > quite nice.
> 
> Agreed -- adding AEAD support is great.  That gives us access to AES-
> GCM, which has spectacular performance when accelerated at the CPU
> level (i.e. AES-NI).
> 
> Testing the patch with AES-GCM, the packet crypto header looks like
> this (appearing to be loosely inspired by RFC 4106):
> 
> 7e7046bd 444a7e28 cc6387b1 64a4d6c1 00000005 521c3b01 4308c041 380275a
> [             auth tag            ] [seq # ] [time_t] [random] [payload
...]
> [   used like HMAC signature      ] [   12-byte IV/nonce/AD  ]
> 
> This is running in static key mode.  The time_t field is only used in
> static key mode and is based on the daemon startup time.  It doesn't
> change unless (a) the daemon is restarted or (b) the sequence number
> field wraps around.  In TLS mode there would be a leading control byte,
> and the time_t field would be replaced by randomness.
> 
> The "12-byte IV/nonce/AD" is the "associated data" field meaning that
> it is integrity-checked but not encrypted.  This is so it can double as
> the IV.
> 
> I'm thinking there might be some possible efficiency gains here by
> building the 12-byte nonce differently for TLS mode, such as by pre-
> agreeing to 8 bytes of randomness for each key negotiation, then send 4
> additional bytes over the wire as a sequence number instead of 12.  The
> IV could be synthesized on each end by combining the sequence number
> with the 8 bytes of agreed randomness.  This would cut 8 bytes out of
> the packet because [time_t] [random] vanishes, while retaining the
> essential property that the IV never repeats for a given key.

That could work, yes, and has the advantage that TLS mode remains secure
even if the system clock goes really wonky.
 
You're probably aware of IPsec's Extended Sequence Numbers (RFC 4303 par.
2.2.1), of which 32 bits are implicitly negotiated and 32 bits are sent over
the wire. IPsec's sequence numbers are not an IV, but the GCM's IV is just
another counter, which offers some independent support for your plan.

> Can we get some more reviewers on this?

Yes, please. I wouldn't want to trust everything to one quick review by me.

> One question that applies to AEAD crypto in general and not
> specifically this patch, is what are the security implications of doing
> away with HMAC and trusting the cipher to do both encryption/decryption
> and integrity checking?  Is there general agreement in the crypto
> community that the integrity checking component of AEAD is as solid as
> encrypt-then-HMAC?  Because crypto history seems littered with the
> wreckage of attempts to pipe untrusted data directly into decryption
> algorithms.

Piping untrusted data into CBC mode, in particular, is usually disastrous;
but GCM is basically CTR mode plus a checksum, and CTR mode is a stream
cipher. Stream ciphers don't need padding and generally allow very simple
data processing, which severely cuts down on the possible side channels.

GCM is fairly well-regarded, although some people worry about side-channel
attacks. E.g.
http://blog.cryptographyengineering.com/2012/05/how-to-choose-authenticated-
encryption.html and
http://blog.cryptographyengineering.com/2011/12/matt-green-smackdown-watch-a
re-aead.html may be interesting; note that Matthew Green wrote a textbook on
cryptography, while Colin Percival is responsible for e.g.
http://www.daemonology.net/hyperthreading-considered-harmful/.

Additionally, the authentication mechanism is provably strong, but very
fragile to misuse. As pointed out in
http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/comments/CWC-GCM/Fergus
on2.pdf, any forgery allows an attacker to recover a little information
about the authentication key; in particular, short authentication tags
quickly lead to a complete compromise. (The authentication key is the
encryption of 0, i.e. compromising the authentication key breaks
authentication but does not directly break encryption.) Implementation flaws
can apparently be equally disastrous, as suggested by the abstract of
https://eprint.iacr.org/2013/157.pdf. 

In general, GCM should be fine.
 
		Joachim

------=_NextPart_000_0005_01CEA3C6.FC9EA2F0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
mrvbeC6nYf7gLvPhx8CPkwAAAAAAAA==

------=_NextPart_000_0005_01CEA3C6.FC9EA2F0--

