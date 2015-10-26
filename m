References: <1445597397.4113.184.camel@...1866...>
	<CAA1Abx+fvhCoDNhKF44UmwZm7Xm-k_+gQ8gTCwCrw2UDtdPsDg@...278...>
	<CAA1Abx+z_BmrZgR-2MFBmqFS8QK6LOeN1FDDfZSGQw1_EUgq4w@...278...>
	<1445816672.3405.17.camel@...1866...>
	<CAA1AbxLVK6r-_YKARZSOO_naqyLZXYmSj7eeUqsicX6gJ47tBg@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <562E13B4.8070501@...1227...>
Date: Mon, 26 Oct 2015 12:51:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1AbxLVK6r-_YKARZSOO_naqyLZXYmSj7eeUqsicX6gJ47tBg@...278...>
Subject: Re: [Openvpn-devel] [RFC] --passtos default on/off, and IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


> > I'm actually *more* interested in the potential for incompatibilities
> > if we start setting the TOS bits =97 as we saw with stupid firewalls
> > dropping packets when ECN was in use. That sounds like a much more
> > reasonable argument for not doing --passtos by default, although even
> > that is somewhat diminished these days =97 I think most such firewalls
> > have been fixed now.
>
> I am actually very interested in this part too, but lack the
> experience to make any statements here.  *waiting for Gert and/or Arne
> to chime in*
>
>
QoS and therefore TOS is almost not used in public network. A lot of
switches will actually reset the TOS bit to 0x00 in the default config.

But very few apps do set ToS bits anyway so for most people passtos is
probably a NOOP anyway.

And the Android (and iOS?) apps will not do passtos anyway, since
setting TOS requires root capabilities (another reason that tos is not
used).

Arne



