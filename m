Subject: Re: [Openvpn-devel] OpenVPN multi instancing
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078182908.84967@...41...>
In-Reply-To: <Pine.LNX.4.58.0403011637070.30913@...136...>
References: <twig.1078170122.8125@...41...>, <twig.1078170122.8125@...41...>
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
Date: Mon Mar  1 15:20:06 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Nelson <jnelson-openvpn@...135...>, James Yonan <jim@...41...>
Cc: Christian Daniel <cd@...154...>, openvpn-devel@lists.sourceforge.net

Jon Nelson <jnelson-openvpn@...135...> said:

> 
> On Mon, 1 Mar 2004, James Yonan wrote:
> 
> > Christian Daniel <cd@...154...> said:
> >
> > > Hello everybody!
> > >
> > > For a student research project I'm trying to add multi instance
capability to
> > > OpenVPN. The basic idea is to rip the main openvpn()-function apart, put all
> > > variables in a struct and then have only one select()-call for all open
> > > tunnels at once.
> >
> > It's already been done :)
> >
> > See the BETA20 branch in the CVS.
> >
> > Having said that, I think it's great that you want to contribute to the code,
> > and there's still a lot of work yet to be done.
> >
> > > Then there should be one unix-socket which can be connected by some
> > > to-be-written control-application, which manages the tunnels. In detail it
> > > should be possible to add and remove tunnels on demand just by sending the
> > > appropriate config down that unix-socket.
> > >
> > > Each tunnel should have it's own tun/tap-device open - the linux kernel
has no
> > > problem to cope with so many interfaces... I don't think, that it's a good
> > > idea, to create only one tun-device and then have some kind of internal
> > > routing-engine...
> >
> > The current plan for 2.0 is to also handle the case of multiple tunnels
> > through a single tun/tap interface.  This will scale better overall, and will
> > be necessary on some platforms such as Windows which cannot efficiently handle
> > a large number of tun/tap interfaces.
> 
> >From a security or network partitioning point of view, having each
> "network" only accessible via *one* interface greatly simplifies things.
> Honestly, I couldn't care less about Windows, especially if supporting
> it impacts the usability and security of the software in a negative way.
> What is a "large" number of tun/tap interfaces, anyway?
> 
> Maybe I'm not understanding something, but isn't OpenVPN all about
> building Virtual Private Networks?  Firewalls other programs can (do,
> and sometimes must) specify the interface name over which they
> communicate -- having one tun/tap for more than one "network" just
> sounds very bad.  Maybe you can explain it to me.

One virtual interface per tunnel is supported now and will be supported going
forward.

Many tunnels through a single virtual interface is a feature that will be
interesting for certain kinds of applications.  Suppose you want a VPN that
links N networks, where communication between any two networks takes a direct
path (not through a central server).  This model is much easier to manage with
a point-to-multipoint interface, and can scale to thousands of nodes.  If you
try to build this out of point-to-point tunnels, you end up having to manage
(N*(N-1))/2 tunnels.  With point-to-multipoint tunnels, you only need N of them.

James


