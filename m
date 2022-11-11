Date: Fri, 11 Nov 2022 14:46:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y25SGvo5+LKpEGxz@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <YazysuRMayAaxCwo@...1296...> <Ya4vHXBmR+20/xQP@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tCK0g4ER93S+FK+c"
Content-Disposition: inline
In-Reply-To: <Ya4vHXBmR+20/xQP@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/9] Implement optional cipher in
 --data-ciphers prefixed with ?
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

--tCK0g4ER93S+FK+c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

following up on this one:

On Mon, Dec 06, 2021 at 04:41:17PM +0100, Gert Doering wrote:
> commit 766044507497c41f0319159c37992788ecb681e6
> Author: Arne Schwabe <arne@...1227...>
> Date:   Wed Dec 1 19:07:19 2021 +0100
>=20
>     Implement optional cipher in --data-ciphers prefixed with ?
>=20
>     Signed-off-by: Arne Schwabe <arne@...1227...>
>     Acked-by: Gert Doering <gert@...1296...>
>     Message-Id: <20211201180727.2496903-1-arne@...1227...>
>     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg23279.html

After some discussion on IRC, Arne and I decided that this is useful
for OpenSSL 3.0 compat in 2.5.9+ as well ("...:?BF-CBC") - when the patch
was originally done, all the "optional BF-CBC" stuff was targeted at 2.6,
and OpenSSL 3.0 support was also targeted at 2.6 only.  With the Linux
distributions shipping OpenSSL 3.0 with OpenVPN 2.5 left and right, this
causes compat issues, so "?BF-CBC" is a nice-to-have compat hack=20
(for those that *REALLY REALLY* want to enable this in their configs).

The change is small, well-contained, and has unit tests, so "okay for 2.5".

Thus:

commit abe0bb1a7f727a24e2d7cb7215cb309aea5fcffc
Author: Arne Schwabe <arne@...1227...>
Date:   Wed Dec 1 19:07:19 2021 +0100

    Implement optional cipher in --data-ciphers prefixed with ?
    (cherry picked from commit 766044507497c41f0319159c37992788ecb681e6)


It needs a second patch, though, which I also pulled up:

t b43a9b9f3324ccd7dffde3048c616aa5becc2b13 (HEAD -> release/2.5)
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Dec 6 16:08:52 2021 +0100

    Fix handling an optional invalid cipher at the end of data-ciphers
    (cherry picked from commit 868433857fbf8d71515ac0ffecb98eae893515dc)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tCK0g4ER93S+FK+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjblIaAAoJEB2Cnv7KVigSoV8L/2ySJHHRhxKVqDqq3VrXYm1Y
e6Nvdsae+PtN4RCmKOdXRDIeiFsZNlHOeymuJPzqUuT1MqxsvdFmDbSIJS2yzIJY
ZHPN0yLrxbajGj77D10VkbsZrpZxkBSJxiESH6uoGCBefq72GFLNeZpop0o1OBbx
3V2vYN5wpspiQ6cN+EDfwyn1OmN9OVUql+qe5G0/UNujRdfsNFXA1L3N7WwfcYXB
okK8P3xmMixXhgxS7aGPhfo632lsFqycM+qt5r0Wl/YRSbzfe7WO5DekuupHNNOa
djUBLa5ppMSX3B0OhSuRjLqyl5NvZC+R5msYH8EYEln5YExPUPrl5d48lfIwgTdn
+YTbrSxGPFt+/UuPc0UkRbDbCEHM3ZW+BxOyjnbwpyVZxoZccXO8Cr5MwOw3Vqpw
6MB0lS47DRKIlEJVQsXRA5bnf0ujMbKo1l3U+XNKoqWOcCGlmr/2INM/ANaZ3/uL
0Drxw+ikgQkObI5DVKsrdeKOAA4obYJ4rMW2tcEyHA==
=+upj
-----END PGP SIGNATURE-----

--tCK0g4ER93S+FK+c--

