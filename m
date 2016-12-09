Date: Fri, 9 Dec 2016 18:37:24 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161209183724.5c11d987@...1799...>
In-Reply-To: <1481079112-22990-1-git-send-email-davids@...515...>
References: <1481079112-22990-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/gx/IlqCPmGs9KR9xoQt_.Vi";
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

--Sig_/gx/IlqCPmGs9KR9xoQt_.Vi
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <davids@...515...> on Wed, 2016/12/07 03:51:
> Commit c5931897ae8d663e7e introduced support for talking directly
> to the systemd service manager about the situation for the OpenVPN
> tunnel. This approach makes a lot of sense and is mostly the proper
> way to do it.  But it was discovered that it breaks OpenVPN
> configurations using --chroot.
>=20
> The reason sd_notify() calls fails when using chroot() is that
> sd_notify() expects to have access to a file as declared in the
> $NOTIFY_SOCKET environment variable.  It is the main systemd
> instance which is responsible to provide both the environment variable
> as well as the socket file sd_nodify() should use.  When --chroot
> comes into play, the $NOTIFY_SOCKET file will not be available
> for OpenVPN any more.
>=20
> As things are getting close to the 2.4_rc2 release we will not dare
> to bring a too invasive fix.  As well we need some time to discuss
> an approrpriate solution.  So this intermediate fix will only
> provide a "successful start" message to the systemd service manager
> right before chroot() happens.  This will at least resolve the issue
> in a safe and non-intrusive way.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/init.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 74f1139..e47f0d4 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -967,7 +967,27 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
>        if (c->options.chroot_dir)
>  	{
>  	  if (no_delay)
> -	    platform_chroot (c->options.chroot_dir);
> +            {
> +#ifdef ENABLE_SYSTEMD
> +              /* If OpenVPN is started by systemd, the OpenVPN process
> needs
> +               * to provide a preliminary status report to systemd.  This
> is
> +               * needed as $NOTIFY_SOCKET will not be available inside t=
he
> +               * chroot, which sd_notify()/sd_notifyf() depends on.
> +               *
> +               * This approach is the simplest and the most non-intrusive
> +               * solution right before the 2.4_rc2 release.
> +               *
> +               * TODO: Consider altnernative solutions - bind mount?
> +               * systemd does not grok OpenVPN configuration files, thus
> cannot
> +               * have a sane way to know if OpenVPN will chroot or not a=
nd
> to
> +               * which subdirectory it will chroot into.
> +               */
> +              sd_notifyf(0, "READY=3D1\n"
> +                "STATUS=3DEntering chroot, most of the init completed
> successfully\n"
> +                "MAINPID=3D%lu", (unsigned long) getpid());
> +#endif
> +              platform_chroot (c->options.chroot_dir);
> +            }
>  	  else if (c->first_time)
>  	    msg (M_INFO, "NOTE: chroot %s", why_not);
>  	}

Looks good to me, so: ACK

In long term we should think about a proper solution. Notification socket
is /run/systemd/notify, so we would have to make that available from within
the chroot.

BTW, feel free to CC me on systemd related topics.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/gx/IlqCPmGs9KR9xoQt_.Vi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhK69QACgkQiUUh18yA
9Hbk0gf/YGhPQULgTsQDp8+R6Eio05RGE6jvpp9AU4Z5bNdDntnI1heSlAap3DpY
UbnYrSTHxyCDW7Mg2OTgqN0OY2y8QnmRK1MkH1Moxy3NQQOEnQQNn+RqWeDd3oh7
egpwu32ADtVMnRukdH0t7QdGQAHWcJCmcDnWyJZjENf7OdGaRIhJO6QDzjSR5f7t
0Zqyx4Qaot5xzF1ON2fdlqC5Ml9UiCwrngYTTyb4DCfdJOTYpVT/616eNS7tZrZh
Y6uh2R+ypOWltKBInZ6Ton+2Cc36MecaAzaFg3y4Gj288sIDOaYt1+meZlbeSuyv
Cm0I8SdwKJkcbx30dqW0awMFKe4amw==
=PA22
-----END PGP SIGNATURE-----

--Sig_/gx/IlqCPmGs9KR9xoQt_.Vi--

