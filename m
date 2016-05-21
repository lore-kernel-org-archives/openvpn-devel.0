From: openvpn-devel@...2127...
Date: Sat, 21 May 2016 11:22:03 +0200
Message-Id: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
Subject: [Openvpn-devel] Refactor t_client.sh & improve output formatting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Ratio:
* Cleanup code
* Prepare for better automated integration tests (future)

Move global code into separate functions. Fixup formatting of code. 
Also add table output formatting to t_client.sh:

| ID | TEST                                | RESULT               |
| -- | ----------------------------------- | -------------------- |
|  1 | testing tun/udp/ipv4                | [SUCCESS]            |
|  2 | testing tun/udp/ipv4 with pam       | [FAIL: 5 fails]      |
| -- | ----------------------------------- | -------------------- |
Test sets succeded: 1.
Test sets failed: 2.

For easier review these patches have also been provided via GitHub pull request: 
https://github.com/OpenVPN/openvpn/pull/49

Due to moving code around and intention changes this patch looks rather large:
 1 file changed, 267 insertions(+), 180 deletions(-).



