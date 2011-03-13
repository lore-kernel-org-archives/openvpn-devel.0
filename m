Message-ID: <20110313231620.12432.qmail@...1287...>
Date: Mon, 14 Mar 2011 00:16:20 +0100
From: Peter Stuge <peter@...1287...>
References: <20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313142200.GJ9835@...1296...>
	<20110313160421.3004.qmail@...1287...>
	<20110313173833.GK9835@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20110313173833.GK9835@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gert Doering wrote:
> On Sun, Mar 13, 2011 at 05:04:21PM +0100, Peter Stuge wrote:
> > Was this for PPP? Sorry then, I completely overlooked that! I'm
> > fortunate to not have to deal with many PPP links now, but I have,
> > and pppd of course /etc/ppp/ip-up and -down where the same info about
> > (de/re)config is available as in the udhcpc script.
>=20
> Which is actually somewhat underlining the point :-) - if you absolutely
> need to do this outside of OpenVPN, it can be done, but how to do that
> depends on interface technology used, specific distribution used (what
> if your distribution doesn't *have* udhcp?), etc.

Sure, but in any case it remains quite trivial.


> - or try to understand why this is needed in the first place :-) - I still
>   don't understand why not binding to anything + --multihome isn't working

Third time: Multiple openvpn daemons on different interfaces and same
port.


> As for including the patch, in either form, I'd rather wait for the
> to-be-implemented-and-cleaned-up "multi-listen" infrastructure that
> someone will hopefully implement for 2.3...

+1


//Peter

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNfVBEhR3Q0dhIfEgRAtYxAJwMSZCIim6ySwK9Q+muz0+joN0WhwCeOGfa
hde68ec4IEivhrbBo7xYw7Q=
=yKnV
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--

