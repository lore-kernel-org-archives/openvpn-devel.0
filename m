Message-ID: <002101c37d68$afaac120$070116ac@...107...>
From: "John Conneely" <john@...106...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Beta naming convention?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Sep 17 15:16:04 2003
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hi James!

First, thanks for such a great product!  I've been using openvpn-1.3.2 on a
few Mandrake boxes for a little under a year now, and it's been bulletproof.

Now I'd like to try out windows support, so I thought I'd upgrade to your
latest beta.  (I'm not sure if that's necessary on my linux boxes, but I
thought it might be nice to try it out anyway.)  The problem is that I
install everything as RPMs on my Mandrake box, and I got an error when I
used the rpmbuild-tb [tarball] command.  This seems to be because you use a
dash character "-" in the version number.  I was able to get around this by
making the dash character into an underscore, setting version to "1.5_beta7"
in openvpn.spec.  I also made the directory name and tar ball use the same
convention.  It works fine on the box I upgraded, even working with my other
openvpn-1.3.2 installations.

Anyway, I wanted to suggest that you avoid using dash characters in future
beta version numbers.

Thanks!

John



