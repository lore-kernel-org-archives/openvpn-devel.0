Date: Wed, 9 Nov 2022 13:52:11 +0100 (CET)
Message-Id: <202211091252.2A9CqBc7027434@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221109123501.1252554-1-arne@...1227...>
References: <20221109123501.1252554-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add algorithm and bits used in
 key_print2 method and refactor method
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

"Yes, this is much nicer" :-)

     Master Encrypt (cipher, AES-256-GCM, 256 bits): da62213e a3d13f7c ...
     Master Encrypt (hmac, [null-digest], 0 bits): 
     Master Decrypt (cipher, AES-256-GCM, 256 bits): 4aec936c 1eb1c231 ...
     Master Decrypt (hmac, [null-digest], 0 bits): 

Your patch has been applied to the master branch.

commit 4d8dfa84bd3b778c00560d2131d3b94b4cada3bc
Author: Arne Schwabe
Date:   Wed Nov 9 13:35:01 2022 +0100

     Add algorithm and bits used in key_print2 method and refactor method

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221109123501.1252554-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25495.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


