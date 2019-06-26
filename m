Date: Wed, 26 Jun 2019 08:35:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190626063502.GS1097@...1296...>
References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p7xCt7SCsg4fkJ38"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
Subject: Re: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p7xCt7SCsg4fkJ38
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 26, 2019 at 01:48:34AM +0500, ???????? ?????????????? wrote:
> 2) use push "compress empty" (if there's such an option) ?

you can do=20

  push "compress"

with no arguments.  According to the docs, this will enable compression
framing format, but no actual compression.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--p7xCt7SCsg4fkJ38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdExIVAAoJEB2Cnv7KVigSrpEL/A3LsNR85xYdPd2ASzXeiTt0
ilYAkD27Sei83s55IqlU7sAYxMPBQEnYTFDdeW0ZM8F6mp1L+epkKhLfYgNxsHqv
jlJQT0qwMWkinK8ILOTCTdXsm/2jx0+UJxbsjy5xhPilD788R+nd5qXHxcLF6Qlr
t6W6tppONaWkh5Zi20Xw0hVWLzq35jmvgpPaqRh+vIKMTYFubIMtUm+JfzkOcOiZ
5So8s6f+D9RcLNdd74hpGwwNBXqDuWbqqL9iywfpwshAkkbIy2lxQmfcpQ7SXpJE
xQfoCO+UkWXcf+WTopXsFEcL4LmLnnnW3k9LSdwxMSHpBLZeH0QWK+62qsdGU+oh
bQ5vGN7pWXDjITe/Jacfe9UIQub856vG9e3LjBsB+jPIC80Q9fYQ2DKI9dCl5PeI
oTbckjFvIvhIbs7lhTiT9L2UySYALFI7YJIVUZYWCKSmr/Ush307ppQUW3hVt4qt
X8+kr9EiTT6wSOUCS+3Fp/p9fqq6iWAeaU79EFamMQ==
=s0mL
-----END PGP SIGNATURE-----

--p7xCt7SCsg4fkJ38--

