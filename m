Date: Mon, 26 Dec 2016 18:07:53 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161226180753.5be613f7@...1799...>
In-Reply-To: <a039446c-5dc5-74a7-12f3-53a084cfc192@...2080...>
References: <20161216225203.609cf163@...1799...>
	<20161216220004.20867-1-list@...1798...>
	<9a6d51f5-831b-6fd5-109f-0688623f08d9@...277...>
	<20161226171257.5b611618@...1799...>
	<a039446c-5dc5-74a7-12f3-53a084cfc192@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/O+SaS4qVxn9dv_LL6KUofMb";
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
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/O+SaS4qVxn9dv_LL6KUofMb
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Mon, 2016/12/26 17:45:
> On 26/12/16 17:12, Christian Hesse wrote:
> > debbie10t <debbie10t@...277...> on Sat, 2016/12/24 11:10:=20=20
> >> On 16/12/16 22:00, Christian Hesse wrote:=20=20
> >>> From: Christian Hesse <mail@...1798...>
> >>>
> >>> Different unit instances create and destroy the same RuntimeDirectory.
> >>> This leads to running instances where the status file (and possibly
> >>> more runtime data) is no longer accessible.
> >>>
> >>> So do not handle this in unit files but provide a tmpfiles.d
> >>> configuration and let systemd-tmpfiles do the work.
> >>> Nobody will (unintentionally) delete the directories and its content.
> >>> As /run is volatile we do not have to care about cleanup.
> >>>
> >>> Signed-off-by: Christian Hesse <mail@...1798...>
> >>> ---
> >>>  distro/systemd/openvpn-client@...1685... | 2 --
> >>>  distro/systemd/openvpn-server@...1685... | 2 --
> >>>  distro/systemd/openvpn.conf            | 2 ++
> >>>  3 files changed, 2 insertions(+), 4 deletions(-)
> >>>  create mode 100644 distro/systemd/openvpn.conf
> >>>
> >>> diff --git a/distro/systemd/openvpn-client@...1685...
> >>> b/distro/systemd/openvpn-client@...1685... index 5618af3..1187ee8 100=
644
> >>> --- a/distro/systemd/openvpn-client@...1685...
> >>> +++ b/distro/systemd/openvpn-client@...1685...
> >>> @@ -9,8 +9,6 @@
> >>> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Ser=
vice]
> >>>  Type=3Dnotify
> >>>  PrivateTmp=3Dtrue
> >>> -RuntimeDirectory=3Dopenvpn-client
> >>> -RuntimeDirectoryMode=3D0710
> >>>  WorkingDirectory=3D/etc/openvpn/client
> >>>  ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind --config
> >>> %i.conf CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW
> >>> CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE diff --git
> >>> a/distro/systemd/openvpn-server@...1685...
> >>> b/distro/systemd/openvpn-server@...1685... index b9b4dba..25a6bb7 100=
644
> >>> --- a/distro/systemd/openvpn-server@...1685... +++
> >>> b/distro/systemd/openvpn-server@...1685... @@ -9,8 +9,6 @@
> >>> Documentation=3Dhttps://community.openvpn.net/openvpn/wiki/HOWTO [Ser=
vice]
> >>>  Type=3Dnotify
> >>>  PrivateTmp=3Dtrue
> >>> -RuntimeDirectory=3Dopenvpn-server
> >>> -RuntimeDirectoryMode=3D0710
> >>>  WorkingDirectory=3D/etc/openvpn/server
> >>>  ExecStart=3D/usr/sbin/openvpn --status %t/openvpn-server/status-%i.l=
og
> >>> --status-version 2 --suppress-timestamps --config %i.conf
> >>> CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVI=
CE
> >>> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE diff
> >>> --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf new
> >>> file mode 100644 index 0000000..bb79671 --- /dev/null
> >>> +++ b/distro/systemd/openvpn.conf
> >>> @@ -0,0 +1,2 @@
> >>> +d /run/openvpn-client 0710 root root -
> >>> +d /run/openvpn-server 0710 root root -
> >>>=20=20=20=20
> >>
> >> ACK
> >>
> >> This works as expected from debian8/systemd 215 to arch/systemd 232=20=
=20
> >=20
> > Great! Thanks for testing!
> >=20
> > But I think this will not make its way into 2.4.0? Will we see this in
> > release/2.4 for a bugfix release?=20=20
>=20
> That is correct.  What is in release/2.4 currently is what will be the
> v2.4.0 release unless something of a real blocker appears before I'll
> tag and push out the release commit some time tomorrow.  I don't dare to
> add anything which is not absolutely strictly needed for the comming
> release.  I'm just waiting for a the final Windows test results from
> Samuli before pushing out the final release.  Then Samuli will publish
> all source tarballs, Windows installers and do the announcement.

Waiting for that to happen. :-p

> It's good that this is tested, but I'd like to have a more thorough
> review of this patch as well in addition to look at the automake rules
> so that we can install unit files and the tmpfiles.d config to the
> proper place as well during 'make install'.  This will simplify the job
> of the packagers as well.

Ok, let's discuss this on irc any time soon. I will have some last working
days this year - and hopefully some spare time.

> One thing I'm pondering on though, is how clever it is to call the
> tmpfiles.d config file 'openvpn.conf' ... but that's something I can fix
> at commit time.

Well, files in /usr/lib/tmpfiles.d/ need to end in '.conf' and it makes sen=
se
to name them like their package - so 'openvpn.conf'.

We can have a different file name in repository / tarball, but the build
system should install it there.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/O+SaS4qVxn9dv_LL6KUofMb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhhTmkACgkQiUUh18yA
9HaobwgAxbSVdnTOtrZTaf0PqHlOCZWUn/PZe4OAS+SbFGMohz9j8MNrBmwds7dV
gjsuPqISxmhIw4u3F8Mf1KrkguZuMfzSlelUQ4fvHkYgDPLd/hK/c1OYjrppKYY4
cuutwczOJ/2+5yPwHIMZWPdrn5kmEpbuhlZOr5yxskCHODmJ1Ebq9yw0Rpe0o5Q0
Ac/iG76FAuCU1AGAraHJ1BPILEFfQ+O4MDmYWiY5kDIoGmkRRwan5vuyF1R/iBN+
yElfCia999pYa2fdAPGxyKffdMlwOZyb1hUeEmVHYq2+uMpWc1YuW5ImXOybi/YU
6hS2/hsNmRCDnoPdVfK6vCw33ArLuQ==
=9taB
-----END PGP SIGNATURE-----

--Sig_/O+SaS4qVxn9dv_LL6KUofMb--

