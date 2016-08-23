Date: Tue, 23 Aug 2016 22:44:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160823204435.GH78279@...1296...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
	<073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
	<CAKuzo_goKiVr4k7+eQbLK93fzQ99ZH+pkk1uVw0k2_OGb0mH4A@...278...>
	<CAKuzo_jRJcTGWRqv51O3TPc7rU=8aomQqFeib0FF_G-dtUmeQg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SorlIzCW0DSU55cr"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jRJcTGWRqv51O3TPc7rU=8aomQqFeib0FF_G-dtUmeQg@...278...>
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SorlIzCW0DSU55cr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 23, 2016 at 11:23:29AM -0400, Selva Nair wrote:
> It was agreed to move this forward by looking into the approaches
> suggested by Selva, and by giving him feedback.
>=20
> So what is the consensus? Should we support DNS through all tunnels for
> which block-outside-dns is specified or just make sure DNS works through =
at
> least one of the tunnels if the option is used on multiple ones?

"principle of least astonishment" (POLA) would be "DNS inside the tunnels
works, outside the tunnels doesn't, no matter which tunnel was opened=20
first.  "DNS does not work at all" is the worst variant, because a normal
user (including most "client admins") will not be able to see why this
would be happening - I can already see this with normal users, Win10 and
OpenVPN that they never attribute to DNS failures if "outlook does not
work"...

You had some suggestions upthread how to change the WFP stuff to make
it cooperate (and perform) better - so "feature-ACK" on that approach :-)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SorlIzCW0DSU55cr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7y1s6kuBuNlUUl1AQJanAP+JFzgibUJ1bWC6sN55oOSxETzCKvm02LM
LUb0M5fanVYBMmfjAddjj3//+ETN9Ts39PieRHVdwnCHW6QBCKiUPBMIp2bukkS9
0GvTWClkSDBhx/bK9sM1Z93/+iyCP/cIgEBuzeExBgo3tJ8XVltfbW3Dq6DWOfVc
cqGHzFpLkDE=
=VXJM
-----END PGP SIGNATURE-----

--SorlIzCW0DSU55cr--

