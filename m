Message-ID: <4D8C6068.2070702@...1114...>
Date: Fri, 25 Mar 2011 10:29:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Changes to the git tree
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

As we're getting closer and closer to the v2.2 release, I've began to
prepare the git tree for the v2.3 development phase.

In the developers meeting July 8, 2010 [1] it was also decided to start
migrating completely over to git.  This move we are now doing is following
in this track.  We have already released 2.1.4 and all the 2.2 betas and
release candidates from the git tree as well.

The new change is that I have merged beta2.2, bugfix2.1 and feat_misc into
a new master branch.  The old master branch is scrapped.

When feat_ipv6_payload and feat_ipv6_transport branches have been *rebased*
against the new master branch, I will merge them into the master branch.
These two feature branches will be the most important feature changes to
OpenVPN 2.3.

The bugfix2.1 and feat_misc branches will be closed down, and will be
removed completely later.  New patches which earlier would go into these
branches will now be applied to the master branch instead.

For the coming release for the final v2.2.0, the beta2.2 branch will be
renamed to release-2.2.  When we're starting the beta 2.3 phase, the master
branch will be forked out to a beta2.3 branch.  Patches should primarily be
written to go on top of the master branch, and relevant patches for beta2.3
will be cherry-picked to that branch.  This way, we can continue full
development of OpenVPN while stabilising the code for releases along the way.

Feature branches will be used less from now on.  The purpose of the these
branches will be used for features which is not quite ready to be included
into the master branch.  For this purpose we will have the allmerged branch
which will be a merge of the master branch plus the feature branches.
These feature branches should not become long-time development branches, as
we want to have accepted features included into the master branch as soon
as possible.

Maintainers of feature branches *must* from now on *rebase* their branches
against the master branch, and this must be done regularly.  It is really
important that *git rebase* is used and *not* git merge, as that kludges
the commit history.

For patches which is related to the OpenVPN-2.2-RC releases, please base
them on the master or beta2.2 branch and we will cherry-pick them either
way for now.  This routine will change when we start the beta2.3 phase.


kind regards,

David Sommerseth


[1] <http://thread.gmane.org/gmane.network.openvpn.devel/3829>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2MYGgACgkQDC186MBRfrqOzQCaAxhIVqjz+a0ApmoArNnLEWM2
TeAAoJRTzUCoZD5ksG/nWNskghDyKiti
=9UuW
-----END PGP SIGNATURE-----

