Date: Sun, 13 Feb 2022 10:45:23 +0100 (CET)
Message-Id: <202202130945.21D9jNEd042935@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-4-arne@...1227...>
References: <20220210162632.3309974-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update fragment and mssfix
 related warnings
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Have not actually tried triggering these warnings, but the logic is
sane, and the code looks reasonable.

Client-side tested "just for completeness".

For reference, this was 15/21 in v1+v2 of this series and 06/14 in v3,
and 15/21 got an ACK from Frank Lichtenfeld with a comment about the
wording of the "the mtu" warning, which was addressed in v2.

Your patch has been applied to the master branch.

commit f1e06301c71e8c8d4eb9c93939e775596fc2f998
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:28 2022 +0100

     Update fragment and mssfix related warnings

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23753.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


