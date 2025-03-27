Date: Thu, 27 Mar 2025 13:17:41 +0100 (CET)
Message-Id: <202503271217.52RCHfbC026509@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250327113356.11233-1-gert@...1296...>
References: <20250327113356.11233-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix compatibility with mbedTLS
 2.28.10+ and 3.6.3+
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

I have not tested this further - the buildbots have, and both the
release notes and our mbedTLS expert agree on the fix :-)

Tested compilation for the 2.6 backport via GHA.

Your patch has been applied to the master and release/2.6 branch
(long-term compat).

commit 4897c522948c8cdb82c0325ee08f6907cfc16f57 (master)
commit 4913628022f5d9d33bac656082a2ec279d8d1222 (release/2.6)
Author: Frank Lichtenheld
Date:   Thu Mar 27 12:33:50 2025 +0100

     Fix compatibility with mbedTLS 2.28.10+ and 3.6.3+

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250327113356.11233-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31262.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


