Date: Sun, 19 Nov 2017 20:44:52 +0100 (CET)
Message-Id: <201711191944.vAJJiqLf070239@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171116140958.12847-1-steffan@...1856...>
References: <20171116140958.12847-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add per session pseudo-random
 jitter to --reneg-sec intervals
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
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  The change makes sense, the actual functionality is what the 
discussion converged to, and the code looks sane (no long long, but it
isn't printing a time_t either :-) ).

Your patch has been applied to the master branch.

commit dd99646347bc5461fa83b0e62114550504bb128f
Author: Simon Matter
Date:   Thu Nov 16 15:09:58 2017 +0100

     Add per session pseudo-random jitter to --reneg-sec intervals

     Signed-off-by: Simon Matter <simon.matter@...2249...>
     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20171116140958.12847-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15888.html
     Signed-off-by: Gert Doering <gert@...1296...>


for patchwork:
Acked-by: Gert Doering <gert@...1296...>
--
kind regards,

Gert Doering


