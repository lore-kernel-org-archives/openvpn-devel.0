Date: Fri, 16 Jun 2017 11:07:13 +0200 (CEST)
Message-Id: <201706160907.v5G97DDf032779@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170518132432.22776-1-davids@...515...>
References: <20170518132432.22776-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Script generating
 the source releases in an automated fashion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

This makes sense, and does what it says on the lid.

I tested on FreeBSD/ksh and it worked nicely and built a nice 2.3.14 tarball
for me, except for the small beef that "mktemp" does not have a "-p" option 
there, so it needs to be "mktemp -d /var/tmp/openvpn-build-release-XXXXXX" 
instead... (changed in my local copy, not in-tree), and that it needs
a system with "easy to find" LZO (no configure options)...  otherwise
you need to pass in LZO_CFLAGS/LZO_LIBS as env vars beforehand.  With
that, it works :)


Well, nearly...  at the very end, it fails because you can't do {foo,bar}
in non-bash/non-zsh shells...

-- Creating final tarbundle with everything ...
tar: openvpn-*.{tar.gz,tar.xz,zip}{,.asc}: Cannot stat: No such file or directory
-- Cleaning up ...

.. but the files are all there, so it's just a matter of explicitely
listing the 6 to-be-expected files...

-rw-r--r--  1 gert  wheel  1266905 Jun 16 11:02 openvpn-2.3.14.tar.gz
-rw-r--r--  1 gert  wheel      630 Jun 16 11:03 openvpn-2.3.14.tar.gz.asc
-rw-r--r--  1 gert  wheel   840472 Jun 16 11:02 openvpn-2.3.14.tar.xz
-rw-r--r--  1 gert  wheel      630 Jun 16 11:03 openvpn-2.3.14.tar.xz.asc
-rw-r--r--  1 gert  wheel  1543383 Jun 16 11:02 openvpn-2.3.14.zip
-rw-r--r--  1 gert  wheel      630 Jun 16 11:03 openvpn-2.3.14.zip.asc
-rw-r--r--  1 gert  wheel      678 Jun 16 11:03 openvpn-v2.3.14.sha256sum.asc
-rw-r--r--  1 gert  wheel     2560 Jun 16 11:03 openvpn-v2.3.14.tar



As this is a dev-tool, sticking to "master" - we use it to *build* a
release, but it does not have to be *part* of the release (and isn't
packed itself into the tarballs anyway).

Your patch has been applied to the master branch.

commit 0776a8c60f1d68e72be2dcc30710855a855d1e0a
Author: David Sommerseth
Date:   Thu May 18 15:24:32 2017 +0200

     dev-tools: Script generating the source releases in an automated fashion

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170518132432.22776-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14672.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


