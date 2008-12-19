Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 19 Dec 2008 15:31:50 +0100
Message-ID: <499929A843E2C541A8AD31A881A2B6A202AC7666@...1006...>
In-Reply-To: <494AA65E.8080002@...1171...>
References: <49481A94.5080502@...277...>	<49482A15.3030004@...453...><4948EFA4.4070409@...1171...>	<4948F28A.8030203@...453...><4948FE4F.4090408@...1171...>	<494901B1.7080702@...453...><4949F39E.30502@...1171...><499929A843E2C541A8AD31A881A2B6A202A7118C@...1006...><494A0706.6090306@...453...>
	<494A34FE.2080708@...277...> <494A3638.8090809@...1171...>
	<499929A843E2C541A8AD31A881A2B6A202A7155A@...1006...>
	<494AA65E.8080002@...1171...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: [Openvpn-devel] Fix for "Cannot read current default gateway"
	problem on Linux
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
To: Antonis Tsolomitis <atsol@...1171...>
Cc: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hi!

In the diff (agains 2.1_rc15) is the solution for the old*
problem of (not) detecting default gateway on linux systems
if it is a device route.

The patch is attached as a gzipped diff output to this mail message :
http://thread.gmane.org/gmane.network.openvpn.user/25117/focus=3D25127

(direct link to patch :
http://cache.gmane.org//gmane/network/openvpn/user/25127-001.bin
rename to patch.gz after download)

It was tested by one affected user (Antonis Tsolomitis, see the
thread "openvpn and ppp" on the openvpn-users list)

If I forgor anything, ask.

Regards,
David

*See mail list threads:
"Redirect-gateway on dialup"
 <http://thread.gmane.org/gmane.network.openvpn.user/20407>
"redirect-gateway + http-proxy + ppp problem"
 <http://thread.gmane.org/gmane.network.openvpn.user/20994>
"Cannot redirect gateway after pppd connection"
 <http://thread.gmane.org/gmane.network.openvpn.user/23972>
"openvpn and ppp"
 <http://thread.gmane.org/gmane.network.openvpn.user/25117>


> -----Original Message-----
> From: Antonis Tsolomitis [mailto:atsol@...1171...]=20
> Sent: Thursday, December 18, 2008 8:37 PM
> To: David Balazic
> Cc: Antonis Tsolomitis; openvpn-users@lists.sourceforge.net
> Subject: Re: [Openvpn-users] openvpn and ppp
>=20
>=20
> Dear David, this binary works!! Here is the link to the full log.
>=20
> http://myria.math.aegean.gr/~atsol/tmp/openvpnxs.log.gz
>=20
> I will also try it in a few more configurations. I will try=20
> to use your=20
> patch to see if I can make an rpm.
>=20
> Thank you for the help both you and Erich.
>=20
> I will post again when I test in other machines with different=20
> configurations.
>=20
> thanks again,
>=20
> Antonis.
>=20
>=20
> David Balazic wrote:
> > Hi!
> >
> > For the devs here is a patch.
> >
> > For you, here is  http://home.amis.net/dbalaic/openvpnxs.gz
> >
> > Try it instead of the old openvpn:
> >
> > wget http://home.amis.net/dbalaic/openvpnxs.gz
> > gzip -d openvpnxs.gz
> > ./openvpnxs --conf add the usual parameters here=20
> > # do not put --conf twice ;-)
> >
> > Set full logging and send the logs in case id does not work.
> > Send them even if it works ;-)
> >
> > Regards,
> > David
> >
> >
> >=20=20=20
> >> -----Original Message-----
> >> From: Antonis Tsolomitis [mailto:atsol@...1171...]=20
> >> Sent: Thursday, December 18, 2008 12:39 PM
> >> Cc: openvpn-users@lists.sourceforge.net
> >> Subject: Re: [Openvpn-users] openvpn and ppp
> >>
> >> Antonis Tsolomitis wrote:
> >>=20=20=20=20=20
> >>>>> --route-gateway has nothing to do with your problem.
> >>>>>
> >>>>> It can not help. (see the manual)
> >>>>>=20=20=20=20=20
> >>>>>=20=20=20=20=20=20=20=20=20=20=20
> >>>> You appear to have deeper insight in the route-gateway=20
> >>>>=20=20=20=20=20=20=20=20=20
> >> directive than I
> >>=20=20=20=20=20
> >>>> do. The manual is pretty terse on this aspect. Could you=20
> elaborate?
> >>>>=20=20=20=20=20=20=20=20=20
> >> I verify that --route-gateway does not work. It produces the=20
> >> same error=20
> >> and does not manage to change the gateway (traceroute shows=20
> >> the original=20
> >> gateway)
> >>
> >> So it seems that we reached a dead end with respect to=20
> >> "redirect-gateway=20
> >> def1".
> >>
> >> Erich, I do not think that my situation is special in any=20
> >> sense. I use=20
> >> one of the well known distributions (Mandriva) (I promise to=20
> >> try it on=20
> >> Fedora too and report back) and I just want to connect to the=20
> >> Internet=20
> >> with ppp (simple dialup). I do not see why this setup is special.
> >>
> >> I am not a programmer (I am a Mathematician), so I can not=20
> >> make a patch.=20
> >> If I knew how to program I would do it of course.
> >>
> >> Are the developers members of this list? Do I have to make a=20
> >> bug report?
> >>
> >> Finally, I would like to ask if it is possible to make a=20
> >> script to fix=20
> >> routing manually. How can this be done?
> >> I know how to find the Gateway. What are the proper=20
> ip/route commands?
> >>
> >> thank you for your help,
> >>
> >> Antonis.
> >>
> >>
> >> --------------------------------------------------------------
> >> ----------------
> >> SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las=20
> >> Vegas, Nevada.
> >> The future of the web can't happen without you.  Join us at=20
> >> MIX09 to help
> >> pave the way to the Next Web now. Learn more and register at
> >> http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009
> >> .visitmix.com/
> >> _______________________________________________
> >> Openvpn-users mailing list
> >> Openvpn-users@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/openvpn-users
> >>
> >>=20=20=20=20=20
>=20
>=20

