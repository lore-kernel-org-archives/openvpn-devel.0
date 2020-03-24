Date: Tue, 24 Mar 2020 16:02:47 +0100 (CET)
Message-Id: <202003241502.02OF2l4a022117@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200309131728.380-9-simon@...2293...>
References: <20200309131728.380-9-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: Extend to support
 arbitrary HWID network adapters
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Looks reasonable.  Compile tested with MSVC.

(It looks a bit incomplete wrt "how to specify the component HWID now?"
but this is coming in the next patches, I think)

commit d263e4f300553ea77f1bf16538bcd0e81ed2e302
Author: Simon Rozman
Date:   Mon Mar 9 14:17:25 2020 +0100

     openvpnmsica: Extend to support arbitrary HWID network adapters

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200309131728.380-9-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19521.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


