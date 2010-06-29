Message-ID: <4C298338.2050003@...1114...>
Date: Tue, 29 Jun 2010 07:23:04 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Beta 2.2 branch pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <james@...515...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

I've been working on the beta 2.2 preparations.  And it's now pushed out
on git and SVN.

git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git
(branch: beta2.2)

SVN: http://svn.openvpn.net/projects/openvpn/contrib/dazo


I am not completely confident it is done properly, and I'm prepared to
scratch it all and do it again if something is wrong with my SVN push.
The reason is that when I did the SVN push a lot happened.

The SVN branch I was given was completely empty, so when I pushed the
stuff from git all commits was modified and made me the author of all
commits, from the very beginning.  This does sound a bit odd to me, to
be honest.  But if this is how SVN works, it's not too much to do with
that.  The nasty thing about this is that the commit ID's in the git
beta2.2 branch is different from their origin commits.

It might be that we should reconsider to scrap the SVN complete, and
that James prepares a new branch which is based on his last BETA21 SVN
branch, and that I push on top of that branch.  This way at least his
commits will have him as the owner of his own commits.  The the vast
majority of the git commits anyway do have Signed-of statements, so we
still can still track who is behind most of those commits.

One notice:  No-one should use beta2.2 as the base for providing patch
unless it is fixing issues which appears only in the beta2.2 branch.


* What does the beta2.2 branch contain?
As agreed to in the developers meeting June 10, OpenVPN 2.2 will contain:

- - bugfix2.1 branch (lots of bugfixes)
- - feat_misc branch (several minor feature additions)
- - frp branch (https://community.openvpn.net/openvpn/wiki/FRP)
- - feat_eurephia branch (http://www.eurephia.net)
- - IPv6-enabled TAP driver for Windows

I have created an own branch (feat_ipv6_wintap) which is based on the
SVN-beta2.1 branch and contains Gert's IPv6 changes for the Windows TAP
driver on top of that.  Further development of the IPv6 feature on this
driver should go into this branch, and we might consider to make this
branch generic for all Windows TAP modifications.  Gert will look into
making this branch merge cleanly against his feat_ipv6_payload branch.


The first step towards a OpenVPN 2.2 beta is taken.  But as I said
earlier, I'm ready to go back this step and redo whatever is needed to
clean up any potential mess.  And if someone got more experiences, ideas
or hints how to do this better, please let me know! I know git a lot
better than SVN, so I might have done some pretty lame mistakes :)


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwpgzgACgkQDC186MBRfrropwCgjyXmf0dnWrcinHGbxE8w9dBH
o1IAnjStG1lGlq48yS/nSHSEJaADdctr
=7IGJ
-----END PGP SIGNATURE-----

