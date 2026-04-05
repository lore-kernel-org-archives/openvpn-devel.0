Date: Sun, 5 Apr 2026 12:18:46 +0200 (CEST)
Message-Id: <202604051018.635AIkdC089074@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260404203525.30790-1-gert@...1296...>
References: <20260404203525.30790-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Fix setting of
 iTicks in schedule_adapter_delete
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Good find.  A very clear bug, so goes back to release/2.7 and even
release/2.6 - now it does not really have much consequences except
progress bar not working correctly on uninstall... but still.

Your patch has been applied to the master, release/2.7 and release/2.6
branch.

commit 4494a343967e9cd0fcf32f167b22706512c8c68c (master)
commit f4669642581934d317707e56c297d777946ce5c4 (release/2.7)
commit 246bc0e8d022920889a69d19e2e534b9560c8d9a (release/2.6)
Author: Frank Lichtenheld
Date:   Sat Apr 4 22:35:19 2026 +0200

     openvpnmsica: Fix setting of iTicks in schedule_adapter_delete

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1608
     Message-Id: <20260404203525.30790-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36476.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


