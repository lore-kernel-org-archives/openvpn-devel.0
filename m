From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <562103AD.1090907@...1114...>
Date: Fri, 16 Oct 2015 16:03:25 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wNFbQbAqnaadhET4MhRQlCkQHQIgxBJaN"
Subject: [Openvpn-devel] The OpenVPN git repositories
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNFbQbAqnaadhET4MhRQlCkQHQIgxBJaN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

During the last OpenVPN hackathon in Delft 2015, I brought up the
question if we should merge and clean up our git repositories somewhat.

Currently our primary git repositories are:

  sourceforge.net - openvpn.git
  sourceforge.net - openvpn-testing.git

And we have a partly merged version on github too.


The history of these splits
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Back in 2009-2010-ish I got involed in the OpenVPN community where I
pulled down the only available public SVN repository into git.  The idea
was that James Yonan would use SVN until he was ready to switch to git
at some later point.  In the mean time, we had a lot of patches
lingering on this -devel ML.  So we started giving those patches some
attention.

Stability and predictability have always been very important for us.  So
we decided to do all the experimental stuff in a 'testing' repository.
This was the community playground.  The master branch was meant to be
synced with the official 'stable' (openvpn.git) tree, which again was
synced against SVN.  Each experimental patch set we had would go into a
'feature branch'.  Once they were properly tested and as far as possible
reviewed, they got merged into the master branch.  When doing releases
the master branches between the stable and testing repository would be
merged and tagged.

This worked very well in the beginning, as we had plenty of feature
branches, most significantly the IPv6 transport and IPv6 payload
braches.  Plus many fixes which had been lingering too long on the
mailing list got reviewed, tested and got into our first OpenVPN 2.2
release.


But time changes .....
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

... and so does our needs.  We don't used SVN any more, as James have
switched to git as well, a long time ago.  In addition, it is in the
vast majority of the community developers which works on the OpenVPN 2.x
code base these days.  In addition, the developer community have grown
since the 2009-ish.  And we see more patches from even more contributors
now.  This is truly wonderful!

The whole time we have had a fairly strict regime for accepting patches.
 This we do not want to change much at all.  We do need to improve the
review process, but among the developers there is a mutual agreement
that all reviewed patches *MUST* go to the mailing list.  No exceptions.
 But we will discuss better arenas for reviewing patches; that's
something will be brought up at a later point.


So what want to propose is to get rid of the openvpn-testing.git
repository and merge it into the stable openvpn.git and github repositories.

The reasons are that we have not used any feature branches in several
years.  Most of them have not even been rebased to the latest master.
They are completely outdated.  And master branches on both stable and
testing repositories are these days basically identical and all new code
hits the master branch directly when the patch review results in an ACK.

On the other hand, we do not want to have just a single git repository.
 That is to better safe-guard us against situations similar to what the
Linux kernel community experienced a few years ago, where a public git
tree got manipulated by an outsider.  By having several publicly
available git repositories, it will hopefully be easier to discover if
something bad has happened - especially for those not necessarily
directly involved in the developers community.

As a side note, both Gert and I have commit access to the public
repositories, and we also do pushes to private git repositories as well
- as an extra layer of repository validation.


What needs to be done
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Push needed/interesting branches from openvpn-testing to the stable
  git repos - both on sourceforge.net and github
- Update developers documentation on the wiki page
- Review any documented processes we may have documented elsewhere
- Remove the openvpn-testing.git repository from sourceforge.net


Does anyone have any opinions on this?


--=20
kind regards,

David Sommerseth


--wNFbQbAqnaadhET4MhRQlCkQHQIgxBJaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYhA7AACgkQDC186MBRfrrNqwCeNhz5tFu2E236QxX1QOeBGO+V
NksAn0Kn+vR5zQAI7s4qSV+kuTMDaVAL
=msp1
-----END PGP SIGNATURE-----

--wNFbQbAqnaadhET4MhRQlCkQHQIgxBJaN--

