Date: Wed, 28 Apr 2010 10:42:53 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100427105843.9402.qmail@...1287...> (from peter@...1287... on
	Tue Apr 27 05:58:43 2010)
Message-Id: <1272469373.25907.5@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Unpackaged Windows binaries (Was: Re:
 [Openvpn-users] [ANN] OS X packages - OpenVPN 2.1.1)
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
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/27/2010 05:58:43 AM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > IMO OpenVPN is encouraging bad practices by supplying packages for
> > distros that include OpenVPN.
>=20
> Ideally the package for that distro as made by OpenVPN is always
> equivalent to the one made by the distributor.

I'm writing again in case someone thinks this is a reason why it's
fine for an end-user to get their OpenVPN from openvpn.net.

The problem is not the initial package installation.  It's
keeping up with changes over time.  That's the big
service that distro's provide.  Installing a single non-distro
application is no big deal.  More than a few become a problem
to keep up with to the point where eventually things stop
working.  Packages makes it easier to keep track of what's
what and keep things updated, in comparison to ./configure;
make; make install, but the point of diminishing returns
is soon reached regardless.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


