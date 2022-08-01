Date: Mon, 1 Aug 2022 10:22:36 +0200 (CEST)
Message-Id: <202208010822.2718Maod045623@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220729123748.3267207-1-arne@...1227...>
References: <20220729123748.3267207-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract check_session_cipher
 into standalone function
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

This is technically the same as 1/5 in v3, except s/update/check/, and
*that* one is is exactly the same patch as "3/6" in the earlier patch series
(20220621161649.2872985-3-arne@...1227...) which had an ACK from Frank
-> applying that ACK here, adding my own.

Stare-at-code and --color-moved=zebra confirms "trivial code move"

Passes t_client tests.

Your patch has been applied to the master branch.

commit dd1837ca549e0494164fb4633d61a317529778b4
Author: Arne Schwabe
Date:   Fri Jul 29 14:37:48 2022 +0200

     Extract check_session_cipher into standalone function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220729123748.3267207-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24766.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


