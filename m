Message-Id: <200305120447.h4C4lJ103121@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] Patch for --verb 0 bug in OpenVPN 1.4.0
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
Date: Sun May 11 21:48:04 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

A bug has been discovered and confirmed that can peg CPU utilization to 100%
if all of the following are true:

(1) You are running OpenVPN 1.4.0,
(2) you are running on Linux 2.4 or higher,
(3) you are using the --verb 0 option to suppress all output, and
(4) a non-fatal socket error occurs (such as a temporary network outage).

There is a simple workaround available in this patch against 1.4.0:

http://openvpn.sourceforge.net/patch/esec-disable.patch

Patch Usage (from openvpn-1.4.0 directory after fresh tarball extract):

patch < esec-disable.patch && ./configure && make

Alternatively, you can get the fix in the current development tarball:

http://openvpn.sourceforge.net/beta/openvpn-1.4.0.2.tar.gz

Or the simplest solution is to just use --verb 1 (the default) until 1.4.1 is
released.  If --verb 1 is too verbose for you, check out --mute which can be
used to lessen the incidence of repetitive messages.  --mute is unaffected by
this bug.

James


