Date: Sat, 24 Oct 2020 21:43:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201024194301.GB976@...1296...>
References: <20201023113431.26691-1-arne@...1227...>
 <20201023113431.26691-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="raeF0v9V3uM6lh8B"
Content-Disposition: inline
In-Reply-To: <20201023113431.26691-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] xmit_hold is only required for
 port_share
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

--raeF0v9V3uM6lh8B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 23, 2020 at 01:34:28PM +0200, Arne Schwabe wrote:
> Make options.c only set xmit_hold when port_share is active to least
> document this dependency. I have not actually tested if this dependency
> is actually true (or if port_share could work without xmit_hold).

I'm not sure I understand this patch, or the flow.  Before this patch,
xmit_hold is always set to "true" for TCP_SERVER, after this patch,
only for server *and* port_share.

What am I overlooking?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--raeF0v9V3uM6lh8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJflIPCAAoJEB2Cnv7KVigScqEL/1xydgGi4jF61ozcVof/Yhoo
hSkYpJvYgyJCZOe+0O7gnL6zZ1KR7Tdn8CmFEtAZyF3WMnRqR24HVixxdgD9WQ9n
88NemcrdLVhUtgA9MjNpzm1xFLak20xC1r6QEkWwnabR5/vdxSL2f7+RgMjTAnZm
3rPilqbuC2JKgH5F7j+7udN6VwmOSrMeYLE7SuC4MrbtDcY72Z4mmZwxnPUWoaEa
NoiFPjNkvdtM7h8WCNeKU7Yuj2+wTDvqGI9y/jmbcC1qE51iymAZiWPeaDAL1QS8
DLwHBi0Kd92ZWI/xlGt6wYIqz4Vs/Z9EBxLwikJwjn8OYqhuftxgPryJKx2KN/0X
Fn2Hu2JHHiouCi0tLVQUcqx/TUz4vCelSDL1LdAlfQDIK5ACJMyhhFjjWylpdJkM
AmyrD4ApuxYNoB/9O6uyhURVrZnw5CmU98yOe2sKGJKvFJTQxa7ahSh+fT5LtXpA
DcQXSUhZpCu+jQ7bxg4hVUR4/nHM0WeiHZCB4hJDGQ==
=84pS
-----END PGP SIGNATURE-----

--raeF0v9V3uM6lh8B--

