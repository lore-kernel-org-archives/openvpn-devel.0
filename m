Subject: Re: [Openvpn-devel] Re: [Openvpn-users] Windows tun driver
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063741646.19515@...41...>
In-Reply-To: <20030915223948.GB25016@...33...>
References: <946499570EB7294690F512C1EF182F881EB893@...102...> <twig.1063664530.85975@...41...>, <twig.1063664530.85975@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep 16 12:53:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Mon, 15 Sep 2003, James Yonan wrote:
> 
> > Yes, this is a problem.  For OpenBSD to talk to Windows over OpenVPN, we need
> > either a tun driver for Windows or a tap driver for OpenBSD.
> > 
> > My guess is that the easier and better solution would be to solve the tap on
> > OpenBSD problem, rather than the tun on Windows problem.
> 
> I'd like to challenge the "better" claim:

I mean "better" only in the sense of simpler configuration -- i.e. not needing
to set up a WINS server to make cross-subnet browsing work.  I agree that tun
is more scalable, secure, etc.

> The tap driver gives full ethernet tunnelling, so the Windows box gets
> to choose the IP, gets ARP traffic tunnelled and all that. That's pretty
> much power IMO.
> 
> The tun driver, in contrast, only works for a specific IP, if the
> Windows box chooses another one, it's not getting any traffic back.
> 
> I consider this a security relevant choice, if I have "half-trusted"
> users, tap isn't really an option.

I would agree that tun is a better choice for less than fully-trusted users.

> Background for the challenge is that OpenVPN might be useful as an
> additional security layer on top of WLAN-WEP, but tap somewhat defeats
> the purpose.
> 
> > I think that Windows users are going to prefer a tap interface anyways,
> > because it carries the kind of traffic and protocols which Windows
> > applications generate, such as broadcast traffic and non-IP protocols.
> 
> I for one don't need Windoze broadcast traffic gated, and "my" Windows
> boxes hardly generate non-IP traffic. IPX or NetBEUI drivers aren't
> installed on the Windows machines I maintain. ARP isn't needed. Granted,
> if you need IGMP, you'll want tap, but I'd guess that the SMB browsing
> can deal with most of the "problems".

I totally agree that a tun driver for Windows would be nice to have.  In fact
I would guess that the TAP-Win32 driver might even be close to the task, if
you could figure out the right DDK magic to export a point-to-point WAN
interface that binds to IPv4 instead of 802.3.  Interested in doing some
driver development?

James


