Message-ID: <4DBAA96B.4010407@...1114...>
Date: Fri, 29 Apr 2011 14:04:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Build issues with Microsoft Visual Studio
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


Hi folks,

We need some help here to figure out why we get much more build errors when
compiling the new 'master' branch (checkout of commit b70d99fb617350).

The issues can be found here:
<http://build.openvpn.net/buildlog.txt>

What has happened since the v2.2.0 builds and master is basically merging
in feat_ipv6_payload and feat_ipv6_transport branches, in addition to
syncing up with the latest changes from James' SVN 2.1 branch.  In total
there are 137 commits differentiating the v2.2.0 and master branch.

I've just sent a patch for review which fixes the openvpn-plugin.h warnings
[1].  But there are plentiful of other things to fix as well.

Samuli has tried to use git bisect to isolate the commit, and it can look
like commit 49a945eafea2c [2] might cause some of these issues.  But it's
not enough to confirm if it solves everything.  I'm Cc'ing JuanJo Ciarlante
as he is the author of that commit.

If anyone have some good ideas or insight, please share! :)


kind regards,

David Sommerseth


[1] <http://thread.gmane.org/gmane.network.openvpn.devel/4629>
[2]
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn.git;a=commitdiff;h=49a945eafea2c64dbaa5cb2ecdfd4ca9a82aa26e>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAk26qWYACgkQDC186MBRfrpjHwCfcPc3EcinjQMUkQTWEBD8L+Ta
Qm4Al1479RV2vwEpJO/FMQlA+x5XAyY=
=Uzez
-----END PGP SIGNATURE-----

