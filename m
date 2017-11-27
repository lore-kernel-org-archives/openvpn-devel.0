Date: Mon, 27 Nov 2017 18:46:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171127174644.GA69387@...1296...>
References: <040701d36546$f3cc1270$db643750$@carroll.com>
 <20171124180207.GO631@...1296...>
 <078f01d367a3$51c1ec70$f545c550$@carroll.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <078f01d367a3$51c1ec70$f545c550$@carroll.com>
Subject: Re: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jim Carroll <jim@...2322...>
Cc: openvpn-devel@lists.sourceforge.net

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 27, 2017 at 12:15:27PM -0500, Jim Carroll wrote:
> Just checking in to confirm our revised path made it though this time. And
> wanted to see if there is any feedback?

Patch made it just fine (thanks for re-sending) and patchworks picked
it up...

https://patchwork.openvpn.net/patch/94/

... but I'm not qualified to comment on the crypto bits, so waiting
for Antonio, David or Steffan to review...

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaHE+EAAoJEB2Cnv7KVigSR2oL/394Sg4SKUpHg45wgv5kiyKB
C3jOEgQzfGMMsTiHy+yFXVks5rIbIvmlw9rOLvWF+WHdMal7RvbZ2prodPJfDD3W
O4yhK0wHCRqx/RfE6bnDQaPFMPjgNgADfyIwHeYUGBb1vICmp0cs+f8bjgo0ytyJ
DdBA40fTa66QV8QRFQv4nhYqs3vuGRG5MoacEue88/FZmb+tCsI3V4HqRMVMmz7B
kMgXe5umzZ8u5BV/6nmkUrVxVgqezyQN/5VMNsnaJV6a2E6TaVlR38M4ekTv7/LT
P7iO2JG/bzUcxFWaXeVUO3DD9kSNAyUlK8tx2QwfFQQzYRchUg4pRMp86TQ5xRq4
IB4N/k6eF4yOv1np+7875DJVoq2SF80gnAgYdrMQS4DAy31vAuHTsgDny+tgih92
AW2EYnlq8AlJ7piEci1M6sYrgIUDYww2M91e40tDGs8U4V4UEXR19vNmHRy8BAfx
fvo+HuWJU85gIxPH1FItxeHPiTSIeZUQoYDJwdiTGg==
=i3/t
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

