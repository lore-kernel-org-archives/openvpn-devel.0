Date: Tue, 2 Sep 2025 20:22:11 +0200 (CEST)
Message-Id: <202509021822.582IMB6E074121@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902144657.11854-1-gert@...1296...>
References: <20250902144657.11854-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Introduce
 atoi_constrained and review usages of atoi_warn
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

Stared a bit at the code, makes sense.  ACK from Arne, good :-)

Also, threw this into the t_client/t_server machinery - which will not
test every single parameter (hah) but might trigger surprises for the
most common arguments.  Everything still works :-)

As with most other patches posted today, mail-archive.org claims the
mails do not exist :-( - so, linking to the sourceforge.net archive,
again.

Your patch has been applied to the master branch.

commit a01c909c3be5c06c9be06540f5c3aa04b449e9c9
Author: Frank Lichtenheld
Date:   Tue Sep 2 16:46:50 2025 +0200

     options: Introduce atoi_constrained and review usages of atoi_warn

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250902144657.11854-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59228172/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


