Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 10 Feb 2009 12:35:35 +0100
Message-ID: <499929A843E2C541A8AD31A881A2B6A202EAE379@...1006...>
In-Reply-To: <9e0cf0bf0902031016x3734b539h6b13eebd1d37aefc@...278...>
References: <20090127154806.GA38604@...33...>
	<9e0cf0bf0901270831l72b16993p1037df311fb50c74@...278...>
	<499929A843E2C541A8AD31A881A2B6A202DAB494@...1006...>
	<49875059.4040700@...41...>
	<499929A843E2C541A8AD31A881A2B6A202DF3E5E@...1006...>
	<9e0cf0bf0902031016x3734b539h6b13eebd1d37aefc@...278...>
From: "David Balazic" <David.Balazic@...1005...>
Subject: Re: [Openvpn-devel] [PATCH] Fix for "Cannot read current
	defaultgateway" problem on Linux
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

Ping ?

Should I resend the patch without the end-of-line-spaces change ?

Regards,
David

> -----Original Message-----
> From: Alon Bar-Lev [mailto:alon.barlev@...277...]=20
> Sent: Tuesday, February 03, 2009 7:17 PM
> To: David Balazic
> Cc: James Yonan; openvpn-devel@lists.sourceforge.net
> Subject: Re: [PATCH] Fix for "Cannot read current=20
> defaultgateway" problem on Linux
>=20
> James,
> I guess you take over.
> There are many lines that does not change anything.
> Also, maybe it would be better to have one string variable and one
> type, (gateway, device) (gateway, address), so that it would be easier
> to manage if new type comes up.
>=20
> Alon.
>=20
> On 2/3/09, David Balazic <David.Balazic@...1005...> wrote:
> > James Yonan wrote:
> >
> >  > David,
> >  >
> >  > A couple issues with the patch:
> >  >
> >  > * sscanf usage doesn't check for buffer overflow.
> >
> >  See below.
> >
> >  > * You use gw_if_name in some places and gw_ifname in other
> >  > places.  To
> >  > eliminate confusion it would be best to use a consistent form.
> >
> >  Done.
> >
> >  > Also, to reiterate, try submitting the patch as an=20
> attachment to deal
> >  > with email client munging issues.
> >
> >  OK.
> >
> >  About the sscanf:
> >  (copied from my earlier message to Alon)
> >
> > > 3. Please don't use scanf this way as it may overflow the buffer.
> >  > Use %##s and check that overflow is avoided.
> >
> >  I use "%32s\t" now.
> >  How do I check for overflow? sscanf always returns 1.
> >  Besides, the linux kernel headers declare 32 as maximum iface name
> >  length.
> >  Even in case of overflow, what shoudl I do ? Return false ?
> >  I think leaving it as is is good for 99,999% of cases and=20
> in the rest
> >  (in case of overflow), either a gateway IP address is=20
> present, so no
> >  problem, or the route add command will fail (or use the=20
> wrong device).
> >  Not perfect, but what is in these days ? ;-)
> >
> >
> > Oh, my patch removes spaces at the end of some lines. My editor did
> >  this automatically. Is that a problem ? I thought to remove it from
> >  the patch, but then the next guy to edit it will have the=20
> same problem.
> >
> >  The patch is attached.
> >
> >  Regards,
> >
> > David
> >
> >
>=20

