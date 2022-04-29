Date: Fri, 29 Apr 2022 15:21:31 +0200 (CEST)
Message-Id: <202204291321.23TDLVDA070588@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220427223419.241904-1-arne@...1227...>
References: <20220427223419.241904-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement constructing a
 control channel reset client as standalone function
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

Stared at the code for a bit, seems to make sense and the unit test
finds it a valid packet (mbedTLS and OpenSSL).

v2 also adds uncrustify fixes to test_pkt.c, so the tree is clean
wrt uncrustify 0.72 now again.  Great!  (Even though the array indent
does not look nice yet this way)

Fixed the 3 typos Frank pointed out plus the "carefully only as" 
comment text that was discussed on IRC (for v1 already).

Your patch has been applied to the master branch.

commit 870af5f54967821c72074a7c5c60e10a4561d95e
Author: Arne Schwabe
Date:   Thu Apr 28 00:34:18 2022 +0200

     Implement constructing a control channel reset client as standalone function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220427223419.241904-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24240.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


