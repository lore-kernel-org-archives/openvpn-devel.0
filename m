From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0510140111480.30752@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN SVN repository changes
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
Date: Fri Oct 14 00:25:39 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I've done some more work on the subversion repository -- it's now
accessible via http/https:

Check out stable version:

  svn checkout http://svn.openvpn.net/projects/openvpn/trunk/openvpn openvpn

Check out beta21 branch:

  svn checkout http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn openvpn

Build a tarball from checkout:

  [cd to top level of checkout directory]
  autoreconf -i -v
  ./configure
  make dist

James


