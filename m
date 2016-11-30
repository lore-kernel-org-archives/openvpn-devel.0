Date: Wed, 30 Nov 2016 13:22:12 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161130132212.669e24da@...1799...>
In-Reply-To: <760e0e37-c6c6-1183-548f-0c14636d45e2@...2080...>
References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
	<760e0e37-c6c6-1183-548f-0c14636d45e2@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/G4Gcluvby.j+AeCojAMx/sk";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running
 from systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

--Sig_/G4Gcluvby.j+AeCojAMx/sk
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Wed, 2016/11/30 12:52:
> On 30/11/16 09:59, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > We start with systemd Type=3Dnotify, so refuse to daemonize.
> >=20
> > Signed-off-by: Christian Hesse <mail@...1798...>
> > ---
> >  distro/systemd/openvpn-client@...1685... | 1 -
> >  distro/systemd/openvpn-server@...1685... | 1 -
> >  src/openvpn/init.c                     | 7 +++++++
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/distro/systemd/openvpn-client@...1685...
> > b/distro/systemd/openvpn-client@...1685... index f64a239..5618af3 100644
> > --- a/distro/systemd/openvpn-client@...1685...
> > +++ b/distro/systemd/openvpn-client@...1685...
> > @@ -12,7 +12,6 @@ PrivateTmp=3Dtrue
> >  RuntimeDirectory=3Dopenvpn-client
> >  RuntimeDirectoryMode=3D0710
> >  WorkingDirectory=3D/etc/openvpn/client
> > -ExecStartPre=3D/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0
> > && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when
> > being managed by systemd" ; exit 1' ExecStart=3D/usr/sbin/openvpn
> > --suppress-timestamps --nobind --config %i.conf
> > CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETG=
ID
> > CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE LimitNPROC=3D10 diff --git
> > a/distro/systemd/openvpn-server@...1685...
> > b/distro/systemd/openvpn-server@...1685... index 890e6a9..b9b4dba 100644
> > --- a/distro/systemd/openvpn-server@...1685... +++
> > b/distro/systemd/openvpn-server@...1685... @@ -12,7 +12,6 @@
> > PrivateTmp=3Dtrue RuntimeDirectory=3Dopenvpn-server RuntimeDirectoryMod=
e=3D0710
> >  WorkingDirectory=3D/etc/openvpn/server
> > -ExecStartPre=3D/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0
> > && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when
> > being managed by systemd" ; exit 1' ExecStart=3D/usr/sbin/openvpn --sta=
tus
> > %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps
> > --config %i.conf CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN
> > CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT
> > CAP_DAC_OVERRIDE LimitNPROC=3D10 diff --git a/src/openvpn/init.c
> > b/src/openvpn/init.c index 551e579..7ab5c52 100644 ---
> > a/src/openvpn/init.c +++ b/src/openvpn/init.c @@ -926,6 +926,13 @@ bool
> >  possibly_become_daemon (const struct options *options)
> >  {
> >    bool ret =3D false;
> > +
> > +#ifdef ENABLE_SYSTEMD
> > +  /* return without forking if we are running from systemd */
> > +  if (sd_notify(0, "READY=3D0") > 0)
> > +    return ret;
> > +#endif
> > +
> >    if (options->daemon)
> >      {
> >        ASSERT (!options->inetd);
> >=20=20=20
>=20
> NAK on this approach.  We cannot dictate that users _must_ start OpenVPN
> as a daemon via systemd if it has been built with systemd support.
>=20
> I understand the sentiment for this change, but we need to ensure users
> may use their own scripts and hand-crafted configs to start OpenVPN,
> also if systemd is present.

We do not dictate anything. Starting openvpn from scripts or command line
this is a no-op. From man sd_notify(3):

> On failure, these calls return a negative errno-style error code. If
> $NOTIFY_SOCKET was not set and hence no status data could be sent, 0 is
> returned. If the status was sent, these functions return with a positive
> return value. In order to support both, init systems that implement this
> scheme and those which do not, it is generally recommended to ignore the
> return value of this call.

That is what we check for here: If (and only if) openvpn is started from
systemd (read: from a systemd unit/service) it denies to fork. The openvpn
service starts properly even with "daemon" in config file.

This is unrelated to systemd being installed or the system being booted with
systemd.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/G4Gcluvby.j+AeCojAMx/sk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlg+xHQACgkQiUUh18yA
9Ha8ZwgAuH9TN/8plOb4crE3c6dn0tS7yUn7ibfM0kaKOWXVbQSG1R04vIs2NcWq
3DEClszKFmjWRgJtHEoPnJpELHYJiRBzyDEFOhRgyGC6809tb7UfZ+w31xVZ2jEc
E5ABi7PFq7i+E8ALCxVPs0o2kZTPzrHGDyn0mIiINPwV+Le3y3pLbpZ5g65GOPBW
jzTdTweW1Cn9bhum1EzKSxuB0Sz6ihz8LW7MZOfTXAnQwogEDwoUXeYIm7rHZDi5
bocApFy4Y4Wj/BIYSb2tYAoUZsBbzMUB6Boq/dFayWA7WD4fiD0QUXbMQijIe0t4
TOJxAOsFbHwK2Luk5ussNR0Wsy6DXQ==
=yfaZ
-----END PGP SIGNATURE-----

--Sig_/G4Gcluvby.j+AeCojAMx/sk--

