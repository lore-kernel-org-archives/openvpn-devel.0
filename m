Message-ID: <4892B01F.10208@...41...>
Date: Fri, 01 Aug 2008 00:41:35 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc9 released -- note security fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Download:

http://openvpn.net/download.html

2008.07.31 -- Version 2.1_rc9

* Security Fix -- affects non-Windows OpenVPN clients running
   OpenVPN 2.1-beta14 through 2.1-rc8 (OpenVPN 2.0.x clients are NOT
   vulnerable nor are any versions of the OpenVPN server vulnerable).
   An OpenVPN client connecting to a malicious or compromised
   server could potentially receive an "lladdr" or "iproute"
   configuration directive from the server which could cause arbitrary
   code execution on the client. A successful attack requires that (a)
   the client has agreed to allow the server to push configuration
   directives to it by including "pull" or the macro "client" in its
   configuration file, (b) the client successfully authenticates the
   server, (c) the server is malicious or has been compromised and is
   under the control of the attacker, and (d) the client is running a
   non-Windows OS.  Credit: David Wagner.

* Miscellaneous defensive programming changes to multiple
   areas of the code.  In particular, use of the system() call
   for calling executables such as ifconfig, route, and
   user-defined scripts has been completely revamped in favor
   of execve() on unix and CreateProcess() on Windows.

* In Windows build, package a statically linked openssl.exe to work
   around observed instabilities in the dynamic build since the
   migration to OpenSSL 0.9.8h.

James

