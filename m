Date: Thu, 11 Mar 2010 18:18:15 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...> <4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...> <4B991541.3060603@...1147...>
	<20100311192119.GM25238@...1296...>
	<jwvy6hybicq.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvy6hybicq.fsf-monnier+inbox@...1269...> (from
	monnier@...1268... on Thu Mar 11 16:42:07 2010)
Message-Id: <1268353095.5095.2@...1207...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 03/11/2010 04:42:07 PM, Stefan Monnier wrote:
> >> Let's not add more complexity to openvpn itself, I'd be much
> happier if=20
> > You just don't understand.
> > The complexity *WILL* be in OpenVPN, if we decide to support
> > "route-gateway dhcp" for non-Windows platforms.
>=20
> I'm not sure what "route-gateway dhcp" does, so maybe that's part of
> the
> reason why we disagree.

I don't think that's the problem.  Route-gateway dhcp makes the
openvpn server into a dhcp gateway so a remote dhcp server
can be used to configure the local VPN interface.  Right?

(It suddenly occurs to me that you probably don't want
the entire local lan using the remote dhcp server,
unless you do.)

  I thought the discussion was about how to
> make
> DHCP work over an OpenVPN bridge (i.e. a TAP device) under systems
> like
> GNU/Linux.  On those systems, the only thing you need to do is to=20
> make
> sure that things like ifplugd correctly receive the info about when
> the
> tunnel goes up and down.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


