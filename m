Date: Mon, 28 Nov 2016 17:31:30 +0100 (CET)
Message-Id: <201611281631.uASGVUuK073499@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480343200-25908-1-git-send-email-steffan.karger@...1435...>
References: <1480343200-25908-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Clean up format_hex_ex()
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Long-standing eye-hurting code.  This is better - and (staring at
"openvpn --verb 11" output) seems to do the same thing.  At least the
code now looks like one could understand what it wants to do :-)

Your patch has been applied to the master branch.

commit 294040102fbceb4be320a45ba3c340ace1804a49
Author: Steffan Karger
Date:   Mon Nov 28 15:26:40 2016 +0100

     Clean up format_hex_ex()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480343200-25908-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13259.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


