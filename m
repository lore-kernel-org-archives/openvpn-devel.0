Date: Thu, 4 Sep 2014 13:46:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140904114659.GH1118@...1296...>
References: <20140903125713.GF1118@...1296...>
	<SNT148-W43036EEA91281A582656F199C50@...512...>
	<5407D15E.8060300@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DsdztYVzhbn+JGnu"
Content-Disposition: inline
In-Reply-To: <5407D15E.8060300@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] kill command with IPv6 client address
	and port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--DsdztYVzhbn+JGnu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 03, 2014 at 10:41:34PM -0400, Arne Schwabe wrote:
> Newer OpenVPN versions (I don't recall if -master or 2.3.x) have this
> information in the status report. For older version you have to record
> the ID when a client is connected.

In master:

commit 662ce6acc065bddf6490b3494725b8b3987b7def
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Aug 31 16:19:13 2012 +0200

    Add the client id (CID) to the output of the status command


Wasn't backported to 2.3, due to "it's new functionality that might break
existing usage".

In the context of this mail thread, this is slightly moot, though, as
the new "kill by ip+port" patch would not get applied to 2.3 anyway (same
reason), so use master and enjoy :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DsdztYVzhbn+JGnu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAhRM6kuBuNlUUl1AQK6gAP7B3S5IY0pJz7m2um+zoSdqQZZTKQhOOIQ
KhukhXrPS6MNcUCZn39HKKR6rJ8Saz6dY+nun2vO7v9tYInTblS8ngGLnTb1v/Ro
EX1/GtrzeWPLHeNgVyQDDcWAFpcecEfYAz4F6yCuWZNu6miR1uqhX6esQcmUhhOd
kWWhTFRxxXU=
=HPSf
-----END PGP SIGNATURE-----

--DsdztYVzhbn+JGnu--

