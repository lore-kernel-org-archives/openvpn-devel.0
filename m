References: <20200909104837.6123-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5544ca39-3d84-2bca-ce43-ef5b62bf0578@...2080...>
Date: Fri, 11 Sep 2020 18:46:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200909104837.6123-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2hy94H7txTqlLr5exKq8XyTpXlVKYcW2G"
Subject: Re: [Openvpn-devel] [PATCH] Handle NULL returns from calloc() in
 sample plugins.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2hy94H7txTqlLr5exKq8XyTpXlVKYcW2G
Content-Type: multipart/mixed; boundary="5UKN5PEp8aybClVOvrkkjqyB9apkaNlkG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5544ca39-3d84-2bca-ce43-ef5b62bf0578@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Handle NULL returns from calloc() in
 sample plugins.
References: <20200909104837.6123-1-gert@...1296...>
In-Reply-To: <20200909104837.6123-1-gert@...1296...>

--5UKN5PEp8aybClVOvrkkjqyB9apkaNlkG
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/09/2020 12:48, Gert Doering wrote:
> This is basic housekeeping, adding NULL checks to context initialization
> of the sample plugin collection which are missing it.  Realistically,
> this can never happen, but since these are supposed to be "good examples",
> not checking calloc() return isn't one.
>=20
> Trac: #587
>=20
> Reported-By: Dogbert (in Trac)
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  sample/sample-plugins/defer/simple.c                        | 5 +++++
>  .../keying-material-exporter-demo/keyingmaterialexporter.c  | 6 ++++++
>  sample/sample-plugins/log/log.c                             | 5 +++++
>  sample/sample-plugins/log/log_v3.c                          | 5 +++++
>  sample/sample-plugins/simple/simple.c                       | 5 +++++
>  5 files changed, 26 insertions(+)
>=20

I've just glared at the code and compiled all the sample plug-ins.  All loo=
ks
reasonable and good.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--5UKN5PEp8aybClVOvrkkjqyB9apkaNlkG--

--2hy94H7txTqlLr5exKq8XyTpXlVKYcW2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfW6nNAAoJEIbPlEyWcf3yiF4QAL7C89Eyc49ThrIrvRBRs4Mj
/cluxvYJq0p7PMIzFULCPDF5x27kbYBLMLI8Xrwen12cPYFuEtkcVpUhGR8e2NG5
X6DZOUxV1sCWcMgYBQi8cypNYskOBTmodwVTKgg6SFXJpvpTEFYSQgivXQTRsMMy
eIFauezPH6M02ttsRrIdSmkfxrLZEo26nsKJNYuICTu8uRqlbu9dpJq29ojYSnaq
/CK/T9pOOsI3F6k3z38xpNoX1FgjJL0XR2ZKfu+UE04K3wHB18Rh3atIbaTvALXf
YZQCVjfuVdsyzrSPqdqtKSDG3DkbTKjcwaaQFHhDUmy+XvHOJueRbMmsYT2h0Nab
YRReVXTK8eqru+roa+acksrlN//qNvYahmdBzNunxrdDdBg/CAShiVggJ8yIY5O0
Et2WZaxUo2uwzINxu5lJHFZ2nuHbl2HPA1hpDeqkEWoE3mprWpm+yytrSfmfAIst
tNs5DrJptPn9S1mCLncBFBmuYEPEoXuu0d6tlNPAC9uqnnOYSrIwjEEzSlEkelih
F2WJnbhttodfQYfdoiwZ+l73011dZ0jpUquyqsuaLeU1xM+IUMmh5dPWmfpavWuc
cYpDpsQ4evXxBC4SY3itBOO6esT8FasqVnVAy1ELx1fDrNo0X96yRcekAXemkOtn
5fQvxKg962IhiQSVVvOK
=+GCZ
-----END PGP SIGNATURE-----

--2hy94H7txTqlLr5exKq8XyTpXlVKYcW2G--

