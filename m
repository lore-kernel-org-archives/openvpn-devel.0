Date: Thu, 1 Dec 2016 09:05:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201080505.GD78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<1480558511.253304921@...2201...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <1480558511.253304921@...2201...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: SviMik <svimik@...450...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 01, 2016 at 05:15:11AM +0300, SviMik wrote:
> While I admit that it is *extremely* unlikely to have a network larger th=
an /8, such logic still looks a little clumsy. It does not cover all the va=
lid netmasks neither it detects all possible invalid ones.

This is true, but not really relevant.  Right now, it will just do funky
things, and there is no indication in the logs where to look.

Nobody uses non-contiguous netmasks these days (like "240.0.255.0"),
so everything *normal* starts with a string of 1-bits, and a valid IPv4
address never starts with 1111xxxx, so checking for "255." at the start
of something that could be "a netmask or a remote IPv4 address" will
get it right in about all cases we care about.

If someone insists on doing a /7 on their tun interface, they better
know really well what they are doing.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYP9mwAAoJEB2Cnv7KVigSsAgL/AtGkljS0IxUioMowo6RGGGS
pMvwZ9LA/tkOxgR9dOASrv33GJDsja+l6elYQlKp6l8ASgjlz0C+WeFJmsg/Wx8u
hkeWhQR04MVUStvM9y64yrbKsqttXAU4g1HOTKgVzhyQc/LH5iQfEv+WBErj25of
0Oil6EIE++ZPgu6ll+aB7Q0ZqRYc8645A/nKkPyR22RyGRRXchHP5SN78AuywKaI
5urWU7OUSlZWcyIXen/tvSISj19P63/4I0Pvmg65XeYQr1Gr/aXH9j1L9N1Yqhfj
q9vYWc76EIL8jkoquh+tmJZwe0iG0DMgJKPo6LKleddDkKYJbFnwI8rSsuqvxfJf
zntFdZp1MqzgvmDq73ikTUPIw1rc374i0z/5C2NuosZaWEVsiXEqQI2OTKM8N1xN
9uQH3DzcEeCzD7UMSbsT94s+sEH1CrDHrvodBahv8YbbqKy/7nJdvMrXf3oNnvQG
swYssjjof9ZIQdPX7I1gF0CvKhrfmISHOPh4JR9m5Q==
=QWVA
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

