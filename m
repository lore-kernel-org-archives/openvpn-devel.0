References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
 <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
 <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
 <20190420150719.GM31008@...1296...>
 <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1336b8a0-eebd-ecd0-575f-4b0280d44320@...1227...>
Date: Tue, 23 Apr 2019 13:25:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5ETllvHEFDYdXbfQrmsVWKBK65XUOdozR"
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: wei wang <lnykww@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5ETllvHEFDYdXbfQrmsVWKBK65XUOdozR
Content-Type: multipart/mixed; boundary="bzm7lX38r9h04QOxnNcf7LwQWbgzxegbe";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: wei wang <lnykww@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <1336b8a0-eebd-ecd0-575f-4b0280d44320@...1227...>
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
 <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
 <CAFHpkQEetMrGST3DziN5gedP32DbN4v7w+NDmViZcccmaZf7Fg@...278...>
 <CAPM6dUBfeuEnfqW59YBNdtRDMhWfSc_9NXSsxuKskPzqK=4qVA@...278...>
 <20190420150719.GM31008@...1296...>
 <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>
In-Reply-To: <CAPM6dUCeYFFNE_M+0FFOrfS=025hSaEv6LgPqXcA41Z++Uk1DA@...278...>

--bzm7lX38r9h04QOxnNcf7LwQWbgzxegbe
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.04.19 um 11:26 schrieb wei wang:
> 1. When client-connect tests whether the user has written the
> configuration, we should check to see if the file size is 0, not
> whether the file exists.

I am sorry but you need to provide a bit more context to point out why
you think that change is right.

In non defferred we wait for the script to exit and in deferred we check
the return status of an extra file before reading in the client connect
file, so I don't get we this change is required.


>     Because the configuration file is created by openvpn itself.
> 2. multi_client_connect_early_setup should be called for the first time.
>=20

Again, I don't get your line of argument why we should NOT call this
function if coming from a deferred code path. That seems to be a change
in the wrong direction. So an explaination of the problem you are seeing
and what this is trying to fix would be appreciated.

> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 697994b8..27c6e935 100644
>


It is unclear on what you are referring here to:

git branch --contains 697994b8
error: object 697994b8acd6094aa585c711855b970e1c2bd1c3 is a blob, not a
commit
error: no such commit 697994b8

It looks from the code like my deferred client connect patch set. In
future please include a reference what this is based one.

Arne


--bzm7lX38r9h04QOxnNcf7LwQWbgzxegbe--

--5ETllvHEFDYdXbfQrmsVWKBK65XUOdozR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAly+9h8ACgkQFRhsZwKx
RFTlFxAApBovghyB7PL3rqUyHlN1xmCTDua02DOWm4PhYPIOoHbFtgz9/3EzTSVu
PH3hqSfPUOcJPssjj0qfYONV4LYTouSti6WMbxPedA2ILNP6NcLu/LZaK/1iYgC/
QM2p7h9ZeBXx0CvuTy/9jg2Nm+KL1x4wj10eaJpBoD/mU0dyGndly18Vun72CdzU
Ml97FIPAAEj8VffddTG0lo7jvaV16fAP7DMpx8VxGhLml2DCa9fMdaqG9ghPIFB1
p05VbtUUd+p4JeEl0nQrlawXr9hs/CMqdOLkzHDkNHjsDp6ag0q9Oh2QFcae6O9t
8ah1dQn7VmZt8yFoiZlD1azwTtXsVeCkxDHjWTiq01GsuzRlqTUUfu51ihdUwmlk
CZnacpQWmwxMiRCiVTw4QUISBG1QKqdZjV3OPGK/36yS6Bilo8lTI57VOCrBRG6i
a8kEil4YdMwtVxpoRSuwC4TcCIWYAs/LJQ1fhYtsLOckfsGDuvsrIace9ex2YtDL
Dj2GUrT7D8lyxtyS9boaG+BwuHWlAH3NIKrDqAa8slFvgs/IyOOkTusjMzPtN5sz
dlN4SQWx3uytbBb69qN/veXDgMEaNH4Pj1P0Z6grQLMOtTCGogiVPvWOlr7fLtlD
vv9lpMKg+6RG5VdI59AkWX6jzt8P7HVKQVJh1f4S1e6lTJcyaFQ=
=QG1V
-----END PGP SIGNATURE-----

--5ETllvHEFDYdXbfQrmsVWKBK65XUOdozR--

