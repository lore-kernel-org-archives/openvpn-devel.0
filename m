Date: Wed, 5 Aug 2020 14:41:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200805124152.GD75094@...1296...>
References: <20200805102333.3109-1-themiron@...2010...>
 <202008051154.075Bsv9p086558@...2054...>
 <000d01d66b23$d2e48f70$78adae50$@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fLj60tP2PZ34xyqD"
Content-Disposition: inline
In-Reply-To: <000d01d66b23$d2e48f70$78adae50$@yandex-team.ru>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Log serial number of
 revoked certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: 'Gert Doering' <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--fLj60tP2PZ34xyqD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 05, 2020 at 05:27:45PM +0500, Vladislav Grishenko wrote:
> Thank you.
> I'd appreciate if patch could be applied to release/2.4 too, no changes a=
re
> required - related code is the same, just hunks offset in ssl_verify.c and
> ssl_verify_openssl.c
> I've tested 2.4.9 [git:release/2.4/7c428ca19a8df6b9+] with patch on sample
> certificates, please refer log is below:

OK.  Done.  Thanks :-)

commit 4ee2c1cd877b2e99b41fd248bf853329af825188 (HEAD -> release/2.4)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fLj60tP2PZ34xyqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfKqkPAAoJEB2Cnv7KVigSZyML/0GLFBdAXABymVB1yaVgZ4tv
rNS67+Jge8Fo0dJdRvZbfTS2ekBvUYEip7ttbFkUrykLwZP0r4Rpfo3Tk0wdPrPd
NlstSrSC+sfmeKw0mb26RonQ3QCJy4vC1PrPHZZ/jzLk//yqTDsNTGCfS2gs0Nl7
8dOZ+ccIOYPWus3ELDPwfYG4Ui2I1zSm1tkEu8w1zm+RJWZNNxuaDDJtxosDY+sy
vLITq029T8ykKSuMRw3tn5SAFwksf3XTT8cAjBAuXLGLJduR2Nuc7f7iVE4HwNu7
sBGeY66br4etyNmiHeKMQmv1hiME2VbQX1yyL/6OH951jrAsZlfcfooKTn8aqS+i
07kmFXu3WoO6RIHpdSTiorPudRI3spbu+UbWzKyPUfIY+uO+bgbSDx6J9ShMQbEe
UaOW9kRJPoTgif5e8WX2etnturGuhM//zPoS+fXftMNmdYmstd94JSaf7Hu45B/v
33isoQFOAzHGIQy3rSktpO/vAurVpvFwJVYypDSxVA==
=G+h8
-----END PGP SIGNATURE-----

--fLj60tP2PZ34xyqD--

