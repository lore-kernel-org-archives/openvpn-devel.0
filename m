Date: Wed, 29 Oct 2025 08:10:23 +0100 (CET)
Message-Id: <202510290710.59T7ANh2048278@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251028203156.11697-1-gert@...1296...>
References: <20251028203156.11697-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: zeroize struct image in
 packet_id_persist_save() before writing to disk
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Not the most critical path, but "initialize data structures before using"
is considered good practice :-)  - BB is also happy with it.

Patch has been applied to the master branch.

commit c58b6e73c3508b40b3d2f26eebfc3aa4df53e524
Author: Gert Doering
Date:   Tue Oct 28 21:31:50 2025 +0100

     zeroize struct image in packet_id_persist_save() before writing to disk

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1323
     Message-Id: <20251028203156.11697-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33983.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


