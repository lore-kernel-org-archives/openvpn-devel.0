Date: Tue, 12 Mar 2013 12:09:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130312110925.GP953@...1296...>
References: <1363032651-23934-1-git-send-email-arne@...1227...>
	<1363032651-23934-2-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oVY0WsfUWmN/0W08"
Content-Disposition: inline
In-Reply-To: <1363032651-23934-2-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Use casts when assigning void*
	variables.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--oVY0WsfUWmN/0W08
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 11, 2013 at 09:10:49PM +0100, Arne Schwabe wrote:
> Clang in c mode warns about these. In C++ mode these are forbidden.

I'm not so sure about this chunk of changes.  I can see why you want this,
but OTOH, this is all perfectly correct C (freely converting pointers to
and from "void *" without(!) warnings), and some of these...

> -  char *p =3D gc_malloc (OPTION_PARM_SIZE, false, &gc);
> +  char *p =3D (char *) gc_malloc (OPTION_PARM_SIZE, false, &gc);

> -	      p[ret] =3D gc_malloc (parm_len + 1, true, gc);
> +	      p[ret] =3D (char *) gc_malloc (parm_len + 1, true, gc);

> -  struct route_option_list *ret =3D gc_malloc (rl_size, false, a);
> +  struct route_option_list *ret =3D (struct route_option_list *) gc_mall=
oc (rl_size, false, a);

... do not really improve readability, more to the contrary.

(Some of the other casts make the code more clear, so I'm not objecting
to all of it, just wondering... mostly about the gc_malloc() stuff...=20
this really should be "malloc() return can be assigned to any pointer")

But I'm not strongly objecting.  If you (for some vague "you") feel
strongly about having the casts, I'll accept that.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oVY0WsfUWmN/0W08
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUT8M5akuBuNlUUl1AQI28AQAu6Zqma2dqzQdotk0zQ7jUDVHqH6Ehd01
QMAnk10qcM/4DpZMrzIpCwM4Gyw5XukYQRw8OLyIaCgR0n/59T/RHe4uqaorVVeP
pmEaSBCoNI08GV5Rfyw8Q6p7GFtRJa/e5p+azw83ZD7vi6nw7BC42i0GTpbOKuRt
9+luzE6tek0=
=JI48
-----END PGP SIGNATURE-----

--oVY0WsfUWmN/0W08--

