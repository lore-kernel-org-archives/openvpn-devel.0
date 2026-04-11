Date: Sat, 11 Apr 2026 16:41:16 +0200 (CEST)
Message-Id: <202604111441.63BEfG1Z052859@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260411090625.18343-1-gert@...1296...>
References: <20260411090625.18343-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Try to emphasise the transition
 from old ovpn-dco to new ovpn module
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

Mostly this is textual updates which all make sense.  There is one actual
code change in DCO module probing, and if Antonio says this is fine, it
better should be :-) - I have not tested this beyond a simple compile.

Your patch has been applied to the master and release/2.7 branch
(primarily documentation improvemnets).

commit b4cb98b5bb51a3edd19aadee1c422e72a63a2326 (master)
commit a4936d31633d8259d9f96165511cc2acd78766f5 (release/2.7)
Author: Arne Schwabe
Date:   Sat Apr 11 11:06:18 2026 +0200

     Try to emphasise the transition from old ovpn-dco to new ovpn module

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1550
     Message-Id: <20260411090625.18343-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36573.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


