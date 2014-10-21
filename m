Date: Tue, 21 Oct 2014 16:26:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141021142617.GD396@...1296...>
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
	<20141021091159.GY396@...1296...>
	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
	<20141021104308.GZ396@...1296...>
	<CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>
	<CAKuzo_juo92ZC8aGjE4FN=EFnw1WMczE_noX7Aa2m+wQEXeJfQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXESt2jNC8oCvz8w"
Content-Disposition: inline
In-Reply-To: <CAKuzo_juo92ZC8aGjE4FN=EFnw1WMczE_noX7Aa2m+wQEXeJfQ@...278...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--LXESt2jNC8oCvz8w
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 21, 2014 at 09:55:09AM -0400, Selva Nair wrote:
> Currently OpneVPN-MI-GUI does work without elevated privileges using
> openvpn service and the management interface. I have a small user-base who
> have been happily using it this way for more than a year now. In my view =
if
> OpenVPN distribution could bundle the MI-GUI, it would be of great help.

Well, that works, but runs OpenVPN as privileged user - so a bug in
OpenVPN (or a config that runs scripts) could be used to attack the
system...

(Plus, traditionally using the service will not work with username+password
input, but if MI does that via management interface, it can be done)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LXESt2jNC8oCvz8w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEZtCakuBuNlUUl1AQIJfQP/cwca5t6sgEULFDP6uO2tknh9gZIg70Dl
qkpWSCeDn13KrjKdgx8aMCYGSEjZEsOycuzGWl26uE7clMY+yreyYt5MYkDi2Bmj
Wqx5b/6GRTAFTGZPrDJoev8qM+zCY6nRAXZJboPmiTmA6g9KRlQFQHnu0Te8uN8J
4Yb8mHf0NNo=
=GTqf
-----END PGP SIGNATURE-----

--LXESt2jNC8oCvz8w--

