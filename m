Date: Wed, 25 Nov 2020 16:14:44 +0100 (CET)
Message-Id: <202011251514.0APFEi8h053293@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023120259.29783-3-arne@...1227...>
References: <20201023120259.29783-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve keys out of sync message
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

I have no test bed that will trigger this, but the change is
not hard to understand (extend print_key_id() with a 
"auth=make_string(ks->authenticated)", append the result to
the "TLS Error:" message.

All other users of print_key_id() are all "just debug output",
so the new format will not confuse anything.

Compile tested on the client.

As with 2/8, uncrustify does not like the indenting of the
new switch/case block.  Adjusted.

Your patch has been applied to the master branch.

commit f1f0f074bf6e7b91673bfa8cb08b3be44ebda76b
Author: Arne Schwabe
Date:   Fri Oct 23 14:02:55 2020 +0200

     Improve keys out of sync message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023120259.29783-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21226.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


