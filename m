Date: Mon, 01 Mar 2010 06:49:04 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <20100228145001.GM9556@...1296...> <1267416790.30675.3@...1207...>
	<20100301075446.GV9556@...1296...>
In-Reply-To: <20100301075446.GV9556@...1296...> (from
	gert@...1296... on Mon Mar  1 01:54:46 2010)
Message-Id: <1267447744.30675.9@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
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
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/01/2010 01:54:46 AM, Gert Doering wrote:
> Hi,
>=20
> On Sun, Feb 28, 2010 at 10:13:10PM -0600, Karl O. Pinc wrote:
> > So, you should not need to do the ifconfig at all unless you're
> > interested in tap functionality or there's other odd
> > frobbing going on.
>=20
> You need ifconfig to set an IP address :-) - which might be=20
> considered
> "odd frobbing", but people seem to value it somehow ;-)

:)

> *That* part is easily understood - the interesting question is why
> OpenVPN
> does do_ifconfig/open_tun for OpenBSD and open_tun/do_ifconfig for
> NetBSD.
>=20
> (As a side note: are you running an OpenBSD system and could test the
> OpenVPN IPv6 payload stuff there?)

I am, but there's no IPV6 going on so unless there's a test suite
to run (somehow) I couldn't test.  It would probably also take
me a while to get to it because at the moment all my OpenBSD boxes
are in production.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


