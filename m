Date: Fri, 2 Apr 2021 17:13:55 +0200 (CEST)
Message-Id: <202104021513.132FDtGY018338@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210401131337.3684-13-arne@...1227...>
References: <20210401131337.3684-13-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract multi_assign_peer_id
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

Simple enough :-) - I have not tested this very very thoroughly, but
one of my server test instances has 3 parallel clients, so I could at
least see that they do get assigned different IDs (and that it compiles).

Your patch has been applied to the master branch.

commit 9fe0b2c287609cefe79aec30ff33f7a65cafd684
Author: Arne Schwabe
Date:   Thu Apr 1 15:13:35 2021 +0200

     Extract multi_assign_peer_id into its own function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210401131337.3684-13-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21959.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


