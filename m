From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0509262203120.25922@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN source repository migrated to svn (subversion)
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Sep 26 21:22:03 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I've migrated the OpenVPN source repository from CVS to subversion.

Read-only access is available at svn://openvpn.net/openvpn

Examples:

Check out the stable branch:
  svn checkout svn://openvpn.net/openvpn/trunk openvpn

Check out the BETA21 branch (has the new topology subnet and non-admin 
TAP-Win32 features):

  checkout svn://openvpn.net/openvpn/branches/BETA21 openvpn

Check out the BETA25 branch (very experimental):

  checkout svn://openvpn.net/openvpn/branches/BETA25 openvpn

I used the cvs2svn tool to convert the repository, so all the previous cvs 
metadata such as branch tags are still there.

James

