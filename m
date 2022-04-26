Date: Tue, 26 Apr 2022 12:42:37 +0200 (CEST)
Message-Id: <202204261042.23QAgbLa095743@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-3-arne@...1227...>
References: <20220422142953.3805364-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract session_move_pre_start
 as own function, use local buffer variable
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

Stared at the code for a bit, and ran the t_server tests, for good measure.

All fine.

"git diff --color-moved=zebra" is non-helpful here, due to the indent change.

Your patch has been applied to the master branch.

commit edc3e9f5c939ca40841b8054732bfae47aad7e11
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:37 2022 +0200

     Extract session_move_pre_start as own function, use local buffer variable

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422142953.3805364-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24151.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


