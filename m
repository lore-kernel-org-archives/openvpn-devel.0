MIME-Version: 1.0
In-Reply-To: <1445597397.4113.184.camel@...1866...>
References: <1445597397.4113.184.camel@...1866...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 26 Oct 2015 00:09:25 +0100
Message-ID: <CAA1Abx+fvhCoDNhKF44UmwZm7Xm-k_+gQ8gTCwCrw2UDtdPsDg@...278...>
Subject: Re: [Openvpn-devel] [RFC] --passtos default on/off, and IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Oct 23, 2015 at 12:49 PM, David Woodhouse <dwmw2@...1866...> wrote:
> I prefer to remain consistent with OpenVPN and other tools where
> possible, so we've renamed the option to '--passtos' and my first
> reaction was to disable it by default, like OpenVPN does.
>
> Looking at it harder, though, I'm not sure I really want it disabled by
> default. It's useful for those who run VoIP over the VPN, and quite
> frankly the information leakage is minimal =E2=80=94 if the attacker can't
> infer from those tiny packets at regular 20ms intervals that you're
> using VoIP, then they're probably clueless enough that they won't work
> it out from the QoS bits either :)

It's not just about traffic analysis, it is also about covert
channels.  An adversary on the protected network could use --passtos
(or indeed packet size / timing) to create a covert channel to the
unprotected network, thereby exfiltrating data.

> Anyone seriously suggesting that --passtos should be off by default for
> security reasons should probably also need to submit a patch to pad all
> encrypted packets to the full MTU "to prevent information leakage
> through packet sizes" before they're taken seriously. Or taken away.
> Either works for me.

"Since my tires have barely any profile left, I'll just disable the
brakes" (Yes, I know, car analogies don't really hold, but I couldn't
resist.)  Don't forget that OpenVPN in CBC mode pads packets to the
cipher block size, which is 64 bits for the default BF-CBC, and 128
bits for the popular AES-CBC.  That does help with disguising the
*contents* of your voip call (without any padding, is has been shown
to be possible to recover transcripts of actual voip calls [0]).  For
covert channels, it means 23 possible values per 1500-byte packet, or
~5 bits for BF, and 12 possible values (~4 bits) for AES-CBC. That is
still less than the 8 bits QoS/ToS.

But yes, it would be nice to add a padding mode to OpenVPN.
Especially with the upcoming AES-GCM mode, which will no longer pad
packets to block size.  Perhaps implemented as a 'compression'
algorithm?  We already have the required infrastructure in place
there.

> So actually my preferred path for "being consistent with OpenVPN" is
> probably to enable it by default in OpenVPN too... unless I'm missing
> something?

Yes, and apart from my concerns above, we should be very careful about
changing this kind of behaviour.  Suddenly bypassing more data might
get people into problematic situations.

> Also, I note that OpenVPN only supports this for Legacy IP =E2=80=94 we s=
hould
> be copying the TCLASS bits from IPv6 packets too, right?
>
> And does it also make sense to copy the TOS/TCLASS bits from IPv6
> payload into Legacy IP tunnel encapsulation, and vice versa? Despite
> the different names, are the bits expected to have the same meanings?
>
> Finally, what about ECN? Does it makes sense to copy the ECN bits? Will
> routers act upon those even for non-TCP packets, and does that then
> leave us wanting to deal with the resulting ICMP and convey the message
> back inside the VPN (which frankly fills me with horror, so let's not).

I'll leave it to the networking experts whether this makes as sense
for IPv6 as it does for IPv4.  To my untrained eye, ECN seems painful,
but something equivalent to --passtos for IPv6 might make sense.

-Steffan

[0] http://www.cs.unc.edu/~fabian/papers/foniks-oak11.pdf

