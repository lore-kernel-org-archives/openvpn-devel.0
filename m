Date: Thu, 22 Apr 2021 10:35:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210422083519.GK976@...1296...>
References: <20210421134348.1950392-3-arne@...1227...>
 <202104220635.13M6ZkAh076717@...2054...>
 <YIEzcUAY95j2h9aa@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="K1OROHni1/MzCA5+"
Content-Disposition: inline
In-Reply-To: <YIEzcUAY95j2h9aa@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove always enabled
 USE_64_BIT_COUNTERS define
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--K1OROHni1/MzCA5+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 22, 2021 at 10:27:29AM +0200, Gert Doering wrote:
> I have force-pushed 2.4 without that commit (no tags set, so no harm done)
> and applied it to master, where it was intended to go

Well.  I tried that (though I should have known better) and neither sf
nor gitlab actually let me, and I think that's actually good :-)

So, release/2.4 has a erroneous commit + a revert commit now.

It hasn't been actually broken at any time (because the commit is okay),
it was just against our approach to "which commits go where".

$ git log release/2.4
commit 5e272a0196f3a9ac9423397079779ac8bbdf6159 (HEAD)
Author: Gert Doering <gert@...1296...>
Date:   Thu Apr 22 10:26:12 2021 +0200

    Revert "Remove always enabled USE_64_BIT_COUNTERS define"

commit 1bdd09e7e019ac6d8fdc1b009bdec818b9183e76
Author: Arne Schwabe <arne@...1227...>
Date:   Wed Apr 21 15:43:44 2021 +0200

    Remove always enabled USE_64_BIT_COUNTERS define
=20=20=20=20=20=20=20=20
commit 092734634796e9637920e029fea716afc146cd82 (tag: v2.4.11, vweb1/releas=
e/2.4)
Author: Gert Doering <gert@...1296...>
Date:   Tue Apr 20 15:31:32 2021 +0200

    Preparing release v2.4.11 (ChangeLog, version.m4, Changes.rst)


gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--K1OROHni1/MzCA5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJggTVGAAoJEB2Cnv7KVigSRGQL/A3gDX0v+2SH2+Vibzh5AMO9
NU6RaTuUUApkf5pwWYJWEw1BSQjEyp8I+GK9uSAqmD8BdaOn+9qyF2NaeuXLx4VC
EsCLFJDmcP3A5zxb2FUcmAB2O23zDb+xyP3hdZ9l5N7Ir82EgQrChO8sh0pwPcJ/
IcPNqQAqpe518jR/yBix6moY+bgFfyoYCmuNboXnvI2/VirPTDlA2z6rzN7+LVq0
JEdAaFrtdGCCaCAKJGRVo12BZ5TS6d4BWzdHHsM2B52E+dPFV2bFm1KLazjixkyp
r2btPu5rp+W3ntHIQFmCNzzCXEZjX33JOegbbQI8cubbgKriDIl/+ewcDWAfNOVj
BQf6fpNUScz99NfmJ+ZzVkz7pE6HU+Ga2jkMutHiKmEwkkW910WVasrIivtd099m
A596ql5DMy0/b2jEsENd7tP6jXe2dig5Aw3NSWdCMSGPktV7WgZtU3/OD1u89IDa
qsAuFK3HMku2puO40X9Qknxce77CP89lY6HqHCa8oA==
=9cq0
-----END PGP SIGNATURE-----

--K1OROHni1/MzCA5+--

