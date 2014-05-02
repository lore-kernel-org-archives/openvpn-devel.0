Date: Fri, 2 May 2014 17:59:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140502155925.GY16637@...1296...>
References: <535ECBB0.2060709@...1901...> <5362D3E9.3090001@...1114...>
	<5362FA6D.904@...1901...> <20140502072322.GT16637@...1296...>
	<5363B7A2.2000109@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qWJ2Nx/5wE7M/EuX"
Content-Disposition: inline
In-Reply-To: <5363B7A2.2000109@...1114...>
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
To: openvpn-devel@lists.sourceforge.net
Cc: Timothe Litt <litt@...1901...>

--qWJ2Nx/5wE7M/EuX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 02, 2014 at 05:20:02PM +0200, David Sommerseth wrote:
> - Why not re-use facilitynames[] from sys/syslog.h, instead of adding
>   something which is basically a duplicate of exactly that lookup table?

Oh, wow.  I didn't know that this exists - learned something new today.

We might have to figure out how this is portably used - I see it exists
on Linux and FreeBSD, at least, and both have it inside #ifdef SYSLOG_NAMES,
so our code might have to do

#define SYSLOG_NAMES
#include <sys/syslog.h>

or such.  Plus possibly an autoconf test to see whether it's there, and
if not, fall back to something in compat/ - that would make the change
to options.c much smaller.

> - Further, why the #ifdef's on LOG_FTP, LOG_SYSLOG, LOG_UUCP?

"Because not all systems have them", I'd say :-) - syslog facilities are
far from universal, alas.

[..]
> Using --syslog-facility is a bare minimum acceptable but not preferred.=20
> Rather consider --daemon [progname] [facility]  and --syslog [progname]=20
> [facility].  If facility is not set, default to whatever is the default n=
ow=20
> (IIRC, it is syslog).

I think it would be good to loosen the restrictions that --syslog has
to be called before --daemon, and move that to "latest option wins"
(as usual).  Haven't checked the code to see how complicated that is.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qWJ2Nx/5wE7M/EuX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU2PA3akuBuNlUUl1AQIqHAP/Z7ibocEqcSEufOtVrpjC5niQNgFdl7Gj
/lLkYTJ48ns/rEgjc6hbAHnCuGtBFwRVu7pAaTZp2HsVjhfrCYooQYIpjhf2eFa7
/YACCxzA8AL6KFstMz6d2UrGjLvoVqkKCSWWrGSsYdxNotNeBuxxNHQIqk1FxN9m
u7/nIIzyCew=
=AZ1h
-----END PGP SIGNATURE-----

--qWJ2Nx/5wE7M/EuX--

