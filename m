From: "Dave" <dev@...575...>
Date: Sun, 7 Sep 2008 09:00:00 -0500
Message-ID: <81AF7E8F1C0044E88581729A677FA384@...576...>
MIME-Version: 1.0
In-Reply-To: <200809071232.m87CWZc5005898@...1119...>
Subject: Re: [Openvpn-devel] Confusing "mtu-dynamic" warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Jos Vos' <jos@...1120...>, openvpn-devel@lists.sourceforge.net

..
> Hi,
>=20
> When makins some inconsistency mistake with "--fragment"=20
> settings, I get an error message like:
>=20
> WARNING: 'mtu-dynamic' is present in local config but missing=20
> in remote config, local=3D'mtu-dynamic'
>=20
> I guess this message has to be updates, as "--fragment" is=20
> meant to replace "--mtu-dynamic" AFAICS.
>=20
> This is with 2.1_rc9.
...

Nice bug!  --mtu-dynamic is an ancient option, it was dropped in version 1.5
about 5 years ago.


