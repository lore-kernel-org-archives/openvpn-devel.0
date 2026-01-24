Date: Sat, 24 Jan 2026 16:49:45 +0100 (CET)
Message-Id: <202601241549.60OFnjTt045272@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260121121830.27244-1-frank@...2641...>
References: <20260121121830.27244-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Silence compiler truncation
 warning by checking snprintf return value
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

Compilers... but yeah, the change won't do harm, and might catch something
unexpected with a proper error message.  Doesn't change the actual code
flow, so not tested beyond "is the compiler fine with it".

Your patch has been applied to the master branch.

commit 1fe958183fa5877d9e00cbfbe0d29477adff7187
Author: Arne Schwabe
Date:   Wed Jan 21 13:18:30 2026 +0100

     Silence compiler truncation warning by checking snprintf return value

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1272
     Message-Id: <20260121121830.27244-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35367.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


