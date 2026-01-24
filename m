Date: Sat, 24 Jan 2026 14:34:44 +0100 (CET)
Message-Id: <202601241334.60ODYiN7043340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260122125829.108470-1-frank@...2641...>
References: <20260122125829.108470-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_ncp: Avoid conversion
 warning in replace_default_in_ncp_ciphers_option
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

Change makes sense, has an ACK from Arne (who authored most of this code),
and passes BB tests.  One #pragma pair gone, in it goes :-)

Your patch has been applied to the master branch.

commit b28321edfe65290fae6d09d931aa36187ad95e95
Author: Frank Lichtenheld
Date:   Thu Jan 22 13:58:28 2026 +0100

     ssl_ncp: Avoid conversion warning in replace_default_in_ncp_ciphers_option

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1452
     Message-Id: <20260122125829.108470-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35391.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


