From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 11:28:35 +0200
Message-ID: <1497864520-12219-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openssl and mbedtls x509 fixes
 (CVE-2017-7521 & -7522)
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
To: openvpn-devel@lists.sourceforge.net

Hi,

This patch set contains the five commits that fix the X509 issues found
by Guido in both our mbedtls and openssl code.  It is based on the
current master branch.

Compared to the previously sent patches, patch 4/5 ('Restrict
--x509-alt-username extension types') was changed to include more
user-friendly error reporting, and fix a typo in the man page.  The
other patches have only slightly tweaked commit messages and Changes.rst
entries, mostly just mentioning the CVE ID.

-Steffan



