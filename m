Date: Tue, 09 Mar 2010 10:16:10 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <jwvhbopioq5.fsf-monnier+inbox@...1269...> (from
	monnier@...1268... on Tue Mar  9 08:01:32 2010)
Message-Id: <1268151370.24740.3@...1207...>
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
To: Stefan Monnier <monnier@...1268...>
Cc: openvpn-devel@lists.sourceforge.net, Peter Stuge <peter@...1287...>

On 03/09/2010 08:01:32 AM, Stefan Monnier wrote:
> > bring the interfaces up
> > start dhcp client (if not triggered directly from the interfaces)
> > start openvpn
>=20
> That is a misconfiguration in my book.  The only correct=20
> configuration
> is when the dhcp client is triggered from the interface.  After all,
> openvpn may take half an hour to get the connection and it may lose
> the
> connection at some point and reconnect to another openvpn server (via
> round-robin DNS, for example) which might require a reconfiguration=20
> on
> the dhcp side.

My understanding of dhcp is that the client is supposed to=20
automatically reconfigure on lease expiration or whenever
the link goes up and down.  There's no reason to
restart a dhcp client just to connect to another dhcp
server because dhcp should also do this automatically.

I suppose it's possible that there are dhcp clients
that exit when the link goes down and must be restarted
but I don't know of any.  Then again I don't have
experience with various client implementations.
But it would seem kind of odd, having to restart
the dhcp client just because somebody unplugged
an ethernet cable.

The only reason why we're talking about restarting
dhcp clients in the first place is so that they
autodetect newly created tap devices.  If the
dhcp client is configured with the tap device, or once
it detects the tap device and the tap device stays
existent, all the dhcp clients I know of should just
be able to keep running and do what's needed as
links go up and down and dhcp servers come and go.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


