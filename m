Date: Wed, 21 Dec 2016 22:25:49 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161221222549.1383fee9@...1799...>
In-Reply-To: <89ef1946-ae7a-f4af-8b0f-bc592c8ed2e5@...277...>
References: <20161216155755.29931-1-list@...1798...>
	<89ef1946-ae7a-f4af-8b0f-bc592c8ed2e5@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/GC=EIiUh14.7W3TCEaTjTNl";
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

--Sig_/GC=EIiUh14.7W3TCEaTjTNl
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

debbie10t <debbie10t@...277...> on Tue, 2016/12/20 00:32:
> On 16/12/16 15:57, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >
> > Different unit instances create and destroy the same RuntimeDirectory.
> > This leads to running instances where the status file (and possibly
> > more runtime data) is no longer accessible.
> >
> > So create a RuntimeDirectory per instance.
> >
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  distro/systemd/openvpn-client@...1685... | 2 +-
> >  distro/systemd/openvpn-server@...1685... | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/distro/systemd/openvpn-client@...1685...
> > b/distro/systemd/openvpn-client@...1685... index 5618af3..fcb5302 100644
> > --- a/distro/systemd/openvpn-client@...1685...
> > +++ b/distro/systemd/openvpn-client@...1685...
> > @@ -9,7 +9,7 @@
> > Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
> >  Type=3Dnotify
> >  PrivateTmp=3Dtrue
> > -RuntimeDirectory=3Dopenvpn-client
> > +RuntimeDirectory=3Dopenvpn-client@%i
> >  RuntimeDirectoryMode=3D0710
> >  WorkingDirectory=3D/etc/openvpn/client
> >  ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config
> > %i.conf diff --git a/distro/systemd/openvpn-server@...1685...
> > b/distro/systemd/openvpn-server@...1685... index b9b4dba..8b240cf 100644
> > --- a/distro/systemd/openvpn-server@...1685...
> > +++ b/distro/systemd/openvpn-server@...1685...
> > @@ -9,10 +9,10 @@
> > Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Servi=
ce]
> >  Type=3Dnotify
> >  PrivateTmp=3Dtrue
> > -RuntimeDirectory=3Dopenvpn-server
> > +RuntimeDirectory=3Dopenvpn-server@%i
> >  RuntimeDirectoryMode=3D0710
> >  WorkingDirectory=3D/etc/openvpn/server
> > -ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log
> > --status-version 2 --suppress-timestamps --config %i.conf
> > +ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server@%i/status.log
> > --status-version 2 --suppress-timestamps --config %i.conf
> > CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> > CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> > LimitNPROC=3D10 DeviceAllow=3D/dev/null rw=20
>=20
>=20
> CentOS 7 (after full update) still only uses systemd version 219
>=20
> This functionality is not introduced until systemd 227
>=20
> https://github.com/systemd/systemd/blob/master/NEWS

Ah, good to know when this was implemented. :-D

But we already know that this does not work for version we want to support.
Thus I had sent a patch with new approach on Dec 16th where RuntimeDirectory
is removed from unit files and directories are handled via tmpfiles.d. Can
you take a look at that one?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/GC=EIiUh14.7W3TCEaTjTNl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlha810ACgkQiUUh18yA
9HagkAf/W6IGSe7gE+s4rLSC0C7EDSSUGvHZPfD9uy2ZNFqX76kZCaMlwdPmJl1j
aw7p5UDCjkVO8o/nfpj5Il/9mCDhSg0aVm47twop/GDY1twE2xyOxKeBNrNS6ETv
qlSktp82cBaelLGITlNg4V32uKeDEMlcr0s7c7ZdrectE82i7Wx3uW3vDU40qf3R
pDEfrtm9C0NsQld+/NyRRJZCMQBGQQtk0O7fU38f3XcpGqx9QXcLddd9UbYYRuHu
+DgXr1nBLTKMLEZ++gxuhOgJgPPf0LhLCXfyG5Zd54CkjaaXjWIGhrzg2VtS9l9p
xKS1bezD083vzZ5mVBoz3fwo9yCFJg==
=0PBU
-----END PGP SIGNATURE-----

--Sig_/GC=EIiUh14.7W3TCEaTjTNl--

