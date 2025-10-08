Date: Wed, 8 Oct 2025 15:40:32 +0200 (CEST)
Message-Id: <202510081340.598DeWDw088357@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008133338.23652-1-gert@...1296...>
References: <20251008133338.23652-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_options_parse: Do not use
 uintmax_t instead of LargestIntegralType
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

Explanation makes sense, code change appeases the loud complaints from
OpenBSD BB with -Werror.  In it goes :-)

Your patch has been applied to the master branch.

commit 5b8e0563f950aa5d246f32785afffd8824d9f9ab
Author: Frank Lichtenheld
Date:   Wed Oct 8 15:33:31 2025 +0200

     test_options_parse: Do not use uintmax_t instead of LargestIntegralType

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1256
     Message-Id: <20251008133338.23652-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243971/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


