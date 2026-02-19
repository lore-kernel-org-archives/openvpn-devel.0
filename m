Date: Thu, 19 Feb 2026 10:18:49 +0100 (CET)
Message-Id: <202602190918.61J9InJI029898@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260218214437.26912-1-gert@...1296...>
References: <20260218214437.26912-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ntlm: fix discards 'const'
 qualifier from pointer target type
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
To: Rudi Heitbaum <rudi@...2993...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

thanks for this.  So *this* patch only goes to release/2.6 (because the
NTLM code in release/2.7 is different, and there is no more NTLM code
in master)...

Your patch has been applied to the release/2.6 branch.

commit b5087dcf3fe3d4aa226dd3e727991bfe8a3a5efb
Author: Rudi Heitbaum
Date:   Wed Feb 18 22:44:31 2026 +0100

     ntlm: fix discards 'const' qualifier from pointer target type

     Signed-off-by: Rudi Heitbaum <rudi@...2993...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1546
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20260218214437.26912-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35723.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


