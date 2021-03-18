Date: Thu, 18 Mar 2021 18:56:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210318175611.GG976@...1296...>
References: <20210318161609.76073-1-juliusz@...2525...>
 <749924e0-5927-ba54-9e09-e722d53ae8ef@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XcxcNAOnIVVGcxzV"
Content-Disposition: inline
In-Reply-To: <749924e0-5927-ba54-9e09-e722d53ae8ef@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

--XcxcNAOnIVVGcxzV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 18, 2021 at 06:25:13PM +0100, David Sommerseth wrote:
> I'm not seeing the rationale to why we need this; can you explain that?

See my other mail: because the previous configure.ac patch (for WolfSSL
support) breaks some platforms.  Seems "some m4 bits" are not universally
there.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XcxcNAOnIVVGcxzV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgU5Q7AAoJEB2Cnv7KVigSsEwL/2yYXzCHARdZcUGDohe9LIQM
CiD/5pDuJgdZAda2nqhD5C4zHm5sJjqOgcIvRA20Dcy7aruEImeZ6EEkurZ8kFXf
hltEH0JEMPpRl0KtRBQD+d01Mx/HHBEqLnRGOFsAqdUWKANsoNFvKcTZ+rmrsxW8
/EfeGegZJcQ2kwAsxY0EiMxWZZ3rAiA23sHyEpTwKQT3IIdxK0i/fCS9r+Jt728k
+cIavdtM5J93KPw77YBWAYORdBvZFCnmA4S0qhcdqwyHg/yPYZWAn8/cZ5njqBHX
59XogPffyBGCVb8uPArnkzQkQeww9Ive/w9Pkq5Mwdv/NE0KEGkMZ3Wq8gin6KEo
gEt9X3BTObHKTNZjNDOx7KhQXVbq2EwCvkwe2O8gd7r9ODv2SngwOSj3NOFnB5Kg
qTw9ERcRA71bUjmStf1FrXAfaP+nCCIBySBAlbxkzeAvlLfuJUHPaP9VwUU3tx8C
FwtgyQBnN6nKV3HpmsA827v0fUiNxoBt348619xtow==
=hSA3
-----END PGP SIGNATURE-----

--XcxcNAOnIVVGcxzV--

