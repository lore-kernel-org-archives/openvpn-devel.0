Date: Thu, 24 Jul 2014 20:10:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140724181032.GX1118@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
	<20140722193436.GI1118@...1296...>
	<OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
	<53D02C7F.10900@...1147...> <20140724140845.GT1118@...1296...>
	<OF5C660519.1F3B315A-ONC1257D1F.004F8E28-C1257D1F.005477F1@...1846...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eLlMuDqWz6GHXUjE"
Content-Disposition: inline
In-Reply-To: <OF5C660519.1F3B315A-ONC1257D1F.004F8E28-C1257D1F.005477F1@...1846...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary
	file" ....Too many open files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--eLlMuDqWz6GHXUjE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 24, 2014 at 05:22:37PM +0200, arno.odermatt@...1845... wrote:
> I did the first part:
>=20
> NO, we are not using any Plugins, only client -connects scripts

Mmmh, ok.

> lsof -n | wc -l           4405=20

That doesn't tell much, except "the total number of open files in
the system is 4405".

> lsof -p 25211 > openvpn1.txt
> lsof -p 25232 > openvpn2.txt
> lsof -p 25252 > openvpn3.txt
>=20
> It looks like, we got much more then just some lines:
>=20=20=20=20=20=20=20=20=20=20
> openvpn3.txt    openvpn2.txt    openvpn1.txt

If you look at the files (in attachment), you'll see that the large bulk
of it is "TCP" - so your openvpn processes are using up the amount of file
descriptors the system is willing to give them for TCP connects, as every
TCP client needs to have it's own socket.

If you run "ulimit -a" from the same environment where you start the
OpenVPN processes, you'll see a line that looks like this:

$ ulimit -a
...
nofile                         (-n)  1024

that's the maximum number of file descriptors - subtract some 20-odd,
and you have ~1000 left for about 1000 clients.

$ ulimit -n 2000

can usually be used to raise that limit to 2000 (if run as root, in the=20
same shell that starts openvpn later)...  I'm not a Fedora expert, so=20
maybe they have some other limitations, or ways to control the limits.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--eLlMuDqWz6GHXUjE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9FMGKkuBuNlUUl1AQL2rAP6A0fW32h96+Rsi0MpRRWzx4dBtHZs7ShU
3lW8eJB7sYNuLgkevBZJpQXaNR0ysCKqjDlWmlU6g3D4PruFET/U5iqTHmKQauvS
+0ycKZKwZnV9mdQ7dQxquNnhHxUk6UItTLVcosr8WtVq3IWIS80RwUFzillMB/g2
eknNSGs5fTI=
=/ymu
-----END PGP SIGNATURE-----

--eLlMuDqWz6GHXUjE--

