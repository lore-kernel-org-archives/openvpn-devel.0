Date: Wed, 12 Feb 2025 14:03:36 +0100 (CET)
Message-Id: <202502121303.51CD3aQW005421@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250212123820.19099-1-gert@...1296...>
References: <20250212123820.19099-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix oversight of link socket
 code change in Android code path
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

Another one of those that we should have seen... sorry for that.

(I have not tested this, but it's inside #ifdef TARGET_ANDROID and
looks like the correct adjustment, so if Arne says "this makes it work" 
it's good enough for me)

Your patch has been applied to the master branch.

commit 3ddfe26e491f9d74da54feb981116f7b8ef19a70
Author: Arne Schwabe
Date:   Wed Feb 12 13:38:20 2025 +0100

     Fix oversight of link socket code change in Android code path

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250212123820.19099-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30833.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


