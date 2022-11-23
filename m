Date: Wed, 23 Nov 2022 20:19:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y35yO4WsF6VvJw2t@...1296...>
References: <20221123154912.28394-1-maximilian.fillinger@...2507...>
 <efd32889-60e9-5892-9b38-bf54bf398a87@...1227...>
 <CAKuzo_hB1As0L2tMGewNbi5_WFoeoFJViSYj4yAcQs66cp8hHA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jj5RxJaN0JbmiazK"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hB1As0L2tMGewNbi5_WFoeoFJViSYj4yAcQs66cp8hHA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Check if pkcs11_cert is NULL before
 freeing it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--jj5RxJaN0JbmiazK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2022 at 01:37:47PM -0500, Selva Nair wrote:
> pkcs11h_certiciate_freeCertificate() does seem to handle NULL argument.
> With --show-tls, are we calling this before intializing the pkcs11 librar=
y?
> That could trigger an ASSERT.

If I build on Linux with mbedtls && --enable-pkcs11 (which I normally
don't do), and run --show-tls, this is what happens...

TLS-PSK-WITH-CAMELLIA-128-GCM-SHA256
TLS-PSK-WITH-CAMELLIA-128-CBC-SHA256
TLS-PSK-WITH-AES-128-CCM-8
openvpn: pkcs11h-certificate.c:1213: pkcs11h_certificate_freeCertificate: A=
ssertion `_g_pkcs11h_data!=3DNULL' failed.
Aborted (core dumped)

... so, the crash seems to agree with your analysis :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jj5RxJaN0JbmiazK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjfnI7AAoJEB2Cnv7KVigSjgML/A/qPj4Qp2Gbhocjp6OtoM22
MTK4JG8gdNzjLDYxFnn5zqPYI9Bh3x3f/aZBZhWjzNAQyGFSqqeU1wzSFEpayK56
Jq/wY5SVSiGTXz23PXn+EzZxRYrcDh8646VPzSYhEenP4LesZuUxKh7hzemX+XT5
1LtUZyXqNz+R4qoRixL4WaOPwBCbfcZL9mY1U5WczxDYdLVk7JhLmWcIIKol4Htf
7z1Zq5VkG3QJxKLZ6qI4Nyko3egBqUTP+lEFpndLuCFxObwb0qTbrldkV2dRCR8u
EkmRIkWt+AMTGBE2bM77MIY8PqtEyJiqPBaX34sOYwJym6p/anRqqQfCR5gg7FzY
dvfl5vO6Dncwdy+hSO1tDWbjyuc1SeLbYuHivpri019uvdPDBwfEEZ78FHj2xeNo
O5G2vGrcLj4BH4E1LIfIdZkoaBg+V+ll9ImP7+ekR2iCiWabJRFrtYw89QqczIy9
6t/hAPZQRfc1/7e+KWbAcwXMzqeOj7/Pcn803C/K3A==
=WqZ2
-----END PGP SIGNATURE-----

--jj5RxJaN0JbmiazK--

