Date: Sat, 14 Nov 2015 20:40:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151114194047.GA24952@...1296...>
References: <1425307803-14166-1-git-send-email-lstipakov@...277...>
	<1444747558-23291-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XrjDSOQsS4AlGTKt"
Content-Disposition: inline
In-Reply-To: <1444747558-23291-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Notify clients about server's
 exit/restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--XrjDSOQsS4AlGTKt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 13, 2015 at 05:45:58PM +0300, Lev Stipakov wrote:
> When server exits / restarts (gets SIGUSR1, SIGTERM, SIGHUP, SIGINT) and
> explicit-exit-notify is set, server sends RESTART control channel command=
 to
> all clients and reschedules received signal in 2 secs.
>=20
> When client receives RESTART command, it either reconnects to the same se=
rver or
> advances to the new one, depends on parameter comes with RESTART
> command - behavior is controlled by explicit-exit-notify in the server co=
nfig.
>=20
> v3:
>  - Use control channel "RESTART" command instead of new OCC code to
> notify clients
>  - Configure on the server side (by value of explicit-exit-notify) if
> client should reconnect to the same server or advance to the next one
>  - Fix compilation when OCC is disabled (--enable-small)
>  - Update man page

Thanks for this.  A few observations...

 - it does not apply anymore, due to new code in multi.h
   (someone committed #ifdef ENABLE_ASYNC_PUSH in the meantime :-) ),
   so I'd appreciate a rebase

 - I'm not totally happy about the #ifdef ENABLE_OCC and the fact that
   multi_push_restart_schedule_exit() is not #ifdef'ed as well (a smart
   compiler will optimize it away, as it is static and not called, but=20
   I'm not sure whether it is considered good style).=20=20

   Since the new server side code does not actually *do* OCC any more we=20
   are just #ifdef'ing it to access options->ce.explicit_exit_notify=20
   because that one is only compiled in #ifdef ENABLE_OCC ... so we're
   coupling this new functionality to an #ifdef which is not really=20
   relevant.

   No good suggestion yet, just expressing thoughts...


gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XrjDSOQsS4AlGTKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkeOPqkuBuNlUUl1AQK5wAP+Olg86CQbkvmbuv8h7fS6A0RDFZc4UGU9
imI+VcoQ/1RrbpMRnwXnqbGypz2grD10yk0tMWcrTemwmE3m24PQnUIzxVEECrNK
p754+1+H22rpZZwnIdYyYzIT2isCKB/lGTD4wNFr9LiOg7Pp63O2rQkrq/5qS/0J
Pr60h32YbXM=
=QJS6
-----END PGP SIGNATURE-----

--XrjDSOQsS4AlGTKt--

