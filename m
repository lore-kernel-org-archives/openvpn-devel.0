Date: Wed, 8 Nov 2017 17:18:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171108161813.GT958@...1296...>
References: <CAKuzo_j+TbC19HRNH1YxWro74950Ftpxj-oDOi7kgAO8bc6ckQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8QTINAT9I+GWM3JK"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j+TbC19HRNH1YxWro74950Ftpxj-oDOi7kgAO8bc6ckQ@...278...>
Subject: Re: [Openvpn-devel] patchwork
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8QTINAT9I+GWM3JK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 08, 2017 at 11:07:16AM -0500, Selva wrote:
> Confused as to how patchwork works:

Welcome to the club :-)

I had some ideas how it should work (like, picking up my "applied" mails
and auto-closing patches) but right now it's refusing to do so - I think
we need more tweaking there.

For the time being, I clean up applied and superceded patches manually -
the list is not long, and it's way more convenient than maintaining the
old "open patches" list in the wiki.

[..]
> What status header should ACK-ed patches get? I suppose Accepted is for
> merged ones. Anything other than "New" or "Under review" appears to take
> the patch out of the "Action Required" list, although Acked patches still
> need attention to get merged.

ACKed patches *should* see an "1" show up in the "A/R/T" column (so you'd
need to send a mail with "acked-by: selva <...>" instead of a plain "ACK",
but it's currently not doing that either.


So: work in progress, no definite answers yet.

(Samuli says it's all python so things can be easily fixed... I hear ya :-)=
 )

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8QTINAT9I+GWM3JK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaAy5FAAoJEB2Cnv7KVigS07UL/0rjbT7IMmkTEHb5nEhDwZuQ
xBVSIVftRdNBOcpITd4JzhfciN5FsjCeMp8kX1olFfN/QmXJ+G5okiXYGxneVLLz
jfg0WpnlFOPSkrCk7QajgLg5yfgaKfZDadXPIUr6vpZtxcp/AryN5gPzLLJFCEXR
X7OS5UegJyAmkMoFVFahWiRnn21Ulfsd3XR4AazEeyUcH9yDfB8c8Jl+g1F+BITP
7TgZDJ+M2+VZL/zBqUaucHAySwo2+FMhvTfNew5mNZSqmStPWVVgrECL66tOD4TU
i6yEaZdxfO1EXCxdsvw6KYcNJJuy2vKL0889ZeXBSsoziS0vaj/EaqJGl69BDYA+
G8MCcMmqqaUBXyjj77QiQZ3wXMVt5QqcAlP78LbXz+Xapu1tf3DOFbv6HUaaTxAn
0MjSaUY6a7t9BjXFzcP38t1aHC/ch+ZLnJFTVR6RRT1WWvIJjNsPZGud2w5AuVcI
ICP8zogWj8rhx4W5k7bNPe+l9lY2PWel2R6jwWINLQ==
=sJgi
-----END PGP SIGNATURE-----

--8QTINAT9I+GWM3JK--

