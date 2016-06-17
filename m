Date: Fri, 17 Jun 2016 10:07:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160617080749.GE79504@...1296...>
References: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
	<1465656195-12722-1-git-send-email-arne@...1227...>
	<20160611181434.GT62247@...1296...>
	<CAKuzo_gJLLjMWM7RRP=QzHBAEA6==f1BhEEa8gjL2W_FcGN-5A@...278...>
	<20160611202621.GU62247@...1296...>
	<CAKuzo_iFqH_uoAPKCL3GtHv9SE9P0Hn6BYyjmc_g9t3VL-C2ZQ@...278...>
	<8dce42be-d9df-69cb-52a6-1a3217697282@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <8dce42be-d9df-69cb-52a6-1a3217697282@...1227...>
Subject: Re: [Openvpn-devel] [[PATCH v3]] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
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

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 16, 2016 at 11:33:39AM +0200, Arne Schwabe wrote:
> >     I do wonder how useful these settings are, and why they are not
> >     default...
> >     they predate my OpenVPN involvement by many years.
> >
> > No clue..
> I would just propose to remove the option (but accept configs with it in
> it). Connecting logic with dualstack and new timeouts has changed enough
> that this corner case behaviour isn't probably worth keeping. The option
> probably predates even the connection list.

I think that is a reasonable way forward out of the option jungle -=20
make --http-proxy-retry and --socks-proxy-retry NOOP-with-warning, and
change the behaviour to "always SIGUSR1".  That way, all connection errors
either "direct" or "via any sort of proxy" will (should?) lead to the same=
=20
restart behaviour, no special options to remember.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2Ov1akuBuNlUUl1AQKaWwP9G6vZ+a2t8JME8ou42ufWJ/ZXv84muPFy
bigcH6nlj1Re+s1ZTFV+ocIKk6l2aCAmj355ih01/MUJcElLkgvwGy0y/D+/eYRP
wWIAoP3MyL7eOmz3FF9TQ+2MTgwUGcELzeO8D92sedkyn3lLwee6D0rJMUz6Ji+T
sZqruPEu7yk=
=PXXf
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

