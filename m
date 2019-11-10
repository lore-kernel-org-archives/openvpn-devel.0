Date: Sun, 10 Nov 2019 19:07:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191110180755.GQ40538@...1296...>
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>
 <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PpQJECQXld3rh+sr"
Content-Disposition: inline
In-Reply-To: <CAGnHSE=LcwX6hxHM2sdpWRP6cKyQiuhtc4ZUG2H1rdu-CNHOqQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Yan <tom.ty89@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--PpQJECQXld3rh+sr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 04, 2019 at 05:10:12AM +0800, Tom Yan wrote:
> So in master, when net_addr_v4_add is called in tun.c, which
> net_addr_v4_add (networking_iproute2.c or networking_sitnl.c) is
> actually used depends on how openvpn is built, right?

Can you have a look at the current "master" branch?  Antonio has ripped
out *all* broadcast setting - so this should now do /31s just fine?

More radical than your approach, but "less old code" is better than
"yet another special condition added" :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PpQJECQXld3rh+sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdyFH6AAoJEB2Cnv7KVigSGfQL/iNXsOnVN5qZPRIIJ+pXefZe
Ae1hJxT5knzJuAW2KUxHs31xDNft03ZopbSXlrwv07Xw1zD5v47THBBoxRHR3OTw
jIBGoAiexzhpKi4gke8zs3nPmcpBHF+W13ArpV4r+B6iSPfoJ2noD5COKZOLsSQr
kngEcSCFGS4mZYY5NDLKq8Rr290/4ve/10hqVprGyj4AsBvN76KIf+G37sBFgXLu
OkMLl3xyy9YOXVJxrPfdSTixdQyollJca1VN9f7sMbY2KSdKl7ADSD2crNOFh7Lz
zi7K2U/tKuTceR2cch46byOJAmK9qKNgRas1nJftnc8Uhya5Mi+mwaveQB15Bysa
gge4nQLTrrfn+tcQu+PLzwsq5agjSQDb7WsrW6LFKISCo1DfV4SO7uayHgy+rOGt
oTJdzxQCw5A6WGrzXa4uZ91VRNLRHkRR2VyRW90cJnPxFHkJY+tVxlYljpOBx2rF
3DpzaIbDpHxS8kMu0asxQZWEYZ0fhfMRinomT+e7zg==
=VUkO
-----END PGP SIGNATURE-----

--PpQJECQXld3rh+sr--

