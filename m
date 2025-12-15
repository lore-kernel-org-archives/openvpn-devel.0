Date: Mon, 15 Dec 2025 16:47:17 +0100 (CET)
Message-Id: <202512151547.5BFFlHCu059478@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251215145840.18310-1-gert@...1296...>
References: <20251215145840.18310-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi: Fix various conversion
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

This had an ACK from Arne quite a long time ago (on v4) - v9 is basically
the same patch, just rebased ever so often.  It couldn't go in yet because
1311+1312 were missing.

Aaand, another #pragma pair gone \o/

Your patch has been applied to the master branch.

commit 5e5ead5ba019fc2a8266f77a7d840b30fd545198
Author: Frank Lichtenheld
Date:   Mon Dec 15 15:58:35 2025 +0100

     multi: Fix various conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1313
     Message-Id: <20251215145840.18310-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35073.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


