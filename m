Date: Mon, 3 May 2021 08:14:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210503061454.GT976@...1296...>
References: <20210422152939.2134046-1-arne@...1227...>
 <20210422152939.2134046-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W2KI1jCbj385JWRB"
Content-Disposition: inline
In-Reply-To: <20210422152939.2134046-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/6] Remove support for blocking
 connect()
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

--W2KI1jCbj385JWRB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 22, 2021 at 05:29:37PM +0200, Arne Schwabe wrote:
> It is hard to imagine that we still have any supported OS that does
> not support non-blocking connect while still supporting non-blocking
> sockets in general.
>=20
> Patch V2: remove epoll.h removal that should have been in other patch.

Feature-ACK, but you missed one

socket.c:

socket_connect(socket_descriptor_t *sd,
...
#ifdef CONNECT_NONBLOCK
    msg(M_INFO, "Attempting to establish TCP connection with %s [nonblock]",
        print_sockaddr(dest, &gc));


v3, please :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--W2KI1jCbj385JWRB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgj5SnAAoJEB2Cnv7KVigSCfsL/A4IVAX5OsTwdI1Z/0IdvQFb
WeuHny7SMNzPT9t9TcO6NI/Gqi6Q8B7jcmsxWYZ+3NZd89PKjeoJTv8kxhlIsP8p
9eSxsa/UFOVtb07TtJtvYEUqFuK9I1G3VIumdFL9ag4JqruQCS9jmqa2V3RqVRNv
dy9p1DgPzLYYu/28VW3pKNDz538UhQ8dxqZ/PiH55byd2KEJrnmI43IyjB83DdjO
dAav16jLp5e/GN+LUvRSkng3NOpqqdWbDxOwNT6cjlWTDaJ3esegfw79tARwk4aX
j6suVL+3MhlrUiDROqnlwlAyRPag2VjoHa+LXdgxNS3xQeCC4IMM8rHQl6nSk+Mq
EqSoDyidrkaE2phT7oQLQtwK8D+ZNGUaq9CJXGq+HmQEL/7hEgTGdFsZLpxfC3op
N7fQYz/MP6rOuqvEkUyoj7B5fVHbVzXV+Hwup9cKwNRjzUE8ceTfCueIZPl9TPmL
imu+6dq6jPKNhpKCsfvElj3NMRwVM3NeCBm3fmEAgg==
=zWa7
-----END PGP SIGNATURE-----

--W2KI1jCbj385JWRB--

