Date: Tue, 10 Feb 2026 16:31:24 +0100 (CET)
Message-Id: <202602101531.61AFVOsO031588@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260210151639.913-1-gert@...1296...>
References: <20260210151639.913-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update the clang-format
 reference version to 21.1.8
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

Indeed, this is one of the reformatting issues that occasionally bubble
up and go away again - good to hear it's been fixed for good in 21.1.8,
then.

Codewise this is all "wrap the function definition to have the return
type on the preceding line" stuff - which seemingly failed for windows
stuff, either "UINT" or "__stdcall", whatever upset clang-format here -
but all very trivial "replace a space with a newline" changes.

Your patch has been applied to the master branch.

commit 44a5b330210ef1f1fd371a178bb0b1aefdab8088
Author: Frank Lichtenheld
Date:   Tue Feb 10 16:16:31 2026 +0100

     Update the clang-format reference version to 21.1.8

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1514
     Message-Id: <20260210151639.913-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35563.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


