Date: Thu, 16 Mar 2017 09:14:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170316081444.GZ93896@...1296...>
References: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
	<20170315210046.GW93896@...1296...>
	<20170316073535.GD15280@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fS/HbthCZKMwXfkc"
Content-Disposition: inline
In-Reply-To: <20170316073535.GD15280@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] Fix Building Using MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--fS/HbthCZKMwXfkc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 16, 2017 at 03:35:35PM +0800, Antonio Quartulli wrote:
> If there is no objection, I'll send a patch for this.

Please do.  We only check seconds today anyway - plus file size(!), so I'm=
=20
not really seeing a scenario where a CRL file gets refreshed more than
once per second but the file size staying the same...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fS/HbthCZKMwXfkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYykl0AAoJEB2Cnv7KVigSip8L/3Zky8q0/xdW4zKkBdo3B56Q
gCR1DOB8Srnwxf0dmBjQ+BYJAy6YRabIffB+6act3n1gFqmLdljV8ls85ds+3eP8
pwNnspQ4yCvw8uAeqjMPwNtu3R7I6laA4KQ4/2JiEMCniZ/w+C2t8UosuF+sgesc
1oZZ/ezudwAiRTgc2U87JCfqSewoYq9JAg9xC/foYGQkYi6aGwMOuIFKsbzAzn6k
apptAqZe5EJfql6f8sTShGOhSop5iUKO5VNhEMc9baRjrRync49x3lIu1hWHNG+h
cM4LDg/waTgd5YrTUDx5/I3cYYGQKe9WPWtLCFR3416OWbC4L27CegKEcd+otxSc
V/tfp4lXHfsdsXzvgseGhtCC01WAn2RQ1ajfIqBmihM8p+fDghCqUMMmh9ehW7g+
KPU2FtwHvqPf/AuGwD101IBZcZbKfvx5oeYBXuuJ3Wsbid57i0Bji8xq9J7mn1OL
/Id/qi+JJa8JhgF/c2xyNmnHVcLczdIOm3wpqQShvw==
=8wtT
-----END PGP SIGNATURE-----

--fS/HbthCZKMwXfkc--

