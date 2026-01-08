Date: Thu, 8 Jan 2026 11:04:12 +0100 (CET)
Message-Id: <202601081004.608A4CGd092221@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260108074915.9417-1-gert@...1296...>
References: <20260108074915.9417-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update Copyright statements to
 2026
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

Verified that the patch indeed only changes Lines with "Copyright" in
them ("git show -I Copyright") and those are all prefixed with "#" or "*"
(shell/C files).  Easy enough.

clang-format complains about tapctl.c and openvpnmsica.c being non-compliant
(function definition wrapping) and I tend to agree with it - but that's not
this patch's fault, but we might fix this in a separate patch.  Not sure why
it wasn't caught by the Big Reformatting, maybe due to the __stdcall stuff
and newer clang-format now catching it...

Your patch has been applied to the master branch.

commit f94a3ad2bafedf38076989a28846728536a02b8e
Author: Frank Lichtenheld
Date:   Thu Jan 8 08:49:06 2026 +0100

     Update Copyright statements to 2026

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1456
     Message-Id: <20260108074915.9417-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59280815/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


