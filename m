Date: Wed, 28 Jan 2026 15:48:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aXoh0Qv_eazEVkXS@...1296...>
References: <20260128110425.24350-1-gert@...1296...>
 <202601281328.60SDSBrl035663@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ne5Nguch8yaylNkh"
Content-Disposition: inline
In-Reply-To: <202601281328.60SDSBrl035663@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: tunnel_server(): close
 correct inotify fd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--ne5Nguch8yaylNkh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 28, 2026 at 02:28:11PM +0100, Gert Doering wrote:
> For now, this patch has been applied to the master branch (to progress
> towards 2.7_rc6).  I will come back here to see which branches need the
> fix, or whether different "top context" handling actually made it do the
> right thing 10 years ago...

As it turns out, the code in 2.6 and earlier does not have a "multi.c", but
instead it has "mudp.c" and "mtcp.c" for UDP and TCP servers, respectively.

The code is the same, the "close(0)" is the same, but the patch cannot be
"just cherrypicked", so I've put a 2.6 patch to gerrit

   http://gerrit.openvpn.net/c/openvpn/+/1499

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ne5Nguch8yaylNkh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEti5qK05WVwt73GvgHYKe/spWKBIFAml6Ic4ACgkQHYKe/spW
KBIc5Qv6AznTBAdqd1z3w0Qisomavm6IPnNjcdSiIp+G8EmveEUr1XirmqugLtxm
Y1wAK8us7/3xcazh4EpUueD1PXE2B9aDjpvSlYzmTXBEarK3UYa6QrW5w50MZk82
0RbAgPuqjMGIgI/PniWmfR1di7F/4488Ev9qY97mGkSuStj4fA3YEKkC5HFwOQKW
53fZ/rnMcE54lde55f9mb+g7PXwetZJ+WGxoIECwvRfD5cF51cxZG+/U45S1mJgj
yhMfIuIm+DYZA4j14qIX21ceuZM1OquL4XdqOC1yK8BX/+JNzN76imDd0pRSu7fk
9xq45QQhQyduVX8FYIDKRFx5xSDcGIttDgQOthG/chAXLYZJI7iu6dMf2WLQuTIe
wY5yMTWTbFH0OwX3BtGG5a5aoANXciMqApH6r2HIpA6k8RBlwKDYO2oWpnrn1fsu
90muJgHXMUiwK/z68KOUUjRdtJBnr+XysZZnNjRbX63rX4dvXqPm90UFzVYbzXM7
HsB/ZMv+
=3Z9b
-----END PGP SIGNATURE-----

--ne5Nguch8yaylNkh--

