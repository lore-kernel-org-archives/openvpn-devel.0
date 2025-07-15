Date: Tue, 15 Jul 2025 22:04:42 +0200 (CEST)
Message-Id: <202507152004.56FK4gpa098265@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250715143750.9719-1-gert@...1296...>
References: <20250715143750.9719-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: reliable: Review and fix
 gc_arena usage
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

Stared hard at the code changes (most of them trivial, but one mem leak
in one branch of reliable_can_get() fixed).  Tested on client/server setups.

Your patch has been applied to the master branch.

commit 074bd7451decad407398c59006aa0e24ea1f451c
Author: Frank Lichtenheld
Date:   Tue Jul 15 16:37:44 2025 +0200

     reliable: Review and fix gc_arena usage

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250715143750.9719-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32157.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


