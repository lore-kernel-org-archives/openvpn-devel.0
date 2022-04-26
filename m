Date: Tue, 26 Apr 2022 15:52:35 +0200 (CEST)
Message-Id: <202204261352.23QDqZxJ098720@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220426132324.76517-2-arne@...1227...>
References: <20220426132324.76517-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract session_move_active
 into its own function
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

This is the 2nd half of "patch 13 v2".  It has a semi-ACK from Frank,
and now a proper commit message as well :-)

Verified "it's only moved code" by hand (indent change), and lightly
tested.

Whitespace error has been fixed by git, so the "whitespace fix" hunk coming
up won't apply - but I can handle that :-)

Your patch has been applied to the master branch.

commit 4dbe508ab6d011d57f4acc71f3c0330deb852206
Author: Arne Schwabe
Date:   Tue Apr 26 15:23:24 2022 +0200

     Extract session_move_active into its own function

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220426132324.76517-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24212.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


