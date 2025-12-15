Date: Mon, 15 Dec 2025 17:12:10 +0100 (CET)
Message-Id: <202512151612.5BFGCAwb060806@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251215160541.24237-1-gert@...1296...>
References: <20251215160541.24237-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: Change buf_prepend and
 buf_advance to accept ssize_t for length
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

Looks reasonable, compiles fine :-) - and I really should have merged
this one before #1438 (upsetting -Werror compiles for everyone).

Your patch has been applied to the master branch.

commit cb4d5426d0751ce4720fbc7531de51731725a5fb
Author: Frank Lichtenheld
Date:   Mon Dec 15 17:05:35 2025 +0100

     buffer: Change buf_prepend and buf_advance to accept ssize_t for length

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1437
     Message-Id: <20251215160541.24237-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35099.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


