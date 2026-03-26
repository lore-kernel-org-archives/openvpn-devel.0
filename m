Date: Thu, 26 Mar 2026 15:18:47 +0100 (CET)
Message-Id: <202603261418.62QEIlP9044696@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260326110658.25741-1-gert@...1296...>
References: <20260326110658.25741-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use const specifices in
 extract_x509_field_ssl
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

Makes sense, is straightforward enough, and for long-term compat, needs
to be in master + 2.7

Your patch has been applied to the master and release/2.7 branch.

commit 3316a18ebe6669d5e31b17ab0356a533b846d1bc (master)
commit 82f676574dce2f391d2cb7332068f0fc6dca5387 (release/2.7)
Author: Arne Schwabe
Date:   Thu Mar 26 12:06:52 2026 +0100

     Use const specifices in extract_x509_field_ssl

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1588
     Message-Id: <20260326110658.25741-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36291.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


