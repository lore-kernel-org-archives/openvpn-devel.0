Message-ID: <a10961760510200344k502c9249m@...278...>
From: Janne Johansson <icepic.dz@...277...>
Subject: Fwd: [Openvpn-devel] Bug report (long) - OpenVPN dropping small frames
In-Reply-To: <a10961760510200342x1cca4b9do@...278...>
MIME-Version: 1.0
References: <dj6pnr$gs4$1@...165...>
	 <Pine.LNX.4.61.0510200952100.9328@...210...>
	 <a10961760510200342x1cca4b9do@...278...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Oct 20 03:47:05 2005
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Openvpn-devel@lists.sourceforge.net

Sent only to Mathias first time. Oops.

---------- Forwarded message ----------
From: Janne Johansson <icepic.dz@...277...>
Date: 2005-okt-20 12:42
Subject: Re: [Openvpn-devel] Bug report (long) - OpenVPN dropping small fra=
mes
To: Mathias Sundman <mathias@...454...>


2005/10/20, Mathias Sundman <mathias@...454...>:
> On Wed, 19 Oct 2005, Mike Ireton wrote:
>
> > Suspeciously, I also have been observing an excessive number of ICMP "F=
rag
> > reassembly time exceeded" messages coming from this openvpn client
--8<--
> > I have a good test case right now. If I ping with 1393 bytes or more of
> > data, it doesn't work reliably. Whereas if I ping with 1392 bytes, it d=
oes
> > work reliably and without loss. Here is an example:
--8<--
> If that solves your problem, it would still be nice to understand if the
> cause were due to a broken router, or if there really is a bug
> somewhere...

Actually, this is exactly what I saw in the early days of openvpn,
when putting the traffic through an openbsd-PF gateway while using
linux clients in one or both ends
of openvpn. Since Linux hosts sends fragments with the "dont-fragment" bit =
set*,
(supposedly to investigate MTU) the firewall will detect a fragmented
packet that
has requested not to be fragmented (DF) and drops it. In my case, the openb=
sd
gw was under my control, so I could figure out that it was the "scrub"
option in PF
that followed this kind of rule, and remove it at first. Later I
decided that this would
only work until someone was behind another PF-scrubbing host and instead lo=
wered
the MTU of the openvpn traffic instead (or the tun-device, cant
remember what options
I used then), and always got the large packets through.

Give it a try to lower the MTU and see if it helps.

*) As a sidenote, I think PF does the right thing, regardless of how
useful PMTU seems
to be, a packet that requests not to be fragmented and indeed arrives
as a fragment
should be removed by my firewall, since one of its purposes is to make
sure weird
stuff dont get into my network.

--
Some mornings, it's just not worth gnawing through the straps...


--
Some mornings, it's just not worth gnawing through the straps...

