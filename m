Date: Mon, 08 Mar 2010 16:36:17 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <1268075941.2962.0@...1207...> <jwvfx4atsnq.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvfx4atsnq.fsf-monnier+inbox@...1269...> (from
	monnier@...1282... on Mon Mar  8 15:26:11 2010)
Message-Id: <1268087777.11342.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: Stefan Monnier <monnier@...1282...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On 03/08/2010 03:26:11 PM, Stefan Monnier wrote:
> > In either case we'd be looking at an openvpn configuration
> > directive (or 2) that takes a command to run once
> > the link comes up (and down).  If that was in place then
> > any of A, B, C, or D, or your choice of using an ifup/ifdown
> > script would all work.
>=20
> BTW, there are generic tools to run/stop dhcp clients (and other
> configuration steps) when the interface goes up/down.  I've used
> ifplugd
> for it, but IIUC there are others.

Come to think of it I've used ifplugd too.

Since there are multiple "right" ways it sounds like the documentation
could be extensive.  Would this be a job for the wiki, at least
initially?

FWIW http://openvpn.net/wiki/ comes up a blank page.  Is this
because I've cookies and scripts off or something?

>=20
> I think if the user just starts the dhcp client on an interface
> independently from the moment the interface goes up (or down), this=20
> is
> simply a misconfiguration.

I'm not sure I understand.  Are you saying that manually starting
a dhcp client means that the system is mis-configured because
it's not configured to do the right thing automatically?


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


