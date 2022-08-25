Date: Thu, 25 Aug 2022 22:20:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwfZjPRBjHwOTDSB@...1296...>
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-5-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iIFHIp+zwdKq08NE"
Content-Disposition: inline
In-Reply-To: <20220813204224.22576-5-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v101 5/7] dco-win: update GH Actions
 config file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--iIFHIp+zwdKq08NE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 13, 2022 at 10:42:22PM +0200, Antonio Quartulli wrote:
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .github/workflows/build.yaml | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index c89d3c8c..6bd108b9 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml

This does no longer apply (Arne has sneaked in other updates to build.yaml).

When you send a rebase, please include something resembling a commit
message :-) - otherwise the "empty commit message whitespace dragon"
will eat the patch.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iIFHIp+zwdKq08NE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjB9mMAAoJEB2Cnv7KVigSF3cL+wTcd/ziLn2oo0LsUaNTSmzF
qftVFbtFc9Qe/bYqUGQ0wHZ9tH+WYePt7+GksAMmmiBscdVu0Mo+CIi5iSJgj6jo
htYthfSYb32q/EnkwRUpa/Z+PcPUPd2dGisBTnq4pV7FMS0zP5WNHYNOUaIToYwE
wJoVwzBmNm5t6//FWdHfgMObCt9/qiXdNJWkhFbtZkTUoCpsDj9qmOcPCr6eye2T
b8jO/BzfqEY91Gj5TLw+6NgJwYB9a8bpPB8PGsxBck+wFIXMM9dIR7S0OlhTORCU
I/EMG77+6OEE+A2qHtbsqCxfpEVv3lZd84zC2pdPX4U1UEFvikflE6gHTrzJHLpV
xnQ9ebwiXYSgU1YoV2qlqpTBe3CyfwR5b6UDNYbA8YYkqg2R6suuJTFTQ9NmRzFq
zAG8sKj1GpvzdSdl6ejPmL0NecpCkmkfJ63J0njuiv99PUN65c+kUhEqA8AE8Wn3
ZW9T4WVdbRNJxRQX6yceYAJRVF51r3Rj6+yugX5j/w==
=2LBu
-----END PGP SIGNATURE-----

--iIFHIp+zwdKq08NE--

