Date: Mon, 20 Nov 2023 15:37:15 +0100 (CET)
Message-Id: <202311201437.3AKEbFXt022331@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <8237adde-2523-9e48-5cd4-070463887dc1@...277...>
References: <8237adde-2523-9e48-5cd4-070463887dc1@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: protocol_dump: tls-crypt support
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
To: reynir@...2756...
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.6 branch 
("printing garbage" is arguably a bug that needs fixing).

I have taken parts of the "mail mail" into the commit message, and
added the "signed-off-by:" that the OpenVPN project wants.

I haven't actually tested it beyond "does it compile" - it looks good,
and Arne is the current authority on tls-crypt anyway.

commit 227799b8345128dd3adf2029323457804209fe93 (master)
commit 0a39d1c1e2582330db09052bcf0e32bbf5bafde2 (release/2.6)
Author: Reynir Björnsson
Date:   Thu Oct 26 16:55:32 2023 +0200

     protocol_dump: tls-crypt support

     Signed-off-by: Reynir Björnsson <reynir@...2756...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <8237adde-2523-9e48-5cd4-070463887dc1@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27310.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


