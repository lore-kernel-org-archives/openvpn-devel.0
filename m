Date: Thu, 5 May 2022 12:18:11 +0200 (CEST)
Message-Id: <202205051018.245AIBoB006285@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220502154310.836947-1-arne@...1227...>
References: <20220502154310.836947-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement stateless HMAC-based
 sesssion-id three-way-handshake
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

I have not reviewied this in full depth, trusting Frank here.

I *have* tested this on the server side testbed with "plain", "tls-auth"
and "tls-crypt" instances - and besides the fact that tls-crypt breaks
the 2.3 client (no support ;-) ) it all works nicely.

All the comments and whitespace bits have been fixed-on-the-fly
as instructed.  I have also fixed the "Return *true* if this packet..."
comment before do_pre_decrypt_check() and rewrapped the very long
comment lines in mudp.c (why did uncrustify not find this?).

I have stared a bit at the code and I think I understand what the code
does, and it seems to make sense.  Plus, it has unit tests :-)

Your patch has been applied to the master branch.

commit b364711486dc6371ad2659a5aa190941136f4f04
Author: Arne Schwabe
Date:   Mon May 2 17:43:10 2022 +0200

     Implement stateless HMAC-based sesssion-id three-way-handshake

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220502154310.836947-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24262.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


