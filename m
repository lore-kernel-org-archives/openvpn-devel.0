Date: Thu, 24 Jun 2021 17:34:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210624153401.GJ976@...1296...>
References: <20210618155241.400-1-lstipakov@...277...>
 <20210624083918.106-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/3RRu44D4QS6o5hU"
Content-Disposition: inline
In-Reply-To: <20210624083918.106-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix console prompts with redirected
 log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--/3RRu44D4QS6o5hU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 24, 2021 at 11:39:18AM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> When openvpn nees to prompt user for a password
> (for example, to set management interface password),
> the prompt is written to standard error device.
>=20
> When log is redirected to a file, that prompt is written
> to that file and not to the "original" stderr. Moreover, on recent
> Insider build (21390.2025) openvpn exits with fatal error
>=20
>   get_console_input_win32(): unexpected error: No such device or address =
(errno=3D6)

Feature-ACK, and tested your binary, which works nicely.

Can you rebase this on top of master?  I wanted my "improve error logging"
patch in the tree, and of course it conflicts big time.

While I could fix these, I think having a v3 that applies nicely would
be a cleaner approach...

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

--/3RRu44D4QS6o5hU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg1KXoAAoJEB2Cnv7KVigSIzYMAIdl/4HIPCxXonDl6NqtTwG3
HcyjqK5JUi4pOnyiXMtnxj05AnUXxj4Cf7vw1MkJume19mntdrWXhhMKezJLFJDp
TdwZEjz8ezs8Y7T1j15QQ3uPKZU6wuMMZcmJ9MQtbVoI/o7GaUWhr/l6sStrz8G6
sF8Hfhxg6+WTglrxmfg4SmHmHX9a2IMc6X364dNfkuhMF4LCxUwHyUbdZlOK8sFT
/lwFjv2CZe434hsoXl/BoZxcaFIGicPUxEBBkwp8PD9sUOCSGDC+vkkCMo2SwLUp
5w5o2Riy02Delnpv1L51/DdbW+KWPhCVvegcrEwiBXSaunSGtea9HGRMgyp8nJtj
Nesy56u7MBvwbi7VBlJTVwxC8DaOa3I4w/sImKFC8pq0Ea1PjL18GE+aHSQn3mkD
WreVwqhzdOM3xXJ4gwmw4/NRgzjBZ0b5BRWFDSNeC6zXWF0YQSXv3eKg4a0nXm8D
YmGtd0vbYBM6u9hpZO2kdqD9/DH4qU9qmAkQ3tfLVg==
=/Yit
-----END PGP SIGNATURE-----

--/3RRu44D4QS6o5hU--

