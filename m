Date: Sat, 10 Dec 2016 13:29:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161210122923.GF78624@...1296...>
References: <20161209183724.5c11d987@...1799...>
	<20161209231907.16486-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3M7QbeJEF900HlmX"
Content-Disposition: inline
In-Reply-To: <20161209231907.16486-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification
 socket into chroot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>, David Sommerseth <davids@...515...>

--3M7QbeJEF900HlmX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 10, 2016 at 12:19:07AM +0100, Christian Hesse wrote:
> +              int fd;
> +              char * chroot_notify =3D NULL;
> +
> +              if (sd_notify(0, "READY=3D0") > 0)
> +                {
> +                  asprintf(&chroot_notify, "%s/notify", c->options.chroo=
t_dir);
> +
> +                  if (unshare(CLONE_NEWNS) !=3D 0)
> +                    msg (M_ERR, "unshare failed");
> +                  if ((fd =3D open(chroot_notify, O_WRONLY | O_CREAT | O=
_TRUNC, 0644)) < 0)
> +                    msg (M_ERR, "touch failed");
> +                  close(fd);
> +                  if (mount(getenv("NOTIFY_SOCKET"), chroot_notify, NULL=
, MS_BIND, NULL) !=3D 0)
> +                    msg (M_ERR, "bind mounting notification socket faile=
d");
> +

This is WAY over the top of what should go into OpenVPN code.  Really.

NAK on approach, NAK on code.


Is there a way make sd_notify() behave like syslog()?  That is, you call
something like "openlog()" which will acquire the necessary file descriptor
and then you can afterwards chroot() to your heart's content and do not
need access to the actual socket file anymore (because openlog() will
keep it around for syslog() to use).

If sd_notify() cannot be taught to do that, either do what David proposed
(disable chroot if running under systemd), or at least move that code=20
out of init.c into something like platform.c.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3M7QbeJEF900HlmX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYS/UjAAoJEB2Cnv7KVigSW3ML/i8Fw5YZ+nB7ljAQ1LbtGS2X
LFVOCIf7qz0skFQc4FFbZK2M5e2W/+z8Lb4lryKgr09kvMcTIigKSwH3UBeoW1b9
75UqzUQVx90sh3WEQfOHJLabbVjnlEyh09d31AkFu5XJKRtReTz+ruCDby+wWlO/
aHoqy5jWhICHlVQi1K7PHSxUZviYG0BZocO2itpTMmAo7LEIf40MI9Tjv5AHy/gx
PkSgXAlMX2Mh5yUXz4tIz6yxSO/pC2+bdAtWVWWg3acINButsQJVYCDoSadY0qjx
+sCbQUtmCznYJhT49z112t8llY5td2zGHNbqn4cGpevngc6kYwBcVpiQ8nwY2O38
PYnRVE9GUkaPi4BWIAKtBAO/+v4mZEFnDhjsvT2i4YuRaO/FjUUij7OScGpRqcFK
UUyytXyvhep0l6Bf5QOzqjI77BM6kriJb9p7x8jyU9ubudsCPOR9DWOrQ5UFjmwO
BPntAYhDSkOJOLSS8wx4RGJOmGjv3Ifzklw9mTMorA==
=1TFm
-----END PGP SIGNATURE-----

--3M7QbeJEF900HlmX--

