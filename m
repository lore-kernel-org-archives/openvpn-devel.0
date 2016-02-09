Date: Tue, 9 Feb 2016 12:57:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160209115746.GO24952@...1296...>
References: <20160208213929.GA20623@...2120...>
	<20160209092821.GH24952@...1296...>
	<20160209101533.GJ3102@...2121...>
	<20160209104625.GL24952@...1296...>
	<56B9C5B0.2010908@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gn0jpdOhRbNsHTk+"
Content-Disposition: inline
In-Reply-To: <56B9C5B0.2010908@...1147...>
Subject: Re: [Openvpn-devel] route / route-ipv6 can not be used in ccd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--Gn0jpdOhRbNsHTk+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 09, 2016 at 11:55:44AM +0100, Jan Just Keijser wrote:
> > Could you test and report whether --learn-address does the job for you?
>
> a 'learn-address' script is an entirely different beast than a=20
> 'client-connect' script: you cannot write out new openvpn directives in=20
> a 'learn-address' script. In both a 'client-connect' script (not a CCD=20
> file) and in a 'learn-address' script you can add routes to the system=20
> routing table provided that you're not running with "user nobody" - it's=
=20
> just that you cannot use the "normal" openvpn stuff for this.

The main difference (in relevance to this thread) is that --learn-address=20
will *tell* the script what routes might be required for a specific client,
while --client-connect would have to do some sort of database lookup...

Or are iroutes exported?  Manpage doesn't mention anything in that regard.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Gn0jpdOhRbNsHTk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrnUOakuBuNlUUl1AQK2tAP+OrpnTdm0pwaKs6XEBne1iRBf/rODGaId
gxw3CkkWWeu04fuC1B7QZQUl2b2ZE2eyzzavhMylGeavEer7Z2YRCiC8UJVhF1iq
otatmqSZY/oyrlzeTKzrbuDU3XJgmK2k6ONt1Qab1jXNzFuHRW/EZWtnAmm4I7u2
7Mx4wKeg6Us=
=X0wt
-----END PGP SIGNATURE-----

--Gn0jpdOhRbNsHTk+--

