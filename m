From: Joachim Schipper <joachim.schipper@...1435...>
Date: Tue, 18 Jun 2013 09:23:33 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B901455BF71F4@...1436...>
References: <CALkG1NxZC7DT+SZHuSYemyyaH8dVsx_0PAm-7pTYY9EYMbZBgQ@...278...>
	<1CED409804E2164C8104F9E623B08B901455BF6C4F@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901455BF6C4F@...1436...>
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Kenny Root <kenny@...1827...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Joachim Schipper wrote [I'm continuing my own message here]:
> > -----Original Message-----
> > From: Kenny Root [mailto:kenny@...1827...]
> > Sent: dinsdag 4 juni 2013 2:15
> > To: openvpn-devel@lists.sourceforge.net
> > Subject: [Openvpn-devel] Adding support for AEAD cipher modes
> > (AES-GCM, et al.)
> >
> > I wrote a patch to add AEAD cipher modes to OpenVPN.
> >
> > It also doesn't appear PolarSSL has added AES-GCM to their main crypto
> > API yet.
> >
>
> Cool to see support for GCM in the data channel!
>
> PolarSSL does support GCM (since 1.2, see include/polarssl/gcm.h), and
> indeed OpenVPN-NL exclusively uses a GCM SSL ciphersuite in the control
> channel. However, it would be very neat to also have it in the data
> channel, so I looked at your patch with great interest. It's really
> neat, but I do have some comments.

> The prng_bytes() on src/openvpn/crypto.c:144 seems odd in various ways.
> I'll continue reviewing tonight and tomorrow morning, and I'll take a
> good look at this chunk of code then. (Sorry for the slow review; life
> and spotty internet in the train got in the way.)

Continuing this train of thought, both GCM and CCM need non-repeating (but
possibly predictable) IVs. As long as net_time and net_id are unique to the
current packet, your code works fine; and you should still have 32 bits of
randomness left to guard against Bad Things happening to the clock. So this
code is just fine.

> I don't understand src/openvpn/crypto.c:194 either, but I'll take
> another look tonight.

After another reading, I understand just fine. Consider adding "else
ASSERT(outlen =3D=3D 0)", but ok.

> Again, thanks for the patch! I'm no contributor, but I do think it's
> really cool.

Let me reiterate: thanks! I've just taken a quick look, but it looks quite
nice.

                Joachim

