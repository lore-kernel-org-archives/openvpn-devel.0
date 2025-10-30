Date: Thu, 30 Oct 2025 22:01:12 +0100 (CET)
Message-Id: <202510302101.59UL1CCj025753@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030193834.1186-1-gert@...1296...>
References: <20251030193834.1186-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix warnings about conversion
 from int to unsigned char/uint8_t
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

Looks reasonable.  I do not have an ubuntu 25 system yet to test, but
on the older boxes this does not warn either way, and the casts are
safe.  BB is happy.

Your patch has been applied to the master branch.

commit e7df832354fd476defe6a0fb35ab1aa05314c5e3
Author: Arne Schwabe
Date:   Thu Oct 30 20:38:20 2025 +0100

     Fix warnings about conversion from int to unsigned char/uint8_t

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1328
     Message-Id: <20251030193834.1186-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34065.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


