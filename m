Date: Sat, 13 Dec 2025 13:29:28 +0100 (CET)
Message-Id: <202512131229.5BDCTSRJ057920@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251213084225.30988-1-gert@...1296...>
References: <20251213084225.30988-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Avoid some conversion
 warnings
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

"Makes sense".

The whole context of string_substitute() might warrant some revisiting
(why do *two* of the scripts modify p[1] while everything else does
not?), but this is a different scope to this patch.

Stared-at-code, and BB says it's all green.  Two pragmas gone!

Your patch has been applied to the master branch.

commit 2a9c8a8cd6f50c27a8295a169fd14ccf92ee92ac
Author: Frank Lichtenheld
Date:   Sat Dec 13 09:42:18 2025 +0100

     options: Avoid some conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1440
     Message-Id: <20251213084225.30988-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35061.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


