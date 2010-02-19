Date: Fri, 19 Feb 2010 10:05:02 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <4B7E53B0.9000907@...1114...> (from
	openvpn.list@...1114... on Fri Feb 19 03:02:40 2010)
Message-Id: <1266595502.31441.7@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 02/19/2010 03:02:40 AM, David Sommerseth wrote:
> On 19/02/10 04:18, Stefan Monnier wrote:

> >
> > If it's a config var, it could indeed just be a global var, so I
> don't
> > think it would be very complex.  But that's really not something=20
> the
> > user should have to configure.
>=20
> That depends on the solution we end up with.

What do you mean "configure"?

This is exactly the sort of thing that a=20

./configure --connection-limit=3D20

sort of configuration setting is good for.  Someone
might want to frob it, but does it need to be dynamically
configurable in the openvpn config file?  If you make
the default large enough for anybody then the embedded systems
people can reconfigure their binary to shrink it need be.

Regards,

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


