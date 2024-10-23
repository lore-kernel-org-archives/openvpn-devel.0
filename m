Date: Wed, 23 Oct 2024 11:41:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZxjE3y7X48OI8nFY@...1296...>
References: <20241023080853.3710-1-gert@...1296...>
 <202410230849.49N8nI98022315@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bd2ohd9vhwRHRDlS"
Content-Disposition: inline
In-Reply-To: <202410230849.49N8nI98022315@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: event/multi: add event_arg
 object to make event handling more generic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--bd2ohd9vhwRHRDlS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 23, 2024 at 10:49:18AM +0200, Gert Doering wrote:
> I've lightly tested this on the server testbed (it has TCP listeners,
> and extensive t_client tests - everyhing is fine), and also stared a
> bit at the code (which seems reasonable, and Frank has more extensibly
> reviewed it already).
>=20
> Your patch has been applied to the master branch.
>=20
> commit cd8e25a6e9a0fc3687cf8b9df460885db2aee566 (master)
> Author: Antonio Quartulli
> Date:   Wed Oct 23 10:08:52 2024 +0200

Unfortunately, this breaks Windows building, which our "pre-GH push"
test infra does not cover yet (and I assumed this to be sufficiently
OS independent... so, don't).  Patch incoming...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bd2ohd9vhwRHRDlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnGMTfAAoJEB2Cnv7KVigSjE8L/RG+O1x39ywthk934yEFuIdK
rTn1CKrg/ctvIEtFsFqqIXI2Gw+3TTsEtl6DJ90mDmKEOGoGezCWsRhDj2J50LLl
3MdHbA8neS/s+SDmbsZ/dkbIIlEFN7oztD8vXlzRxomyDMRfMACRs5UgxLB9bAvv
z/ZTe1NC+AkDB7rrYIv55qWAggAzWcRsomAZ+8PqLIrImETGesU+yueAkZum00/U
jBZ72i/XDhrISToiCskWa7utIJn9YQHPGcBS2acWKUXmbC2Acwl4vwO+y8C36T7U
W+RcUSfPtddEUYVH62zM73F3AyeFD7FldE0uEujgpdoTVTcddGl0UJM5swjqESUv
WYxpB0/lpCC9rleEApIAcVgfgORI7Ye8kfdLuCpWhKv+48H1HkNbU5qUBDABG+kx
HO3EIqgBJL8EisVpjvf6ktnNL5O3LMoTO7KStCkLBQHPUNZvERRTA1WPL8P/ffQ3
k0X8AfUjbvajoD9JsE6ZGs01QXrHuisevWf5l0A4Kg==
=WjOG
-----END PGP SIGNATURE-----

--bd2ohd9vhwRHRDlS--

