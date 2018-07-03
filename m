From: Antonio Quartulli <a@...2181...>
References: <20180605081407.6944-1-a@...2181...>
 <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>
 <6d8c2abb-37b3-5bed-3077-32eb27e4c61b@...2181...>
Message-ID: <18dbf33f-23ad-e6c6-6309-9f5aef5c2e8f@...2181...>
Date: Tue, 3 Jul 2018 17:01:19 +0800
MIME-Version: 1.0
In-Reply-To: <6d8c2abb-37b3-5bed-3077-32eb27e4c61b@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WxyIV9ASK6D2QHDFugM0ogYGt99shR8Mm"
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WxyIV9ASK6D2QHDFugM0ogYGt99shR8Mm
Content-Type: multipart/mixed; boundary="8xD72V0Uj0XMdOBCWBzdIBgpvXN3P51za";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>
Message-ID: <18dbf33f-23ad-e6c6-6309-9f5aef5c2e8f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
References: <20180605081407.6944-1-a@...2181...>
 <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>
 <6d8c2abb-37b3-5bed-3077-32eb27e4c61b@...2181...>
In-Reply-To: <6d8c2abb-37b3-5bed-3077-32eb27e4c61b@...2181...>

--8xD72V0Uj0XMdOBCWBzdIBgpvXN3P51za
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/06/18 09:50, Antonio Quartulli wrote:
> Hi,
>=20
> On 27/06/18 05:33, David Sommerseth wrote:
>> On 05/06/18 10:14, Antonio Quartulli wrote:
>>> In preparation to having tls-auth/crypt keys per connection
>>> block, it is important to ensure that such material is always
>>> reloaded upon SIGUSR1, no matter if `persist-key` was specified
>>> or not.
>>
>> Has this been tested with --chroot and --user/--group?
>=20
> No, these tests are missing.

Tests performed.

There is no change in behaviour: --chroot and --user/--group behave
exactly as now.
This was expected as using persist-key will instruct openvpn to cache
the key material and thus it can be reused to re-init the various SSL
context every time.


Cheers,

--=20
Antonio Quartulli


--8xD72V0Uj0XMdOBCWBzdIBgpvXN3P51za--

--WxyIV9ASK6D2QHDFugM0ogYGt99shR8Mm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls7O18ACgkQB6U8WA7y
zXRlDBAAhe0+7Ta66nVAcmAaw93v5l4oltmumSMTZ1jmRwqZ0zjWuOv29aJ5POVy
xuNIBCkdNikeOm8h2xxx+UnoQ99sjAVlYZAPRYxuMbOv7Hqlzjv+jaBoeisAu8FJ
FR2hblVKHMLAjyBgEaT7/KtZVy//UXdjANyq0vR1DlO2FIjgrtlbXJaYGYyMnNDK
6NNdz2cRZ0SpTAEuPrgjbH1e2CDGspHLmI7Ik8JKzdeoVmgn5MEEtCFg+c4T1SUR
n2sDWqAyEzQno4FWLVQPrRQa8g5Rp7/RUo/GogHgv4pzoZkhspGVVlAO6SQ19ORt
KhhcYJfmaIBeYQFfKvT4bHpfbaUYumrGGwpTh8V3LxEI2v+9Xe9lwJpmJmSqo+0C
kfATcqHZk2kpY2oCPxA/xjsYz3jpxogo2dR8CMMKEcvPhHGU26exempbzgDqk36r
z9gc7v+IiF0TyN/OtmY0QV0RozVKplyeTpIdtlrU5U8MtTqjkeAqD/TWueKx/EpT
bUIOR0wBcZ4FqJNMXaeqEN4Qw/lTRHs7n9N35NozTVDnq79YCmfRIpPViUMT4Pcm
DfNUdYDTCJQbNLwjOnYz3K4h9PEcr6BXwdWu9Nx9bgzIuIITGEaGOrjWGa+tdqXu
swC7DKcdIKG1AarBlIR7hH1gtTF9X5OfT759tYUxBx4XRQy2f5o=
=+x8F
-----END PGP SIGNATURE-----

--WxyIV9ASK6D2QHDFugM0ogYGt99shR8Mm--

