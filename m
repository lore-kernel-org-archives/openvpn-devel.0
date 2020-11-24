Date: Tue, 24 Nov 2020 21:01:28 +0100 (CET)
Message-Id: <202011242001.0AOK1SHf024166@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200830140736.16571-3-arne@...1227...>
References: <20200830140736.16571-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Also announce IV_CIPHERS as
 client in OpenVPN 2.4
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

Acked-by: Gert Doering <gert@...1296...>

This is useful functionality for better 2.4 client <=> 2.5/master 
server NCP interoperability.  It is only bringing in the client
side, which is fairly nonintrusive.

Tested with my t_client setup (client-side only) and with a few
manual calls to excercise the translation code (works).  What 
does not work is case-insensitive cipher name specifications -
I thought "Bf-cbC" should work, but 2.6 doesn't do this either
(so, no idea where I got that idea from).

Looking at the code, I do wonder why we send IV_NCP=2 and IV_CIPHERS
server to client, when we do not have anything on the client side
that would care about these bits...  but this is nothing this 
patch introduces.

Your patch has been applied to the release/2.4 branch.

commit f8c3e0aef2f6e03a0a5eafd81644c4079796649d
Author: Arne Schwabe
Date:   Sun Aug 30 16:07:36 2020 +0200

     Also announce IV_CIPHERS as client in OpenVPN 2.4

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200830140736.16571-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20844.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


