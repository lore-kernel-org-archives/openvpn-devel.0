Date: Tue, 23 Nov 2021 10:11:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZywVewnQCZpbjhR@...1296...>
References: <20211123083758.15933-1-fkooman@...2318...>
 <YZytZB9Ktj2vS5mG@...1296...>
 <0a052f56-46ea-9c55-51c4-8e19b8cec12d@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sDskY7hHyckRYBuA"
Content-Disposition: inline
In-Reply-To: <0a052f56-46ea-9c55-51c4-8e19b8cec12d@...2318...>
Subject: Re: [Openvpn-devel] [PATCH] implement net_gateway_ipv6 for
 --route-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--sDskY7hHyckRYBuA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 23, 2021 at 10:05:16AM +0100, Fran=E7ois Kooman wrote:
> > Is this a v2, or a re-sent "because nobody picked it up"?
>=20
> Well, if you consider the PR on GitHub [PR#160] the v1, then yes, this=20
> is v2.

Oh.  I really need more coffee.  I remembered I had seen a mail about
this, but my mailbox tells me it was only the GH PR notificaiton
(we decided at the hackathon that we want to be a bit more open about
GH PRs, and now I'm even more confused about "where have I seen=20
this before?" :-) )

So, yeah, thanks for sending the patch to the list, so it's in patchwork
now and will be properly tracked there.

Sending a v2 for the commit message improvements is not needed (I can fix
that on the fly).  If code changes are requested, the v2 for those can
then include the message fixes.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sDskY7hHyckRYBuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnLBVAAoJEB2Cnv7KVigS03gL/iKMdoLFPPVfsSdR9f+CPEGs
dhaOhp+zPuYV9SByLjgMm0lLZg/cVJCRtOYUwfFFESniIfqB3q8zREWTI3brUd4e
zWZDDsY+aFSS3P7yYZ2080rpcvEm9rpAgSd2/+NjIOVq5hDrl2ZC+qjiOcjFzSqA
jvP4lc19DJsr3E4L01P80Lb8wfxeGxHxyRLR6zagfTN+KDVdiEf+8Q/uUFXORoCU
N2KwS2ClplJkTmE97oBQ6iUp3ZurMP4rgEIpFk2H0mUM1eCJav78xBTE9m+Q5m4Q
0On7Ke5A4gvM+o9nUo5h8SclxckJkmMSx9Ct0QzB4Evt0HiGykn5L4oVRlSoiGQa
1ZVBakg7uadUmlfiatoECnD31Iqq0cQoHg/jJHg+i3r2QqjYlDC8KCeZuWfS1Nvi
iSjw0inTdmY5Cfs6Qk1kV/GGpvtW9GygF9rjshBrPG5EAv95B9eMMfwEAy96VkKu
SB/JK6MQX3mNQGmijzKJEug2OgMZkt9BFRKChEQwbw==
=K0Uh
-----END PGP SIGNATURE-----

--sDskY7hHyckRYBuA--

