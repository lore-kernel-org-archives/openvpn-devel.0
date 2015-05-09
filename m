Date: Sat, 9 May 2015 16:06:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150509140640.GS382@...1296...>
References: <1430766398-17209-1-git-send-email-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf878oECjVTnCF6M"
Content-Disposition: inline
In-Reply-To: <1430766398-17209-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] polarssl: disable 1/n-1 record splitting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Qf878oECjVTnCF6M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 04, 2015 at 09:06:38PM +0200, Steffan Karger wrote:
> Disable record splitting (for now).  OpenVPN assumes records are sent
> unfragmented, which is no longer a valid assumption when record splitting
> is enabled (which polarssl/mbedtls did in 1.3.10, see trac #524).

ACK.  Had to manually apply it, as the line numbers differed too much
for git to be comfortable - patch was fine with it, though...

Patching file ssl_polarssl.c using Plan A...
Hunk #1 succeeded at 738 with fuzz 1 (offset 11 lines).
Hmm...  Ignoring the trailing garbage.

commit d0f26fb524744a63615a1bf4e7ddcefcd102b328  (master)

Author: Steffan Karger <steffan@...1856...>
Date:   Mon May 4 21:06:38 2015 +0200

    polarssl: disable 1/n-1 record splitting

    Signed-off-by: Steffan Karger <steffan@...1856...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1430766398-17209-1-git-send-email-steffan@...1856...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9646
    Signed-off-by: Gert Doering <gert@...1296...>


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Qf878oECjVTnCF6M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVU4UcKkuBuNlUUl1AQIQRwP+MmqopK7L0ApSTi9ZjvlwNueNYYy8hXat
6jzfXxtE5Dx0qYLuHd9zg16C1FmrsTpoYbZnKB4fvDaodNGA665CQyyiZ56LCByF
Xm/S+yw/zT1Ktf+F5/0Terb8BN2sSdTy7Jxz7xfQP41D6T5WoI01dgtc9+LG0iXk
IX8aPlOwLvU=
=CTv7
-----END PGP SIGNATURE-----

--Qf878oECjVTnCF6M--

