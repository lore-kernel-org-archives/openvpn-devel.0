Date: Fri, 19 Nov 2021 21:11:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZgE5jvvKsbz8Tvf@...1296...>
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uul+NjshU2AJyVSe"
Content-Disposition: inline
In-Reply-To: <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: lstipakov@...277...
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uul+NjshU2AJyVSe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 19, 2021 at 10:04:50PM +0200, lstipakov@...277... wrote:
> Ok, my idea was to fix only config loading dir. Apparently this is not en=
ough, so I???ll look into ENGINESDIR too.=20

Well, it's "enough to fix the problem we have today", but if we can fix
the problems we might have tomorrow in the same go, less work in the long
run :-)

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uul+NjshU2AJyVSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhmATmAAoJEB2Cnv7KVigSboQL/RcafjV4oFmw7expZk9bkB3P
avmtlj83oDLsSbu5X+rBQLFWpWi6bexR+vVGlGbokte4YG70jjhZSb8nupJKNOE8
I6wrHB7zLGYy3opXfjfA4G1sC5RhbHCktZBB/AQHq1giVwHp5CMZSoWULZJaCn60
QTOk6dsoJMRoyirLd2CVsXd6CgELf+C2mS25TcMRXmeq1m09sm/aLBiDvUKje+PC
Hs3vX4A7UlObDl5AEppcSpM44miyXIoi5dEp2TZ9ifd6ylusG625OKidAoR4fgBp
5KRjlpjZz7FlMkD9Cjq2szdQmKOqYcrpZkWR/JEFDkHzyTpg5iIG/51+CcHmZh0u
7lIBtyLcAl95OJliGt7agdjAO2Z+QPJhDaPI7Cd5Fm/Pu0q3YLWtC6G0Yh6EL7pV
gquyIVyDtFcP9E/c/IwiGPXHwVNZ3ym0K/+HtlUMIrdlyB7k+8a+gw9TKYxW7Yb7
ROGr1HejHLglHiz1eohlQ/qrGq3YGBtuqGE7nhzA/Q==
=2oTZ
-----END PGP SIGNATURE-----

--uul+NjshU2AJyVSe--

