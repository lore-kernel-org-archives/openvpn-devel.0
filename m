Date: Mon, 26 Dec 2016 17:12:57 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161226171257.5b611618@...1799...>
In-Reply-To: <9a6d51f5-831b-6fd5-109f-0688623f08d9@...277...>
References: <20161216225203.609cf163@...1799...>
	<20161216220004.20867-1-list@...1798...>
	<9a6d51f5-831b-6fd5-109f-0688623f08d9@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/wY=Og0i7o0l72nLgbehlwPY";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/wY=Og0i7o0l72nLgbehlwPY
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

debbie10t <debbie10t@...277...> on Sat, 2016/12/24 11:10:
> On 16/12/16 22:00, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >
> > Different unit instances create and destroy the same RuntimeDirectory.
> > This leads to running instances where the status file (and possibly
> > more runtime data) is no longer accessible.
> >
> > So do not handle this in unit files but provide a tmpfiles.d
> > configuration and let systemd-tmpfiles do the work.
> > Nobody will (unintentionally) delete the directories and its content.
> > As /run is volatile we do not have to care about cleanup.
> >
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  distro/systemd/openvpn-client@...1685... | 2 --
> >  distro/systemd/openvpn-server@...1685... | 2 --
> >  distro/systemd/openvpn.conf            | 2 ++
> >  3 files changed, 2 insertions(+), 4 deletions(-)
> >  create mode 100644 distro/systemd/openvpn.conf
> >
> > diff --git a/distro/systemd/openvpn-client@...1685...
> > b/distro/systemd/openvpn-client@...1685... index 5618af3..1187ee8 100644
> > --- a/distro/systemd/openvpn-client@...1685...
> > +++ b/distro/systemd/openvpn-client@...1685...
> > @@ -9,8 +9,6 @@
> > Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
> >  Type=3Dnotify
> >  PrivateTmp=3Dtrue
> > -RuntimeDirectory=3Dopenvpn-client
> > -RuntimeDirectoryMode=3D0710
> >  WorkingDirectory=3D/etc/openvpn/client
> >  ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config
> > %i.conf CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW
> > CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE diff --git
> > a/distro/systemd/openvpn-server@...1685...
> > b/distro/systemd/openvpn-server@...1685... index b9b4dba..25a6bb7 100644
> > --- a/distro/systemd/openvpn-server@...1685... +++
> > b/distro/systemd/openvpn-server@...1685... @@ -9,8 +9,6 @@
> > Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
> >  Type=3Dnotify
> >  PrivateTmp=3Dtrue
> > -RuntimeDirectory=3Dopenvpn-server
> > -RuntimeDirectoryMode=3D0710
> >  WorkingDirectory=3D/etc/openvpn/server
> >  ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log
> > --status-version 2 --suppress-timestamps --config %i.conf
> > CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> > CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE diff
> > --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf new
> > file mode 100644 index 0000000..bb79671 --- /dev/null
> > +++ b/distro/systemd/openvpn.conf
> > @@ -0,0 +1,2 @@
> > +d /run/openvpn-client 0710 root root -
> > +d /run/openvpn-server 0710 root root -
> >=20=20
>=20
> ACK
>=20
> This works as expected from debian8/systemd 215 to arch/systemd 232

Great! Thanks for testing!

But I think this will not make its way into 2.4.0? Will we see this in
release/2.4 for a bugfix release?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/wY=Og0i7o0l72nLgbehlwPY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhhQYkACgkQiUUh18yA
9HbxdwgArBo7JvvcQy+j6wcRt95F8P4cmOd6Das56NTmw7Cqx6fF8uHzOamKtZu1
Lsx0dz4PQn8C5Tj/qVtWfOas33qXV5J2TfH/drxIF7zw4zqku1ZhlYk+uwpddUeo
IPfuZDRPve8955bEn94fzavm1dPojXCTLR8i8q0Q+3g+A8ljBpK+dx9NYU0rh1SP
uRYAg/SNJ5zI69dj/JJG5GXde9G5ixuJJKHxetf4HZZ0lnUzt2BoGgViGAxEe4X/
i7UZOrkW06oQIwzSbx82WtAnsXuU0A4OaCYkM16B9WQGXhtqXHeAugok+Rlt9GlR
1B6nVWptJRMD/aOS4sSK62H9pTkCeA==
=Ga1r
-----END PGP SIGNATURE-----

--Sig_/wY=Og0i7o0l72nLgbehlwPY--

