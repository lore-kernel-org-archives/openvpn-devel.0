Date: Fri, 9 Dec 2016 18:59:26 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161209185926.6bd71feb@...1799...>
In-Reply-To: <20161209183724.5c11d987@...1799...>
References: <1481079112-22990-1-git-send-email-davids@...515...>
	<20161209183724.5c11d987@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/ToM+HQsGjxxhsBn2H8Mr7Fu";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Intermediate --chroot fix with
 the new sd_notify() implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/ToM+HQsGjxxhsBn2H8Mr7Fu
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@...1798...> on Fri, 2016/12/09 18:37:
> David Sommerseth <davids@...515...> on Wed, 2016/12/07 03:51:
> > Commit c5931897ae8d663e7e introduced support for talking directly
> > to the systemd service manager about the situation for the OpenVPN
> > tunnel. This approach makes a lot of sense and is mostly the proper
> > way to do it.  But it was discovered that it breaks OpenVPN
> > configurations using --chroot.
> >=20
> > The reason sd_notify() calls fails when using chroot() is that
> > sd_notify() expects to have access to a file as declared in the
> > $NOTIFY_SOCKET environment variable.  It is the main systemd
> > instance which is responsible to provide both the environment variable
> > as well as the socket file sd_nodify() should use.  When --chroot
> > comes into play, the $NOTIFY_SOCKET file will not be available
> > for OpenVPN any more.
> >=20
> > As things are getting close to the 2.4_rc2 release we will not dare
> > to bring a too invasive fix.  As well we need some time to discuss
> > an approrpriate solution.  So this intermediate fix will only
> > provide a "successful start" message to the systemd service manager
> > right before chroot() happens.  This will at least resolve the issue
> > in a safe and non-intrusive way.
> >=20
> > Signed-off-by: David Sommerseth <davids@...515...>
> > ---
> >  src/openvpn/init.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> > index 74f1139..e47f0d4 100644
> > --- a/src/openvpn/init.c
> > +++ b/src/openvpn/init.c
> > @@ -967,7 +967,27 @@ do_uid_gid_chroot (struct context *c, bool no_dela=
y)
> >        if (c->options.chroot_dir)
> >  	{
> >  	  if (no_delay)
> > -	    platform_chroot (c->options.chroot_dir);
> > +            {
> > +#ifdef ENABLE_SYSTEMD
> > +              /* If OpenVPN is started by systemd, the OpenVPN process
> > needs
> > +               * to provide a preliminary status report to systemd.  T=
his
> > is
> > +               * needed as $NOTIFY_SOCKET will not be available inside
> > the
> > +               * chroot, which sd_notify()/sd_notifyf() depends on.
> > +               *
> > +               * This approach is the simplest and the most non-intrus=
ive
> > +               * solution right before the 2.4_rc2 release.
> > +               *
> > +               * TODO: Consider altnernative solutions - bind mount?
> > +               * systemd does not grok OpenVPN configuration files, th=
us
> > cannot
> > +               * have a sane way to know if OpenVPN will chroot or not
> > and to
> > +               * which subdirectory it will chroot into.
> > +               */
> > +              sd_notifyf(0, "READY=3D1\n"
> > +                "STATUS=3DEntering chroot, most of the init completed
> > successfully\n"
> > +                "MAINPID=3D%lu", (unsigned long) getpid());
> > +#endif
> > +              platform_chroot (c->options.chroot_dir);
> > +            }
> >  	  else if (c->first_time)
> >  	    msg (M_INFO, "NOTE: chroot %s", why_not);
> >  	}=20=20
>=20
> Looks good to me, so: ACK
>=20
> In long term we should think about a proper solution. Notification socket
> is /run/systemd/notify, so we would have to make that available from with=
in
> the chroot.

BTW, systemd used to use abstract sockets for notifications, which worked w=
ith
processes that chroot themselves. This was changed [0] in favor to
PrivateNetwork setting. Private network (in terms of systemd) is nothing we
can make use of, though. Obviously... :-p

Does it make sense to deny to chroot when running from systemd and instead
add some more security features to the systemd unit? Things like
ProtectSystem=3Dstrict, ProtectHome=3Dtrue and friends. See systemd.exec(5)=
 [1]
for details.

[0]
https://github.com/systemd/systemd/commit/7181dbdb2e3112858d62bdaea4f0ad2ed=
685ccba
[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/ToM+HQsGjxxhsBn2H8Mr7Fu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhK8P4ACgkQiUUh18yA
9Hb8bggAxY8kOV2VrzaFh2qQV4eUdad/Bu8O0IdJd2Sn1Ouc/vENHv64OJYU3Ywg
jW7pFZjcB2Pg/hCNyIPoC6MOYjdETG56OCZECNmaYT+vZyfCgS7q6lAn+KL1+ErE
ZeFHoObTEhAO9pHwfMGN+GQ7DMfabLu7O3PnJu4mqzTzetpi2n5kn46nzg+4OxMR
eayQCmaEA12mSLsN+F26pUENSoVqk5eA+EcBI3aFo/cNkTZ8ICtalWOkRA8AW/VU
ypyzLdSekYOgzMW2U88JLFwmo7kSN5Bzcb6VDwgc05vERnIUGx4hsuZJqwSdqzKZ
IMEI38/fD4kJR7Gwg5lzYYtgTU/1NQ==
=2q8H
-----END PGP SIGNATURE-----

--Sig_/ToM+HQsGjxxhsBn2H8Mr7Fu--

