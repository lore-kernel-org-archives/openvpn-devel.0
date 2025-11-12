Date: Wed, 12 Nov 2025 16:54:18 +0100 (CET)
Message-Id: <202511121554.5ACFsI8H053978@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251111172437.7634-1-gert@...1296...>
References: <20251111172437.7634-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: change return type of
 calc_control_channel_frame_overhead to size_t
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Some leeway here in "how to fix the warnings in a good way" - size_t is
quite reasonably here.  Arne ACKed, BB greened, ship it!

Your patch has been applied to the master branch.

commit 8b0554d988f6bfdefd30620290ec8ff690a37ce2
Author: Frank Lichtenheld
Date:   Tue Nov 11 18:24:31 2025 +0100

     ssl: change return type of calc_control_channel_frame_overhead to size_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1297
     Message-Id: <20251111172437.7634-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34326.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


