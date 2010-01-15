Date: Thu, 14 Jan 2010 21:45:05 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100115001558.15125.qmail@...1287...> (from peter@...1287... on
	Thu Jan 14 18:15:58 2010)
Message-Id: <1263527105.29484.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RFE: allow 'lport 0' setup for random port
 binding
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

On 01/14/2010 06:15:58 PM, Peter Stuge wrote:
> Let's try some more.
>=20
> Karl O. Pinc wrote:
> > > no; it is because the OpenVPN client creates the same src + dst
> pair
> > > for every connection.
> >=20
> > Enrico is right.  It's in the IP RFC, the 2MSL (twice the maximum
> > segment lifetime) rule.  (STD 5 is the right rfc?)

> My point is that a "stateful" firewall should keep more info about
> connections than just a 4-tuple. The firewall that is causing Enrico
> trouble seems to not do this, since it does not recognize a new
> connection if uses the same 4-tuple. To me, that actually sounds like
> the textbook definitition of a _stateless_ firewall. :)

Please read the RFC.  A TCP connection should not re-use the 4-tuple
for a limited interval of time after connection close.  A corollary,
which is only clear once you understand the purpose of this
restriction, is that a good firewall should interpret violations
of this rule as an attempt to inject data into the closed
TCP connection and should block such traffic.

Note that Microsoft TCP stacks have been known to violate this rule.
This is no excuse; it's an indication that the stack should not
be relied on to perform in a standards compliant fashion.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


