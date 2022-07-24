Date: Sun, 24 Jul 2022 20:59:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yt2Wqc2zTdyx5Zj5@...1296...>
References: <Yt2Fdvaom94pVcOQ@...2684...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LMC9zEJTgTc8EZHa"
Content-Disposition: inline
In-Reply-To: <Yt2Fdvaom94pVcOQ@...2684...>
Subject: Re: [Openvpn-devel] [PATCH] PUSH_BUNDLE_SIZE is too short
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Angel Abad <angel@...334...>
Cc: openvpn-devel@lists.sourceforge.net

--LMC9zEJTgTc8EZHa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 24, 2022 at 07:46:30PM +0200, Angel Abad wrote:
> Hello, we have problem with a large used openvpn server, our server push =
to clients
> almos 150 routes, we havent problem with windows clients, but with linux =
clients push
> options are cut, and the clients fail to configure beacouse the route com=
mmands are cut.

Can you please show a log file that demonstrates the problem?

I know that ValdikSS was/is using openvpn with many 1000 routes pushed, and
besides "installation takes very long" he did not report problems.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LMC9zEJTgTc8EZHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi3ZapAAoJEB2Cnv7KVigS7tUMAKARwGS+U60WvqUZdjpRX+B5
rFgVuK9GZZJNNRuNdEkL/rhX0BoN0FrZ6dRWVUP8r+JAJLdfheLsH4VJnMn8MMMZ
ND/n1AE5Qkhb/VU+iwqMDZ9g17WSYZ4Fn0o7cFFNlGvRXAi87xV8ykdB+zXnO6pX
mZdD+yy/8nVorno3mB5usqtEeIy49BBz20FeSyj7OcZM1zG7xSfjVQMbghlUdQ5C
mukP92AiqBNLIvdorX38+yiKFkwo+pHE6wWNK0An2bsts+9rMf0DEVqRE+zcfbnR
ZBpDKNlXzDXrqn1xuXZa2C7w/gT2dmCf9iRxZ905AbPU2M66AILXQgD7/NPZRVco
PLkEb3kzXnBLHhU7Xsj4lKyD/yONq8l74u5yMTD63kDvBlimNo1y2rws03DnWIHe
VBry15KIuPdS28fG1HgxS37LKl0cK20/VpVb0oc66n/aLUNnOfwK30EfAZddyQcY
HdsGpkyWaf/J2JGvZ3G6U3RzKKZSvyze48aKYRSsLA==
=vW40
-----END PGP SIGNATURE-----

--LMC9zEJTgTc8EZHa--

