Date: Fri, 22 Jun 2018 11:46:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180622094635.GI57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GMaUlEtIIvUQCAd3"
Content-Disposition: inline
In-Reply-To: <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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

--GMaUlEtIIvUQCAd3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 22, 2018 at 03:27:02PM +0800, Antonio Quartulli wrote:
> Fri Jun 22 13:43:51 2018 us=3D116232 PUSH: Received control message: 'PUS=
H_REPLY,redirect-gateway !ipv4 ipv6,tun-ipv6,ping 10,ping-restart 120,ifcon=
fig-ipv6 2002::1001/112 2002::2,peer-id 0,cipher AES-256-GCM'

As an afterthought - the error could be totally unrelated to the changes,
and the win32 API refusing 2002:: addresses because it knows that they
are not "free for grabs"...  (6to4, normally auto-configured unless
disabled, with 2002:<ipv4>:: being the prefix that a host on <ipv4> or
a network behind a router on <ipv4> can use - but that's old stuff and
should no longer be used in any case).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GMaUlEtIIvUQCAd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbLMV6AAoJEB2Cnv7KVigSb0YL/RKtdUA8kLTJmgnb6NLaopGx
MPOxX0/OfiYFOXgxGmsCk6xHfnPKJtpCBrPZojhgciUGiLuo6yjZZ4bY5ibpW0Za
UEHTALlP8gUir8jjmQeHtGL2JGxTut4WkCkl54QkFl95TUHqzI35e/vrF6pH0Vh+
RnZQ78gA7P584B4vvzx7Onz24aDW3y8c3dWBmO76a+YnT6Wraj8QP6CONuXQR7wN
5KN+VdxRFGkl9jHNX0dPkrnpvlzsTuXZxPVOsHGCagdU8giSDoypxsxgEHJVTRYI
SHrRT1V7uLPivSasSmM4jT5OTcisestGcNL353f18liA3D+yIfEksnaP7sxpplo/
qpteyFUuF+XhIw1pPOhMLwpCivX+dWww7FADxdyfJzxGk9CUBcwO8m3wD6DXJQ78
OG1fFFwIrml5A9VUEhfHnvfOQcvYH18Pws1UhYIDQJNyGUMlh11urfT6MsEDnAHN
LfHx8Tm5veGcgRfJ70i92rTdB2McYdDrIFN1jIr3rw==
=eSHc
-----END PGP SIGNATURE-----

--GMaUlEtIIvUQCAd3--

