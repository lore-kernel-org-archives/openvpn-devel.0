Date: Mon, 13 Jul 2020 11:55:54 +0200 (CEST)
Message-Id: <202007130955.06D9tsvl024258@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200713093252.30916-1-gert@...1296...>
References: <20200713093252.30916-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Handle connecting clients
 without NCP or OCC without crashing.
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

Patch has been applied to the master branch.

The whitespace dragon spotted a "== NULL )" mishap, which was dutifully corrected.

commit b15fcceb1dd8b4fc2bf89deff94832f2654c3ac3
Author: Gert Doering
Date:   Mon Jul 13 11:32:52 2020 +0200

     Handle connecting clients without NCP or OCC without crashing.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200713093252.30916-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20309.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


