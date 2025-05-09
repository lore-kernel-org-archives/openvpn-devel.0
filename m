Date: Fri, 9 May 2025 15:03:59 +0200 (CEST)
Message-Id: <202505091303.549D3xMm007113@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250508174624.7504-1-gert@...1296...>
References: <20250508174624.7504-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: Reorganize header and
 symbol tests
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

Build system changes only, no code changes.  BB and Arne agree that this
is fine :-)  (there are some build fails, but those look like unrelated
network hickups in the middle of a t_client run).

Grouping the tests sounds like a good speedup on platforms that do not
have something, like <unistd.h>...

Your patch has been applied to the master branch.

commit bf99815235004cdffef754d22904b0189bd8c3ae
Author: Frank Lichtenheld
Date:   Thu May 8 19:46:15 2025 +0200

     CMake: Reorganize header and symbol tests

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250508174624.7504-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31602.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


