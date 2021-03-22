Date: Mon, 22 Mar 2021 10:17:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210322091717.GJ976@...1296...>
References: <20210322074359.527-1-simon@...2293...>
 <202103220910.12M9Ag1E095423@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kJ2umm5eMwqzSFbR"
Content-Disposition: inline
In-Reply-To: <202103220910.12M9Ag1E095423@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: tapctl: Resolve MSVC C4996
 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kJ2umm5eMwqzSFbR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 22, 2021 at 10:10:42AM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> It's the same code change as in v1, just the comment rewritten as Arne=20
> asked for (I found the other one okay-ish, but this is more in line with=
=20
> our other code, and indeed "less thinking required on read") and a new
> helper variable for the total length.
>=20
> Code looks good, test build on Ubuntu 18/MingW also had no complaints.
>=20
> Your patch has been applied to the master branch.
>=20
> commit ef5b922aedead7159718ddbf40fc9f5be1b2b203
> Author: Simon Rozman via Openvpn-devel
> Date:   Mon Mar 22 08:43:59 2021 +0100

My local tree was in a slightly funny state (the tip commit had a new
ID due to an accidential "git commit --amend" on the wrong head), so
I had to rebase and this commit got a new ID

commit e5e9a07e8baee4065b7dfd65736bfa77b8329cfc (HEAD -> master, stable/mas=
ter, mattock/master, gitlab/master, github/master)
Author: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Date:   Mon Mar 22 08:43:59 2021 +0100

    tapctl: Resolve MSVC C4996 warnings


(and I forgot to change the From: line again, sorry, again)


Must be Monday :-(

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kJ2umm5eMwqzSFbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgWGCZAAoJEB2Cnv7KVigS6CgL/R00PbK9M4XlRqLYr3rcVZty
pwTaaQfgzYR8DbmchVqeyuSMRyHTSp2UbnuK+MMw4kckNGl0LH5Y00p1S4EHlmG6
6a64GAeRtM3hVN2pzCQ+0X4KvQhFDM+sb/AVUAt+UWgdUVM+f3Z+cpkx0qT7Ilo7
OWUrtvt47lzMTr0YNREIBrUs5Ebv2pMoGpze+zIDCjKXsTIQ1kNxb0NAshMSTsVT
Wiimjbj/CgwHDcxpQJ6TbpJXIoi/CbNI3BDAijxD3K/CxTyTTM+Tqtv5qsuzhTfX
2zxuP9suHj5B48bK9rLk20dfdvM+CFFMk+Q2fzDJc9idujbIr4ST0yEK67FzeT/Y
NmfXfuFfOKRE4Zae4xmuh2AJhYr20p7Xe1Oa+9itMQLI0DNV1Vp99WuSjCWIFMQc
P5PpuETI8/wdR7PBx7X/BeyvyxeerV6qBHkQFUXU33hTjyWGNdp/BYmiksFSlYx2
mZLM1T1HGBE/pyv+kA0YOAFoiyJij2UGcOkv4N3CpA==
=bEh7
-----END PGP SIGNATURE-----

--kJ2umm5eMwqzSFbR--

