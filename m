From: James Yonan <jim@...41...>
Message-ID: <Pine.LNX.4.58.0508251115310.7239@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.0.2 released
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
Date: Thu Aug 25 10:21:43 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Download:

http://openvpn.net/download.html

Changes since 2.0.1:

* Fixed regression bug in Win32 installer, introduced in 2.0.1,
  which incorrectly set OpenVPN service to autostart.
* Don't package source code zip file in Windows installer
  in order to reduce the size of the installer.  The source
  zip file can always be downloaded separately if needed.
* Fixed bug in route.c in FreeBSD, Darwin, OpenBSD and NetBSD
  version of get_default_gateway.  Allocated socket for route
  manipulation is never freed so number of mbufs continuously
  grow and exhaust system resources after a while (Jaroslav Klaus).
* Fixed bug where "--proto tcp-server --mode p2p --management
  host port" would cause the management port to not respond until
  the OpenVPN peer connects.
* Modified pkitool script to be /bin/sh compatible (Johnny Lam).

James


