Date: Tue, 17 Sep 2024 11:40:59 +0200 (CEST)
Message-Id: <202409170940.48H9exgd037857@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240917091433.24092-1-gert@...1296...>
References: <20240917091433.24092-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix check_addr_clash argument
 order
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Good find.

I tested this as instructed in gerrit, also enabling the #if 0 debug code -
this is a p2p setup with --topology subnet, to actually have a subnet to
check against.

Test 1, "--local" in the "--ifconfig" subnet:

2024-09-17 11:25:45 CHECK_ADDR_CLASH type=2 public=10.204.8.7 local=10.204.8.2, remote_netmask=255.255.255.0
2024-09-17 11:25:45 WARNING: potential conflict between --local address [10.204.8.7] and --ifconfig address pair [10.204.8.2, 255.255.255.0] -- this is a warning only that is triggered when local/remote addresses exist within the same /24 subnet as --ifconfig endpoints. (silence this warning with --ifconfig-nowarn)

"works".

Test 2, "--remote" in the "--ifconfig" subnet:

2024-09-17 11:27:03 CHECK_ADDR_CLASH type=2 public=10.204.8.8 local=10.204.8.2, remote_netmask=255.255.255.0
2024-09-17 11:27:03 WARNING: potential conflict between --remote address [10.204.8.8] and --ifconfig address pair [10.204.8.2, 255.255.255.0] -- this is a warning only that is triggered when local/remote addresses exist within the same /24 subnet as --ifconfig endpoints. (silence this warning with --ifconfig-nowarn)


Test 3, no "--topology subnet":

2024-09-17 11:36:28 CHECK_ADDR_CLASH type=2 public=10.204.8.250 local=10.204.8.2, remote_netmask=10.204.8.1
2024-09-17 11:36:28 WARNING: potential conflict between --local address [10.204.8.250] and --ifconfig address pair [10.204.8.2, 10.204.8.1] -- this is a warning only that is triggered when local/remote addresses exist within the same /24 subnet as --ifconfig endpoints. (silence this warning with --ifconfig-nowarn)
2024-09-17 11:36:28 CHECK_ADDR_CLASH type=2 public=10.204.8.220 local=10.204.8.2, remote_netmask=10.204.8.1
2024-09-17 11:36:28 WARNING: potential conflict between --remote address [10.204.8.220] and --ifconfig address pair [10.204.8.2, 10.204.8.1] -- this is a warning only that is triggered when local/remote addresses exist within the same /24 subnet as --ifconfig endpoints. (silence this warning with --ifconfig-nowarn)

.. it "works as designed", but does raise questions... see below.


So, while this patch is actually fixing the first problem with this
code, I have some ideas how to improve things further ;-)

 - the line wrapping "one function argument per line" is not how we do
   things today, so a future (master-only) patch could improve that

 - the check as implemented today checks "within the same /24", so if
   I do "--ifconfig 10.204.8.2 255.255.255.128 --remote 10.204.8.220" 
   (which is perfectly sane) I get

      2024-09-17 11:30:44 CHECK_ADDR_CLASH type=2 public=10.204.8.220 local=10.204.8.2, remote_netmask=255.255.255.128
      2024-09-17 11:30:44 WARNING: potential conflict between --remote address [10.204.8.220] and --ifconfig address pair [10.204.8.2, 255.255.255.128] -- this is a warning only that is triggered when local/remote addresses exist within the same /24 subnet as --ifconfig endpoints. (silence this warning with --ifconfig-nowarn)

   ... which is not making any sense.  Computers can do math, AND the
   code actually knows the netmask there, but uses /24 always
   (the TAP check code actually uses the netmask...).

   So I think this code needs to be taught about "--topology subnet",
   and only does the /24 heuristic for p2p/net30 (if at all).


Your patch has been applied to the master and release/26 branch
(bugfix).

commit 7d345b19e20f30cb2ecbea71682b5a41e6cff454 (master)
commit 7e6723aa7096bee80eb42a473fbfde7de4362b0f (release/2.6)
Author: Ralf Lici
Date:   Tue Sep 17 11:14:33 2024 +0200

     Fix check_addr_clash argument order

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240917091433.24092-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29261.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


