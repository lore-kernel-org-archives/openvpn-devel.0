From: David <linuxman1973@...109...>
Message-ID: <loom.20050822T045815-289@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Server not using tty as it's passing auth to =?utf-8?b?cGFtX2FjY2Vzcy5zbw==?=
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
Date: Sun Aug 21 21:02:01 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Apologize for putting this problem on the developer list.  Just not getting to
many hits else where.  When I log into my server and manually restart the
server, all is well with my VPN connections.  After a short time, login attempts
result in failures.  The passwords come back as auth failed or critical errors
(in the openvpn.log file).  

Did some research and it appears the login attempts that are passed to PAM and
pam_access.so (via login module) are not showing an originating tty.  The
/var/log/auth.log shows:
Aug 21 18:31:11 nssab2-ada-jenkins pam_access[6060]: couldn't get the tty name
Aug 21 19:28:09 nssab2-ada-jenkins pam_access[6060]: couldn't get the tty name
Aug 21 19:32:03 nssab2-ada-jenkins pam_access[6060]: couldn't get the tty name
Aug 21 19:33:50 nssab2-ada-jenkins pam_access[6060]: couldn't get the tty name
Aug 21 19:45:53 nssab2-ada-jenkins pam_access[6060]: couldn't get the tty name

The requesting tty that pam_access expects is not there, NULL value.  It then
kills the login process and OpenVPN will not work till manually stopped and
restarted from a SSH session.

Using PAM .78 and openvpn-2.0_rc17




