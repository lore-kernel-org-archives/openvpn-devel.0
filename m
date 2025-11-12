Date: Wed, 12 Nov 2025 14:38:37 +0100 (CET)
Message-Id: <202511121338.5ACDcbF3041892@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251111155239.31747-1-gert@...1296...>
References: <20251111155239.31747-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl: Change tls_send_payload
 size argument to size_t
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

"Because it makes sense" :-) - stared at the code, +2 from Arne, BB all green.

Your patch has been applied to the master branch.

commit 0da6116c0c8fccfa12369139ebf9357d113debba
Author: Frank Lichtenheld
Date:   Tue Nov 11 16:52:31 2025 +0100

     ssl: Change tls_send_payload size argument to size_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1355
     Message-Id: <20251111155239.31747-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34320.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


