Date: Sun, 3 Jun 2018 12:48:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180603104836.GN79551@...1296...>
References: <1528020718-12721-1-git-send-email-steffan@...1856...>
 <1528020718-12721-2-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="t+hlxQ2APDzOSz17"
Content-Disposition: inline
In-Reply-To: <1528020718-12721-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Reject unadvertised compression
 algorithms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--t+hlxQ2APDzOSz17
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 03, 2018 at 12:11:57PM +0200, Steffan Karger wrote:
> A server should not push us compression algorithms we didn't specify.  If
> the server does so anyway, reject the compression algorithm.

I can see why you do this, but if I understand this right, this will
break lots of currently-working OpenVPN setups - where we use the IV_
variables to parse out "what can the client do?" and send matching
"compress <foo>" PUSH_REPLYs.

So, feature-NAK.

Adding warnings (1/3) and a warning-override (3/3) is good measure, but
interfering with server-to-client pushing of options needs more=20
consideration.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--t+hlxQ2APDzOSz17
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbE8eDAAoJEB2Cnv7KVigSnF0L/jHDZK3FoltNMa6mRUBl49Ud
S39P62/3qVTTB3O/4AcDFLpS1BcRW2rqSmOy6NXK6UOLJfofuPRANYW17iKiyheE
qcZbcy3V6FIKsIpns9PH9wAD3WRK+V5gNE2YABP1hUHKAr5ohmtlD7aXcJzaMCot
hU8ZVFPsfvR8ExUntEqtZzUWqpGvCPfyoaSkUCrAnJks0M+WHmfVM9UTTgpF1WGf
reBnMhtUctxuLXJGtOz3CVF1F7HoWGs066veDTOvTfcZqCwR3L5dBvYIjM34ZJCa
ga+x5lBcYpEz3wJrT/NN+dvm4dL4Wyhl+IGBDrdAc/M5NqajGvh9eUevhGVT/BoP
xCeDxSBHi5m4UBp5SVTL6WhG4JXwNR+C1JLKrnBOXk87XohnxianDP2JaxR+EI2z
9N4x8Aio8XTHRvmacrhyHtXqoYIj7risRQiWZH8dwpqVs/obrSC9vStP25GubW4n
4bnC6XxxZeQTPL4dxz+kygBJDnrbMe35dz/O6ycEcg==
=L3vn
-----END PGP SIGNATURE-----

--t+hlxQ2APDzOSz17--

