Date: Thu, 11 Jan 2018 12:38:11 +0100 (CET)
Message-Id: <201801111138.w0BBcBar094335@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1514541240-19536-1-git-send-email-steffan.karger@...1435...>
References: <1514541240-19536-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re:
 buffer_list_aggregate_separator(): prevent 0-byte malloc
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

Your patch has been applied to the master and release/2.4 branch.

commit 748902f46260fe11cb25726d2bf93bb06ad338f2 (master)
commit ef4b827d68d8fef75b04f23e6322aa9d2d4ad8a8 (release/2.4)
Author: Steffan Karger
Date:   Fri Dec 29 10:54:00 2017 +0100

     buffer_list_aggregate_separator(): prevent 0-byte malloc

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <1514541240-19536-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16106.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


