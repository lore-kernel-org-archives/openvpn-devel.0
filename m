Date: Mon, 12 Dec 2022 13:03:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5cYjSu0D5P4QMIZ@...1296...>
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FC89QsK5/Uqqmcdx"
Content-Disposition: inline
In-Reply-To: <20221126162648.150678-2-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

--FC89QsK5/Uqqmcdx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 26, 2022 at 05:26:48PM +0100, Max Fillinger wrote:
> The current code only checks if the base64-encoded metadata is at most
> 980 characters. However, that can encode up to 735 bytes of data, while
> only up to 733 bytes are allowed. When passing 734 or 735 bytes, openvpn
> prints a misleading error message saying that the base64 cannot be
> decoded.
>=20
> This patch checks the decoded length to show an accurate error message.

This patch looks overly complex to me for "change 735 to 733" - could
you (or Arne) explain the change a bit better?

(I see that the patch has an ACK, so this is not a showstopper, just
be being confused)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FC89QsK5/Uqqmcdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjlxiNAAoJEB2Cnv7KVigSAQkL/0MQ5tD7VPYyAE2h6f3ifVp9
XheSERK/miuLu7OZZCXi0gYx3JVmXL3DDk5xnNyy6NL9AIOC+xuqNEt2ek1SQVjn
aUPeIMn8N3xlFzyXnVUVFDxdBwROnTEEA2YXX5eC+HEFsxvxGArsiUTZ4H1d954W
vuFuui9R+7RiFWoPcuCj2cdypNa8G7Gx02+EJiQYR/aoaXpDGEScqCRPNOXWRXAu
t7NL5JdM6GTX7qhmfL6zUtOcpkWPTk99JEMezFCTpOxmxkbkFYfv/glpoUW1Ttm2
klFpm+Djd+JCZlM8wRV3g+uXjJ1bFc0AVGELvAxLX/31SgsHEU2/7FasofaTgZQ5
tBYTDb4iMj6hP0KSj/PXkBBh6dqvyEw+3tc9doKFlSDVWlHK88wC36TQx9gjVu7N
/ixtGj/6HYD1v4BI4o7z+B4WUCs6m88g+ZBs376w4JNSLETTfbcmm0+9njn3eLbS
jcKT3jA9BVsnoznJ00szljDHWj5+pVE/lr/uB+/aMA==
=jV4h
-----END PGP SIGNATURE-----

--FC89QsK5/Uqqmcdx--

