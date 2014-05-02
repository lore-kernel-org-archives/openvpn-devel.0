Date: Fri, 2 May 2014 19:09:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140502170915.GZ16637@...1296...>
References: <535ECBB0.2060709@...1901...> <5362D3E9.3090001@...1114...>
	<5362FA6D.904@...1901...> <20140502072322.GT16637@...1296...>
	<5363B7A2.2000109@...1114...>
	<20140502155925.GY16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gj8//TX18o5otb+b"
Content-Disposition: inline
In-Reply-To: <20140502155925.GY16637@...1296...>
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

--Gj8//TX18o5otb+b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 02, 2014 at 05:59:26PM +0200, Gert Doering wrote:
> > - Why not re-use facilitynames[] from sys/syslog.h, instead of adding
> >   something which is basically a duplicate of exactly that lookup table?
> Oh, wow.  I didn't know that this exists - learned something new today.

JFTR, this does *not* exist on Solaris (which we support) or AIX (which
we do not support yet, but I'm toying with it since it recently grew
TAP support...).

It does exist on Linux, FreeBSD, NetBSD, MacOS X, OpenBSD.

MinGW/Windows does not seem to have a syslog.h at all....

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Gj8//TX18o5otb+b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU2PRO6kuBuNlUUl1AQJY0wP/ROk7y4FNH/SV5nzGX4rSdbOqpAIH+yn9
RPmQmiRfcftmzMbCceVzHY4AB8FEFGMaa7PbwLiFrlDTzZax4f5xlbDn9w8VuQiQ
GQldhll3Dt/+GfL8s0UrR3f2O0l4hE1WEvPYzJs6u9LFHIV8oFIPoAjv5QyoVzyS
iIXeEgoUYNU=
=K5Bo
-----END PGP SIGNATURE-----

--Gj8//TX18o5otb+b--

