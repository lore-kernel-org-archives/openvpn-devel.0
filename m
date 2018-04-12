Date: Thu, 12 Apr 2018 10:26:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180412082603.GT69387@...1296...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JOUqYYSeXsqzCnuM"
Content-Disposition: inline
In-Reply-To: <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver (was: Summary of
 the community meeting) 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

--JOUqYYSeXsqzCnuM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Eric,

On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:
> One of the Viscosity developers here. The TAP driver used by Viscosity=20
> is based on the OpenVPN TAP-Windows driver. We're surprised to hear of=20
> any performance differences, as the changes we've made are very minimal.
>=20
> Besides a name and version number change, the only other modification is=
=20
> a change to the reported network adapter speed, which has Windows report=
=20
> the driver as 1000 Mbit instead of 100 Mbit.
>=20
> This change was made not because of any actual performance gains, but=20
> because of user reports that certain firewall or AV software tries to=20
> QoS the adapter based on its reported adapter speed, which is of course=20
> a problem if the VPN connection is capable of more than 100 Mbit.
>=20
> Please find a patch file of the changes attached.

I think it would make sense for us to merge that patch - for two reasons,
one is "the change could indeed help performance in high-bandwidth
situtions", and the more important one is "another patch to tap-windows6
is forthcoming, and that way we can keep the version numbers aligned
so people can know what is inside".

Do you have the patch in git?  If yes, could you please do the commit
with "-s" (so the signed-off-by: line is added) and send it as regular
git commit (git-send-email)?  Alternatively a PR against tap-windows6
on github should do as well.

Thanks in advance,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JOUqYYSeXsqzCnuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJazxgbAAoJEB2Cnv7KVigS+vkL/2EaFXauoZxbG01oz8cY70vL
XDUkpPwCCrK1ISMjJZT1z6Cpi5fn4bs6L2J3fQiJFh7g5dLK8eUrjjEEio+BfpfY
SOS3/bYCQEmqon6B+UUH3pd8OovauJDOIm73hdd1+8DD1W6V3A7VhvuG9BaUQ5qG
dxgO3SY2mbT+5XCrWAQAi85/oH7rEc8iSE4KacJaif0UgAJlxz2piWdbWjez9yHg
b33TbmAYf75CtuuL8h68yKaDX5reA0eLUoVIdVYybRp99QklbmcGSpygwS8W4nue
seCXR+hZwtikP11zKFYCjUKQ1plSqhjSBI8PjRZL+/ayx4qbz65MD4SQZQmN7jiw
F04tKI34YmAq3M9IIWov3wZBJjz9Ja/sm+tEN4JGpI6gDQCEV+5bkSbjTpannf84
7WTJ6UI7xEqJFjw6TmOXkZRmXjSDmJD38qqYxI8/PemKkRKA5mSakiFAYrdEdOU5
SP2WpERf5PA6fp4SopVuqQ9p/JIIy1iDpgjqgx24Tg==
=ir5d
-----END PGP SIGNATURE-----

--JOUqYYSeXsqzCnuM--

