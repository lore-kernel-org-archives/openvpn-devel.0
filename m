Date: Thu, 25 Jan 2018 14:29:55 +0100 (CET)
Message-Id: <201801251329.w0PDTt7A091990@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516194984-1540-1-git-send-email-steffan.karger@...1435...>
References: <1516194984-1540-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Plug memory leak if push is
 interrupted
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Makes sense.

The changes to crypto_mbedtls.c match the documentation for the mbedtls
md functions, and the rest is just basic "if you make it, clean it up 
later on again" :-) - lightly tested ("t_client"), too lazy to come up
with a test rig to trigger and truly test this.

Your patch has been applied to the master and release/2.4 branch.

commit 07036fd3c456ed4ebf1809d8d9f34941d42865d0 (master)
commit d04032c3f236cf7c726d6b162686bcb71fda2e15 (release/2.4)
Author: Steffan Karger
Date:   Wed Jan 17 14:16:24 2018 +0100

     Plug memory leak if push is interrupted

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1516194984-1540-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16265.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


