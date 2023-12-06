Date: Wed, 6 Dec 2023 17:57:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZXCoEy0koFe5SSF1@...1296...>
References: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sZMaPxRgdpTeNBq5"
Content-Disposition: inline
In-Reply-To: <tencent_C49D67EAA5678D180C293706A9469EFE8307@...1414...>
Subject: Re: [Openvpn-devel] [PATCH] fix(ssl): init peer_id when init
 tls_multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: yatta <ytzhang01@...2752...>
Cc: openvpn-devel@lists.sourceforge.net, pushan <62173185+pushan01@...2668...>

--sZMaPxRgdpTeNBq5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 20, 2023 at 01:12:13AM +0800, yatta wrote:
> From: yatta <ytzhang01@...2752...>
> From: pushan <62173185+pushan01@...2243...>

So, we have a patch that fixes a problem and an ACK for it, but for
a proper commit I actually need something like a real name and a
working mail address...

Could you provide a Signed-off-by: line, like what we have on other
commits, for example:

    Signed-off-by: David Sommerseth <davids@...515...>

(this does get relevant in case we end up having to do a license
change again, and wanting to contact contributors...)

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

--sZMaPxRgdpTeNBq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlcKgTAAoJEB2Cnv7KVigSHiIMAKieNqPHJgi300S4C7TOTlOm
wZetKAdZx3rqXTZKdoIZvkfqZ/I+BjqDm4oS8LaUOUKaQw0chCSQlFrn5wypoN/h
beHsKC7TkQzzxRJFNZy1VkJe57d650rlsEn0Li4Nt5rWPOCpxJxjZTSdsRghZHTk
YLB1hw8ZxvITlGRiXJAXLi245PeIRvnDbaeWJ+0yImLEnjjj3ffzXPsvN4HjG5hY
PGd0JanI9SECNiTImFPENdDjfb9PEw30v5GIC+fdTH/vQ9ZK9fwD/BCGr2liL+U2
NE0+VVV1n1jYaFUnZEJpgYPEEXqPk9OTkpacfr+liitnucrndhhC1gKmy7nPfls6
V+gV2UJln1hbP2xpQM0VRKac8CMhCvvDQ0oztv8lRi8AqBFAUhiHKBCIa31T+74l
qvkeFi5vkmL+/cVkxzs9sSq5bFwBFbj+wQ4n1MGK7PdcPr0CNFLe7XOk2J/Ry67Q
XhZAXAZUpR4BQLLQN+ld/Vab1k/rJs59Qj0SomsaYw==
=jKT4
-----END PGP SIGNATURE-----

--sZMaPxRgdpTeNBq5--

