Date: Fri, 2 May 2014 14:26:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140502122636.GX16637@...1296...>
References: <535ECBB0.2060709@...1901...> <5362D3E9.3090001@...1114...>
	<5362FA6D.904@...1901...> <20140502072322.GT16637@...1296...>
	<53638C45.6000405@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wg38NMEwLGwXVchj"
Content-Disposition: inline
In-Reply-To: <53638C45.6000405@...1901...>
Subject: Re: [Openvpn-devel] [Openvpn-users] [PATCH] Add support for
	specifying the syslog facility, as requested  in trac #188.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--Wg38NMEwLGwXVchj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 02, 2014 at 08:15:01AM -0400, Timothe Litt wrote:
> >(why is this being discussed on -users?  Taking it over to -devel)
> Er, I did post it to -devel, and I don't see any discussion of it on=20
> -users...I just double-checked the archives, and it's all in -devel...

The mail I replied to went to -users, and only there...

> >  --syslog-facility should be more clean, like
> >
> >  --sysloc-facility facility [progname]
>
> --daemon and --syslog already control syslog's program name. Since we=20
> would have to support the
> existing usages, your suggestion to add that to --syslog-facility would=20
> add complexity, not simplify things.
> You really don't want that.

Then let's not do that.  Fine with me :-)

> >  intermixing
> >option argument "A" and "B" in the same string is not going to help anyo=
ne.
> Sorry that you don't like my accommodation for init scripts.  It helps=20
> OpenVPN and its USERS.

"Helping init scripts" is actually something that only helps distribution
builders, and they are few, and usually listen quite well if we tell them=20
what needs to be adjusted.

"Having unmaintainable code inside OpenVPN" is something that does not
help anyone - people will forget why it is the way it is, break it when
changing something else, and that will cause endless pain.  We've been
through that right now when rewriting socket.c to properly support
dual-stack systems, breaking *some* bits of SOCKS proxy support in the
process, breaking --inetd in the process, and so on - so we know all
about non-intuitive options and hard-to-maintain code.

[..]
> >the last one really makes me want to throw up.
> Yes, it's ugly.   And my stomach rumbles too.

So do not write such code, and do not expect us to merge it.

> If OpenVPN were engineered from scratch, --daemon would just daemonize,=20
> --syslog would control the syslog program name and facility, and the two=
=20
> could be used together.  And there wouldn't be silly ordering=20
> constraints among the options.  But that's not the way the existing code=
=20
> -- and customers' config and distros' init files -- work.

Then let's fix *that* problem (the ordering constraints), instead of adding=
=20
more convolutions.  That would indeed help "OpenVPN and the users".

> This is the real world, and sometimes we have to live with ugly. Even if=
=20
> it makes us a little queasy.

No :-) - it's open source world, and since everyone can see what we do,
we're not going to add more ugliness if we can avoid it.

Closed source works differently.

[..]
> So it has to be something that can be embedded anywhere in the string,=20=
=20
> And that means delimiters on both ends.

"Anywhere in the string" is a hard "no".

[..]
> I didn't ignore it for 2 years, and I didn't let aesthetics get in the=20
> way of the best solution that I could come up with.

Yeah,  I understand that the amount of free time we can give into OpenVPN
is annoying you.  It's annoying me as well that I have spend time in=20
paid-for projects not related to OpenVPN to help feed my family, or that
David had to tune down his involvement into OpenVPN due to health reasons.

The amount of cleanup we've done in the last two years is quite enormous :-)
- even if it's not really visible outside of the git log.

[..]
> >Feature-NAK
> If you don't want the feature, why did you write in Trac #188:

I'm fine with the addition of a way to set the syslog-facility, but not=20
the way it is presented.  Not intermixing stuff in other stuff in=20
arguments.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Wg38NMEwLGwXVchj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU2OO/KkuBuNlUUl1AQKeRAQAk5yYBGt+s8ks2tr5w3XGnO3G072ue4Xs
C5zE0B8mwSQC2zQcG0iThSlcMdJhdjr3pKK5CqSi6+2W9hHbRVo0kW8ToPhZ/qe0
p62svbWjyzWOu+PV2fdKlncFpFz5rwKLFkNEcicaU3H2x4OV4e99mEF35Tya5DF/
GM14WnbGktI=
=RrYL
-----END PGP SIGNATURE-----

--Wg38NMEwLGwXVchj--

