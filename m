Date: Thu, 31 Mar 2022 16:54:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkXAkxNX7gmlr/F4@...1296...>
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <78f5a523-8d24-2d36-5414-11bc746f9b70@...2080...>
 <YkWr8RGuB9NfLicu@...1296...>
 <719e1424-cd2c-8208-9758-dc73dae63d2d@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2oJFLIxZmgqxkaUo"
Content-Disposition: inline
In-Reply-To: <719e1424-cd2c-8208-9758-dc73dae63d2d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--2oJFLIxZmgqxkaUo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 31, 2022 at 04:38:06PM +0200, David Sommerseth wrote:
> We could "fix" --down now, but I will not recommend it at all.  We could=
=20
> add the CAP_DAC_OVERRIDE capability.  But that's a massive sledge=20
> hammer, giving read/write access to any file on the system. Only=20
> security modules like SELinux, AppArmor and such can block access with=20
> this capability enabled.  So this is definitely not the right capability=
=20
> to have in the main OpenVPN process now.

I agree.=20=20

This is not what I was suggesting (not at all), just pointing out that=20
the combination of --up, --user and --down is not with its own set=20
of surprises ;-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2oJFLIxZmgqxkaUo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiRcCTAAoJEB2Cnv7KVigSf/QL/0pINLB3CKoBSLHa/xE9E8hz
kNtvF53engREA+xDGAsAXOUPUf0UHyPeLkJXF+1SLGvREik1htnS4Nr+sUmjcWUx
D6Q3gZjIzLjs/gVACTauQurAb2VG+rpiwnXcq7Wsehx5IgbtC36XAF5bXZL70vOO
BmsefZmkYRczAalZBfWeKwQ9RY8u+uBLtxEMVwzk/+2FDPbTi0XXGpqfFB2R4Flm
oJy5q9Ki5+vzCiA4ZU8AuB2sZzHEk+TIZ7I08GQiUSWgdaVDgYEHX/VkONu1nYRI
RNuN+tJVRLwYp0I6jRg6E8BVKicjc9U2YmRPjXyWGIDZK8u5phIGvq6FJlXZiFDf
qRalwgD7Yv9wkXJ8KfhMMMCeMv1U2NQAMlvm+8ejtSMEwTRzjScWOCsLA34+sujp
4SDuWHDG80dAbZM0CXo7qOF90GL5ez4cts1uTlPboRJsj9dsFwoTC2kSo9n04ERt
UNWxRfwJ2jDEJYLGgXUAv0Wk4nbiQInahe0eb6rdpw==
=SxlB
-----END PGP SIGNATURE-----

--2oJFLIxZmgqxkaUo--

