Message-ID: <4CA9B526.90504@...1114...>
Date: Mon, 04 Oct 2010 13:06:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn-testing git tree and the allmerged branch
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,

A little accident just happened, an invalid 'allmerged' branch got
pushed out.  *Don't trust allmerged* to provide the latest and greatest
right now.

The issue is that one of the IPv6 branches I've been merging in was
based on a wrong root.  And this exploded recently when James did some
changes in svn-BETA21 which gave conflict against the branch
feat_ipv6_transport.  The reason was that feat_ipv6_transport was not
based upon the openvpn-testing.git tree, but another git-svn tree.

To clean this up properly, I'm going to rebuild the complete allmerged
tree once again.  Unfortunately, I managed to push out the branch way
too early.  And what's worse, I don't have time this week to really
complete that job.

So, the fact is ... don't trust the allmerged branch right now.  All
other branches are fine, just not allmerged.  I'll try to fix it ASAP!
And I'm really sorry for this mess.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyptSQACgkQDC186MBRfrqsuQCgq1aCS7npStk/6SHHHmFOfFFu
uK4AnixI3jp+HgFuxbZswHQzMYqSavfx
=cY1c
-----END PGP SIGNATURE-----

