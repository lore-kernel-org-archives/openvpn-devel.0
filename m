Date: Wed, 16 Nov 2016 10:38:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161116093857.GF28918@...1296...>
References: <1477670087-30063-1-git-send-email-steffan.karger@...1435...>
	<e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8PToEjcJt0wtdCco"
Content-Disposition: inline
In-Reply-To: <e9b94527-d361-cc7b-1ce1-dfbd1bc7a9e5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor CRL handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Ivo Manca <ivo.manca@...1435...>

--8PToEjcJt0wtdCco
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 03, 2016 at 07:21:54PM +0100, David Sommerseth wrote:
> This is a bit scary.  I have nothing to complain about in the patch,
> so I feel like I'm not seeing the large neon-pink elephant in the room.

I've reviewed the code and found a few nag bits, so you're just not
critical enough :-)

None of the nag bits are relevant enough to NAK the code - so, combined
with your detailed review of the SSL library side...

> I can definitely give this one a Feature-ACK.  I can also support a
> full ACK too if one more developer does a thorough code review.

... I think this is good enough.  So, ACK.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8PToEjcJt0wtdCco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCwpMakuBuNlUUl1AQLUogP+NPdES/VxLq7X5mhfd2yE8qTh5T56+1b5
eCovH+ESEVEGMacJ3TFQ62WecaYzmVSYBzGDzuqGkH6UdLWpAMW+nxqCOd+6+TnC
bOpE9Gmnb+8/dH6rcyeDFrNyF2CbFQ81xnKJglqce0xym/KqnnwiAjEoHjaXxo8N
x4L6TE/y72g=
=gGN4
-----END PGP SIGNATURE-----

--8PToEjcJt0wtdCco--

