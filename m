Date: Fri, 2 Apr 2021 17:20:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210402152047.GR976@...1296...>
References: <20210401131337.3684-1-arne@...1227...>
 <20210401131337.3684-14-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Zqw0emUhqiouFqEF"
Content-Disposition: inline
In-Reply-To: <20210401131337.3684-14-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 13/14] log file descriptor in more
 socket related error messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--Zqw0emUhqiouFqEF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 01, 2021 at 03:13:36PM +0200, Arne Schwabe wrote:
>              if (extended_msg)
>              {
> -                msg(x_cs_info_level, "%s %s [%s]: %s (code=3D%d)", descr=
iption,
> +                msg(x_cs_info_level, "%s %s [%s]: %s (fd=3D%d,code=3D%d)=
", description,
>                      sock ? proto2ascii(sock->info.proto, sock->info.af, =
true) : "",
> -                    extended_msg, strerror(my_errno), my_errno);
> +                    extended_msg, strerror(my_errno), my_errno, sock ? s=
ock->sd : -1);

I'm not sure if I'm misreading this, but "fd=3D%d" is added before "code=3D=
%d",
but the "sock->fd" thingie is added at the end.

So I tentatively NAK this.

> --- a/src/openvpn/event.c
> +++ b/src/openvpn/event.c
> @@ -555,7 +555,10 @@ ep_del(struct event_set *es, event_t event)
>=20=20
>      ASSERT(!eps->fast);
>      CLEAR(ev);
> -    epoll_ctl(eps->epfd, EPOLL_CTL_DEL, event, &ev);
> +    if (epoll_ctl(eps->epfd, EPOLL_CTL_DEL, event, &ev) < 0)
> +    {
> +        msg(M_WARN|M_ERRNO, "EVENT: epoll_ctl EPOLL_CTL_DEL failed, sd=
=3D%d", (int)event);
> +    }
>  }

The rest of the patch looks reasonable.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Zqw0emUhqiouFqEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgZzY7AAoJEB2Cnv7KVigSKpcL/0KWYjEfxKiwiRdeuLog2GLP
iGWNqOrrNJ3qVnipiFgxr1F/KBYGgQo3/uLhts0ZorHlZAL2fX22+y0Gf/WLV+n0
C8AOXzlEDgIVz/sfMAO4bjQDNN2lTC9iznOdTtoc97Ql+E6vDZCyItp6oNlQEyQn
gBJnrvvoBONJ6U0ajJf/caqTL6hMy6zBwq6r7TZuuwyh7XYClzCAF3m7wtRv3NsY
INDty4V/cuXg1kSh0X9iKbd4PbbKhErX0HzUEFiXufxFfaE9p/9mybier5Q59vqm
L/48ysd76zW5sGivSPas2K2WDHatJ2K4asbraq1U6kxRVMhBeHmGSO8KdMhAMd8y
GfibGOFHuGCeQDTDyOJ23zlLPCaxQigzX+wjQ51npUhVA999HlSju6cSFrnayJbM
yJYJWrRPw1mdLrBP/r90MlSJFvfiBtPfzPInnPC7e08x9fgFARh2Pj91RsReTVB5
KWUZfBSgMnKa6BPuI40lTp+JPSxrTSEUUPhD1lxC+A==
=a0OZ
-----END PGP SIGNATURE-----

--Zqw0emUhqiouFqEF--

