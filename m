Date: Sun, 7 Oct 2018 09:10:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181007071059.GX962@...1296...>
References: <20171110163946.7656-1-fkooman@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EJCnrJiDxBM3d8Vu"
Content-Disposition: inline
In-Reply-To: <20171110163946.7656-1-fkooman@...2318...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: openvpn-devel@lists.sourceforge.net

--EJCnrJiDxBM3d8Vu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 10, 2017 at 05:39:46PM +0100, Fran=E7ois Kooman wrote:
> Parsing CSV can be cumbersome in depending software, so instead
> offer JSON as well using "status 4".
>=20
> The "status 4" command uses the same keys/values as "status 2"
> and "status 3", just formatted as JSON.

So... we had a nice and long discussion about this last year, which I
think can be wrapped like this

 - JSON is nice because good parser support exist on the receiving end
   today

 - human readability is a plus for manually verifying output

 - if we do JSON, we should do it for management *and* status file

 - most voices argued for "do not require an external library"
   (for *creation*).  Not sure if we managed to convince David in=20
   the end, though :-)

... but then it just died off, and the patch is sitting in patchwork
(where I moved it to "changes requested" just now).

Is there interest in moving forward, or shall we just let it go?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EJCnrJiDxBM3d8Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbubGCAAoJEB2Cnv7KVigSFM4MAJAytkRVUWgobo4s6l11PXYJ
vs7xr7nmNRuTwLH+oNpJ8E4qnHoevOR2C5MPHiXn7lQSIR6m8/8Y9LNo+iqaikhi
FHIZ2H0h0++D6KDdNAvJR8pkERT0npBmLxXfvh5nyPkGTDXOWesUHehEwc4nCM8R
8OB1A1dnPi2mfw4upAkLXLcw8UOtu9J6E6/ZU4LY6fs7m4xiulX0Cg3jRv9pC8ae
rtS2Mb+s/ZRpX8/X+8LCqTQsj6Rqka/Gx2HmASWuXT6aZ9ons+/0/qDWPQc3bJqe
Ox+9JDUdUR7E1Yv5g12uzAt4oFKfBhUcrVUWJXBZKygEAdqHWg2cRDh6v3xuMM2Z
Um1C47wWAEaYZy/x/3bmYtKLCy/pRh2m6HihGXI9SeudIU6hlU7G9HRJSVdV9AGQ
GsMwgUR2J4iEgPyu526sdU9YGSWFl9t3XLEBP7kXUrc2MZJNufPYDQ/e2Q76Gjlf
0TfHvrtmSeR3epD8fcbQcq7BoCu3xWlyitFCWDug4A==
=esdg
-----END PGP SIGNATURE-----

--EJCnrJiDxBM3d8Vu--

