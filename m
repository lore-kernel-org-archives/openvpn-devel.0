Date: Tue, 22 Jul 2014 21:34:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140722193436.GI1118@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JT7prkXbe9imFIm7"
Content-Disposition: inline
In-Reply-To: <9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
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
To: Eric Crist <ecrist@...1286...>
Cc: openvpn-devel@lists.sourceforge.net

--JT7prkXbe9imFIm7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 22, 2014 at 12:37:19PM -0500, Eric Crist wrote:
> This isn't an OpenVPN problem, directly.  It appears you have a client co=
nnect script, or are storing connection information in temp files.  You can=
 increase the maximum allowed open files in Fedora (you'll have to research=
 that yourself).  Alternatively, stop storing connection data in a temp fil=
e for new connections.  OpenVPN, by itself, does not create these temporary=
 files.

Uh, this is not fully correct.  If you use --client-connect (or any of
the other up scripts that enable passing of config values back), OpenVPN
will create the temp file to be used for that, to avoid race conditions.

I'm not sure when this was added, but "recentish" (2.2.x)

Now the sema-files do not ring a bell, but we need to check whether we
properly clean up the other files - but that should be visible in "lsof"
while OpenVPN is running and after a few connections have completed.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JT7prkXbe9imFIm7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU868zKkuBuNlUUl1AQIB3gQAw2yEX4qSv7aIyd8lkV3rM16LKDxNivGK
Auqq4dgc7cqSkamgkyolJYlSmy2H+nMIPF8vrY5lm9VRG+5NFLAzwjDmTPxq4wGM
wfS6d8SNnH6bGnKGHV9wpcJbiW0HmwWSErExaTI7eOossI7qPIErHI5v9DSF5rz1
Y9TMRcyw1Cw=
=gT65
-----END PGP SIGNATURE-----

--JT7prkXbe9imFIm7--

