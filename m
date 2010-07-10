Date: Sat, 10 Jul 2010 12:29:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100710102921.GZ361@...1296...>
References: <4C3843A5.50700@...1388...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="II8oT75hj15qngTC"
Content-Disposition: inline
In-Reply-To: <4C3843A5.50700@...1388...>
Subject: Re: [Openvpn-devel] feat_ipv6_payload problems on Solaris 10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michal Ludvig <mludvig@...1388...>
Cc: openvpn-devel@lists.sourceforge.net

--II8oT75hj15qngTC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 10, 2010 at 09:55:49PM +1200, Michal Ludvig wrote:
> I'm having a problem with feat_ipv6_payload branch (checked out from git=
=20
> yesterday). One end is Solaris 10 (sparc) and the other end is Linux.

Which version of the tun driver are you using for Solaris?

My test solaris machine (Solaris 10 on Sparc64, but not the very latest
version) uses the driver from http://www.whiteboard.ne.jp/~admin2/tuntap/
and IPv6 works fine there.  The web page says that this driver did not
support IPv6 before 11/16/2009 - so maybe this is the problem.


I am not using point-to-point tun but point-to-multipoint tun, but from
your logs, ptp tun should work just fine - and I'm happy to see someone
test p2p tun mode :-).  From the interface setup side of things, there
should not be a difference between "p2mp client on solaris" and "one
end of a p2p tun on solaris" anyway.


So - if you could make sure that you have the very latest tun driver,
and it still doesn't work, I'm happy to help you debug this, as it
really should work.  These days I'm fairly busy so it might take
a few days, though.  (Just as an advance warning if I don't answer
right away).

Oh: don't use the tun.c from the whiteboard web page - this is parallel
work, and it won't work with feat_ipv6_payload.  Integration of=20
Kazuyoshi-san's tun.c work into openvpn-testing is on my TODO list :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--II8oT75hj15qngTC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTDhLgakuBuNlUUl1AQJ/GQP/b4W1Ii9Wj193HvW0p6W9xQJCcjbmbQYd
Y6/VXpE8PLVPHmS2ldVhid7OkPQTb5ykxU5Hcuw/L2Fva2ihz1q8aBNlfzVAcCO0
FkV11Ft5FB8+FcmJJ4UBu39ADBMBOwmgbbD0TFjN0/7Y6TXj1xJyU2ZQNb3RIvjG
5FyMZwKinHM=
=qQPv
-----END PGP SIGNATURE-----

--II8oT75hj15qngTC--

