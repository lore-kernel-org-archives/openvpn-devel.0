Date: Mon, 13 Jul 2020 14:42:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713124200.GY1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dOX7v7q7lVrg76sO"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 05/14] client-connect: Refactor to
 use return values instead of modifying a passed-in flag
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

--dOX7v7q7lVrg76sO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:46AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch changes the way the client-connect helper functions communicat=
e with
> the main function.  Instead of updating cc_succeeded and cc_succeeded_cou=
nt,
> they now return either CC_RET_SUCCEEDED, CC_RET_FAILED or CC_RET_SKIPPED.
>=20
> In addition, the client-connect helpers are now called in completely iden=
tical
> ways.  This is in preparation of handling the helpers as simple call-back=
s.

23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b.
Test sets failed: none.


Not sufficient to do instead of a full review, as I only have client-connect
scripts (no plugins) and my client-connect scripts do not fail (need to
add that to the test set :-) )

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dOX7v7q7lVrg76sO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDFaYAAoJEB2Cnv7KVigS0TML/iLMvrXPs8v1A5WwwbYcsZpY
UQ8CdeMQ+qQSdBbWgA60zvqRH9gRQ4+IdJBCseXWz8Zw4FzKLPR8udiuFSPTOO+/
1/psuqVDuiNZQdimJ1qjkiy2ES9eq4LwM9JG6lcUx3PL9VOiv4B1Hdfs/PlRhnMp
Pz5Ybn1NiY6hI5FpLzCDXgB+PTIs6Vsu4pCARLakEYkgIndGc+51dcPYGSHLi4dG
iDpOOAL8/KE52vlnZURtOSpBcDaC/Id/WZOTLZnMtHwLNumKL4qIw0IMpp0/4RRg
HbN1Kf4KZbSX+t+Gh+/NsUs+w+BvnmbHoqNzSkPRaaq2SROu4qHtzUxMbMvt83/i
lBSGKdTQ5f6bnM0tqz9G/Znl6qyX03if5696/oDEFIoWNYRyVz8oglzonYN7zYqV
ktd6EB7oGYAaUVrNza/zBoZJSVDBr6RvmyMwIiAo197DB8zF3wcC2vjNB+mONsNM
gSsIg0cVZhXupZBTCUCcVgwiL/nJqsnLOuGKCOHMRA==
=ihuh
-----END PGP SIGNATURE-----

--dOX7v7q7lVrg76sO--

