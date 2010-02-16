Message-ID: <4B7AE8D6.3020304@...1114...>
Date: Tue, 16 Feb 2010 19:49:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn-testing tree available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings all!

I am now announcing the openvpn-testing.git tree as open.  Gert has
already been announcing the availability as a response to some merge
conflicts.  Anyhow, those issues are solved.

The tree is also tagged with all 2.1 releases and RC releases.  I have
not bothered with tagging the 2.1 beta or any 2.0 releases at all.  If
somebody finds it useful and wants it, please generate a list of tag
names and commit ID's and I'll update the tree.


What's next:

- - JuanJo Ciarliante's IPv6 patches for the transport layer.
  There are some merge conflicts here as well, which we need to solve.
  It's most probably due to different merge roots between our copies of
  the SVN tree.  I hope JJO and I can solve this soon, then it will go
  into the allmerged branch immediately.

- - Go through the mailing list to pick up branches which has not been
  included into the the OpenVPN SVN tree.  I will probably not go much
  further than the last 9-12 months.  If you have a patch you want to
  be sure gets into the tree, please raise the attention by sending an
  e-mail to this mailing list.  I don't intend to deliberately ignore
  patches.

  James: Do you have an overview over patches you have included already?
  And patches you've received which has not been processed yet?

- - The eurephia patch got a review, with one comment I'd like to
  investigate a little bit more (If ctx->current_cert->sha1_hash is
  always valid).  When this is done, the feat_eurephia branch will be
  merged into the allmerged branch.

- - Update the developers documentation on the wiki, with some
  "requirements" to get patches included.  For already submitted patches
  I will be a little bit nicer.  Patches after this mail should strive
  to follow the guidelines found in the mail discussion here [1].  All
  patches are *expected* to apply cleanly against the latest SVN
  BETA21/openvpn branch or the git master branch.

The next big test for this is when James does some more commits, and to
see how smoothly it will merge in those changes.


For those wanting to contact me, I'm available on e-mail:
<dazo@...384...> or on IRC (freenode, #openvpn-devel)

The git tree is available here:
<git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git>

Web view of the git tree can be found here:
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git>



kind regards,

David Sommerseth


[1]
<http://sourceforge.net/mailarchive/message.php?msg_name=4B6A9823.8010800%40topphemmelig.net>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt66NMACgkQDC186MBRfrp4KACfQpqkUvcbB2GLxiBUx/ETX1Xw
0ZwAoIbajA0Q5/Rm7cP+AUGgNPezlEwg
=MvpN
-----END PGP SIGNATURE-----

