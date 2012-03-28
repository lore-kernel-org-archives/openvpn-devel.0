Date: Wed, 28 Mar 2012 19:20:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120328172024.GI1359@...1296...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
	<CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QL7GpiDjsJ+k4pJB"
Content-Disposition: inline
In-Reply-To: <CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
	contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--QL7GpiDjsJ+k4pJB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 28, 2012 at 09:03:44AM -0400, Jonathan K. Bullard wrote:
> I've looked into this a bit more, and have found that where the options a=
re
> actually used, argv_printf() is called to parse the command line into an
> argv structure. argv_printf uses parse_line() to do the actual parsing, a=
nd
> parse_line() processes single- and double-quotes and backslashes. I
> think that when options.c __checks__ an options command arguments, it
> should accept exactly the same input as the part of OpenVPN that __uses__
> the option's commands.

Cool :-) - thanks for investigation, I have learned something new today
(I have copy-paste used the argv_sprintf() stuff, but not fully investigated
what it does).

> Attached is a heavily revised version of my original patch. It uses
> argv_printf() to __check__ an option's commands, so it accepts exactly the
> same input as the parts of OpenVPN that __use__ the options' commands.=20

As already noted by Fabian, the "gc" stuff is not needed, and you need
an argv_reset() call - but other than that, this looks close to inclusion,
I'd say :-)

> It
> also makes all the relevant changes suggested by Gert except having the
> argument following --iproute checked. The --iproute code is handled
> differently than the other options, and I think it is OK that we don't do
> checking in 2.3 on something that wasn't checked in 2.2 and (apparently)
> might go away sometime soon.

Makes sense.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QL7GpiDjsJ+k4pJB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3NIWKkuBuNlUUl1AQLszgP+OeTnXM0OokIZKgaF4/DIUCiHi5CzEIcN
jr53MJZoWPhWW6cZbgp1eiXtZbjMb01HA9UkMPoVj5YBQwwukwYOvNOObDPsymAN
+gZkc/l14LkYwoH8i7nH3+bDuKBgf7DHGr2lHQHSGrbyL/HdIMFTIbDPR48DQUWV
756W9PvtwP0=
=jKh2
-----END PGP SIGNATURE-----

--QL7GpiDjsJ+k4pJB--

