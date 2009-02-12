Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 13:04:14 +0100
Message-ID: <499929A843E2C541A8AD31A881A2B6A202F16E79@...1006...>
In-Reply-To: <4993AA88.2030907@...41...>
References: <20090127154806.GA38604@...33...>
	<9e0cf0bf0902031016x3734b539h6b13eebd1d37aefc@...278...>
	<499929A843E2C541A8AD31A881A2B6A202EAE379@...1006...>
	<200902102124.52217.alon.barlev@...277...>
	<4993AA88.2030907@...41...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: Re: [Openvpn-devel] Patch Queue,
	was: Re: [PATCH] Fix for "Cannot read current defaultgateway"
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
To: James Yonan <jim@...41...>, Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:

> Alon Bar-Lev wrote:
> > On Tuesday 10 February 2009 13:35:35 David Balazic wrote:
> >> Ping ?
> >>
> >> Should I resend the patch without the end-of-line-spaces change ?
> >=20
> > James has his own response times.
> > I suggest you have much patience.... :)
> >=20
> > Alon.
>=20
> I apologize for not having the bandwidth to focus as much on=20
> the patch=20
> queue as I would like, but please understand that we're on=20
> the verge of=20
> releasing 2.1 and we have to be very conservative about accepting=20
> patches at this point.
>=20
> I think it's fair to ask that we try to limit ourselves at this late=20
> stage to patches that address issues that affect a large number of=20
> users, or bug fixes that are sufficiently trivial that there=20
> is little=20
> or no chance of causing unforeseen breakage.  I think there=20
> needs to be=20
> an argument for why the patch is important right now, as opposed to=20
> waiting a while for the 2.2 beta series.

Of course.

 - the bug has been reported in several instances (see my first mail)
 - the patch affects only one architecture (besides the unused parameter
on others;
I could have made different function declarations for different archs,
but that
would be less readable/maintainable IMO)
 - the patch affects only one code path, that is taken only when the bug
is triggered
 - it is simple:
   - a few lines to record the gateway interface name
   - a few lines to use it in case the gw addresss is 0.0.0.0
 - it is field tested (in a scenario which triggers the bug)

Regards,
David

