Date: Fri, 25 Oct 2019 08:29:10 +0200 (CEST)
Message-Id: <201910250629.x9P6TAHA082435@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191024214832.22737-1-tincanteksup@...277...>
References: <20191024214832.22737-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore --pull-filter for --mode
 server
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
To: Richard Bonhomme <tincanteksup@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  (One could argue on whether this is the "most correct" patch,
but while we do so, it's very non-intrusive and fixes a real world problem 
for some users).

Your patch has been applied to the master and release/2.4 branch.

commit bb1ea491cd16d11b448342e8287beacae619f980 (master)
commit 6a90f36f69e1f41d6c61ab7e566e7e7e0ba7d71a (release/2.4)
Author: Richard Bonhomme
Date:   Thu Oct 24 22:48:32 2019 +0100

     Ignore --pull-filter for --mode server

     Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191024214832.22737-1-tincanteksup@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18964.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


