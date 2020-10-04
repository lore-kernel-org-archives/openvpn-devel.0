Date: Sun, 4 Oct 2020 15:14:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201004131457.GL976@...1296...>
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Nm48CqPeykZpOG4/"
Content-Disposition: inline
In-Reply-To: <20200930131317.1299-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Allow 'none' cipher being specified in
 --data-ciphers
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

--Nm48CqPeykZpOG4/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 30, 2020 at 03:13:06PM +0200, Arne Schwabe wrote:
> Although we want to get rid of none as cipher, we still have not
> deprecated it. In order to use it currently you need
> --ncp-disable together with --cipher none to use the none cipher.
>=20
> In our current situation allowing none to be specified in data-ciphers
> is the lesser evil.
>=20
> This commit also fixes that we use '[null-cipher]' instead 'none' when
> setting remote_cipher
>=20
> Patch V2: Also work correctly if remote_cipher is NULL.

I was about to ACK-and-merge it, but it fails the "ping IPv4 with 3000 byte=
s"
test, triggering

2020-10-04 15:10:58 us=3D638418 cron2-freebsd-tc-amd64/2001:608:0:814::f000=
:21 TCP/UDP packet too large on write to [AF_INET6]2001:608:0:814::f000:21:=
50629 (tried=3D1529,max=3D1526)

on the server side.

"Wat?"

(I could speculate that this was always broken for --cipher none, but
since you've made me add two new testcases for it, I want this to actually
work...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Nm48CqPeykZpOG4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfecrQAAoJEB2Cnv7KVigSxJwL/itsWVLtBiMl21TeL/x0SiQB
0gNntyttbutZPe1QXm+NuPNYfbufV9jp3JPc3ydFdNQHkO7gSRRjLyu87qaH4u0/
ovKgKO7JJs0sVTfWtUUqSCJfkOS+Vz73KMhF3+4UQx48+8YEUXwM11VwDhKYvJUh
5LI9nLGrpMOs3v7LMd/63/NvQuTQeqHJajHzafkk+f0u625xkqHf7R8/fHLStghh
hZLyNb1SsEsZtYwGML0TiKV9Z9o/sTrpl5yEQbgB0JGAdpopZQdbxMU9eq998TmR
SrWHgT3bskDlKOF2sauihdjaz7lF8WHCfbp4yvoPaTYJxkXitio3am1aNB8I0aRT
3GQhUNktlRFtmpoO666SSyre2Nuz17x5krVXYku6hbCH+2cjYUH8cjNXrIUJW9WZ
0KyRudL5w0VfA+AfDOFGESEIC9EiYMInwUSNgVc9M6l4I7sL/OTWWG+l9kkcZV+E
wv3YmKq1SJxG5aBufB9OPJvOurgayoUBNn68cU26Kg==
=WHeP
-----END PGP SIGNATURE-----

--Nm48CqPeykZpOG4/--

