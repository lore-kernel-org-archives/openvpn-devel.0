Date: Sun, 13 Mar 2011 18:38:33 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110313173833.GK9835@...1296...>
References: <20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313142200.GJ9835@...1296...>
	<20110313160421.3004.qmail@...1287...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Content-Disposition: inline
In-Reply-To: <20110313160421.3004.qmail@...1287...>
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

--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 13, 2011 at 05:04:21PM +0100, Peter Stuge wrote:
> Was this for PPP? Sorry then, I completely overlooked that! I'm
> fortunate to not have to deal with many PPP links now, but I have,
> and pppd of course /etc/ppp/ip-up and -down where the same info about
> (de/re)config is available as in the udhcpc script.

Which is actually somewhat underlining the point :-) - if you absolutely
need to do this outside of OpenVPN, it can be done, but how to do that
depends on interface technology used, specific distribution used (what
if your distribution doesn't *have* udhcp?), etc.

Personally, I tend to=20

 - either do it by run-time-parsing of "ip addr show" and feeding to
   "openvpn --local $ip" in a script-wrapper

 - or try to understand why this is needed in the first place :-) - I still
   don't understand why not binding to anything + --multihome isn't working

As for including the patch, in either form, I'd rather wait for the
to-be-implemented-and-cleaned-up "multi-listen" infrastructure that
someone will hopefully implement for 2.3...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTX0BGakuBuNlUUl1AQJLNwP/S5k6FmwxA6lZCfm1D6VyEQk6BMpGqV9b
2z97Xz7bVrseQmQ84UuusbzF26qS2AaAgYEhEeXzZfjE+D+EEa82Cxb4lvYDqPKD
JLeLhnUVqszA2LxxYqeIJBoK1E6FoNzg8UJZC7BZneCIFbl2aOK+YAWJE3063OP7
06v8GifPI6c=
=pBDn
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--

