Date: Sun, 1 Jan 2017 19:47:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170101184754.GF78624@...1296...>
References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
	<20170101182035.GE78624@...1296...>
	<028801d2645d$6c491270$44db3750$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j5904Piqecmxrsp+"
Content-Disposition: inline
In-Reply-To: <028801d2645d$6c491270$44db3750$@gmail.com>
Subject: Re: [Openvpn-devel] Visual Studio support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--j5904Piqecmxrsp+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 01, 2017 at 10:32:34AM -0800, Fish Wang wrote:
> Thanks for your (and Steffan's) reply.
>=20
> I also noticed that 2.4 and 2.5 only supports Vista+, so it might make se=
nse
> to remove dynamic function loading for WPF in openvpnserv (see all those
> LoadLibrary and GetProcAddress code in [1]).=20

I leave that for Selva or Heiko to comment on.

> But somehow I have an
> impression that openvpnserv is no longer supported and openvpnserv2 should
> be used instead, so such a patch is not useful. What do you think?

openvpnserv has two faces - one is "the traditional service".  That part
got replaced by openvpnserv2.

The other part is "the interactive service", which is the privileged part
needed to run openvpn.exe and gui as non-privileged user.  That one is
new and very much wanted :-)

Some disentanglement might be appropriate or even desirable for "master"=20
- for 2.4, I'd say "we leave this as it is" - it works and is well-tested=20
now.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--j5904Piqecmxrsp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYaU7aAAoJEB2Cnv7KVigSQhkL/RZHzlJRFW2kbR3yURmhBqk3
ZenS17hCBvqcDA/kx1d/hLCIuVrdbpzab7u+knNKarmJzQVAi6rixlVy6P0MsHpL
6jytAnI9we8lMnjc+Ww+xDDLck5CV6ZzXv/cjKhnIJPH+id+/Wt3wOnsRVcMlJOr
+eoIXlML7OHb0Pnl0TRvsErb8xLNkL2T5892FzH0LVlLY3Gt9emskevQvfcl7CoN
ijTe8KFxToxDSXmDXdeh1fKKRGmFlWUSdFakiYzs0ae2CT1E+ypBWFcu4OCsbyjn
DSW8nJUzC5T1tDkpRxuojg60/4gwQyH2rVCh83EdZpK6rlEVqu2m5HuK9vLjZi9Q
iwZnYXokstK/Yve8fyt9X7qRYPkabr9i4blbHq0u9y+4UOYfanQoxpAAgLGCrK4H
leEV8apGZV1siF7JoBx1Dd60NWVyhmDbr2YzLtTjL4Vkac0fe/imwi6uMBtmgOwm
Y9K5UqlpaRgVJbMaK4YHzD0ylM0WVVelrMFkiE36TA==
=Axhn
-----END PGP SIGNATURE-----

--j5904Piqecmxrsp+--

