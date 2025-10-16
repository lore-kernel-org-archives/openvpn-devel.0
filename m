Date: Thu, 16 Oct 2025 13:12:54 +0200 (CEST)
Message-Id: <202510161112.59GBCsad029068@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251016101722.2979-1-gert@...1296...>
References: <20251016101722.2979-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Wrap winsock functions
 to avoid common conversion warnings
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

This is not the first function we wrap in openvpn_...(), and it's not
truly making our code more easy to understand at first - but it saves
needless casts all over the place, which *does* make it better.

Stared at the code, ran a full client/server test run on Linux
(ran it together with the two following socks/proxy patches, excercising
all the socket and the proxy code), works.

Test built on mingw "no errors".

Your patch has been applied to the master branch.

commit 42459e22c9ccf3488609338c9e4e4a9bd845e602
Author: Frank Lichtenheld
Date:   Thu Oct 16 12:17:16 2025 +0200

     socket: Wrap winsock functions to avoid common conversion warnings

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1277
     Message-Id: <20251016101722.2979-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59247452/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


