Date: Fri, 10 Nov 2023 20:47:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZU6I1MMD980Ervm-@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
 <ZU39JoRBq8R_NgD6@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="90OJ56lo5Nf1Mhcs"
Content-Disposition: inline
In-Reply-To: <ZU39JoRBq8R_NgD6@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--90OJ56lo5Nf1Mhcs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 10, 2023 at 10:51:34AM +0100, Gert Doering wrote:
> I'll see if I can reproduce this case here and we'll fix it ASAP.

We couldn't reproduce it yet, but we have a crash dump in GH issue #449,
which hints at the commit cd4d819c99266 getting this double-extra-check
wrong.

So if you build from git, can you do a checkout of release/2.6, and
then do "git revert cd4d819c99266", and build from that?  This would
give you a 2.6.7 "with both CVE fixes, but without the extra safeguard
check" - which isn't *really* needed, but its intention was "should=20
another mistake of sort addressed in the CVE fixes happen again, it
would get caught" - so double belt and suspenders...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--90OJ56lo5Nf1Mhcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlTojTAAoJEB2Cnv7KVigSNiUL/ip+nXuwgdqOmWBW8EBbsVer
1tRLfX1Isp0cE6HPWEWOjRqvG2w90qwr1dToal4U5RqCR097L4P1POlfPOufSMuC
FNN7fIwmSPfkfPSDKDBAiRyvlkqrx6ZWT/Xmqm2svSs7IBDMYzGC7QFGkSK5PaBF
VLU+4Ft4Vty8AtH2klr8wuvsPCrDzWK39q2yQPktGQROsWGno05TRdfPTxaiD8kP
GHzdEW3oZ7huAWCfP1wrOYtewBRmZo936NxDKvC+ZwbH+vkmmCWCtns6vxm85PpJ
sLyf5/L4tWUCz8MrQVU1Jt7/W7L6Z4d/AJI/lFtnxybelOdoP9hLQT5CkMtyjlZG
WIr32Fjx+Zv9or0Ob2/Sdm5RAF5/3g/F33oqSb+O5BMZar8XUmi0dPMh3QoltQPF
YnUqmCuGj/i0g7kcvCPGRDh8AMKQXZuGx//A6K6fzymKinxKqAZDmt9scWaypQgj
dSyV4HwwWRqZHRVGOXz+dtKTvH1/ooK6vT0Plo1/wA==
=MZox
-----END PGP SIGNATURE-----

--90OJ56lo5Nf1Mhcs--

