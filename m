Date: Tue, 7 Jun 2016 12:05:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607100507.GT53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
	<d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
	<CAFHpkQF-Xr5zH=LuC5rkZz8qkde1nvm1G85fM4kXkWB2KVPrTw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxhIMh0CCs5SSfRr"
Content-Disposition: inline
In-Reply-To: <CAFHpkQF-Xr5zH=LuC5rkZz8qkde1nvm1G85fM4kXkWB2KVPrTw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--cxhIMh0CCs5SSfRr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Tue, Jun 07, 2016 at 01:23:55PM +0500, ???????? ?????????????? wrote:
> mingw is an official way of building windows packages. I guess something
> like that appliable for ARM as well (I haven't heard about compilers
> running on those machines)

$ uname -mo
armv5tel GNU/Linux
$ gcc -v
Using built-in specs.
Target: arm-linux-gnueabi

of course you'd typically not compile on a slow ARM system, but if
it's just a few lines of code, getting a cross-build environment up and
running is way more effort than "just install the compiler and compile
locally"...  if disk space permits.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cxhIMh0CCs5SSfRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1acU6kuBuNlUUl1AQIDMgP/Ye65b/YeOXpJlyQrzViVrMWMQFxo2qhc
pYtcymLCCi1OW1d0VI7OTAberrZDtVoSDwLysn/I/GSwWZwm/tXhPDsbNySFYF5a
olirhOMrFq7XkwXLeRa2QToZWeR63WLxsQjKi2ju1FaT5M1yTYW7Ktz9jBeSO0En
e/treq04mnY=
=ymSD
-----END PGP SIGNATURE-----

--cxhIMh0CCs5SSfRr--

