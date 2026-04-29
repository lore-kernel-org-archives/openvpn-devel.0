Date: Wed, 29 Apr 2026 15:18:12 +0200 (CEST)
Message-Id: <202604291318.63TDICKM032749@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260429093938.23601-1-gert@...1296...>
References: <20260429093938.23601-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Add caching for vcpkg
 builds
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

Avoiding unneccessary re-builds is a very welcome addition - it speeds
up our test runs, and it avoids burning more energy than needed.

Yuriy and GHA agree that "this works".

Your patch has been applied to the master and release/2.7 branch.

commit 157087736427059316ecff7dd21e16b54077221a (master)
commit 064f912b4dfa18ea775e33bcf817c75b3c847e54 (release/2.7)
Author: Frank Lichtenheld
Date:   Wed Apr 29 11:39:33 2026 +0200

     GHA: Add caching for vcpkg builds

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1642
     Message-Id: <20260429093938.23601-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36775.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


