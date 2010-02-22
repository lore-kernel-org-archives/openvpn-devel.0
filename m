Date: Mon, 22 Feb 2010 11:16:19 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100222165217.13658.qmail@...1287...> (from peter@...1287... on
	Mon Feb 22 10:52:17 2010)
Message-Id: <1266858979.5921.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Do not randomize resolving of IP
 addresses in getaddr()
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
To: openvpn-devel@lists.sourceforge.net

On 02/22/2010 10:52:17 AM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > Someone may be relying on the behavior but, at the moment
> > or depending on present dns circumstances, does not have
> > multiple A records returned.  In this case no warning will
> > be generated.
>=20
> The flip side of that coin is also valid I think.
>=20
> Consider independent configuration of VPN and DNS. Early errors would
> restrict VPN setup and possibly shipment until after DNS has been set
> up, while lazy evaluation allows DNS changes to happen later.

Right, but there's nothing to "restrict" because in this case we're
talking about a warning not an error; generating a warning that default
behavior will change in a future release.  OpenVPN _should_=20
continue happily along its way no matter where
the warning is generated.

It's a pretty trivial point really, but may provide a template
for future changes.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


