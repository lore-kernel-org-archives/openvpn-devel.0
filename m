Date: Sun, 9 Jun 2019 11:03:56 +0200 (CEST)
Message-Id: <201906090903.x5993ue6020421@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190608075622.11589-1-gert@...1296...>
References: <20190608075622.11589-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Copy one byte less in
 strncpynt()
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch.

(I have left the "maxlen-1" as it was, as uncrustify says this is
fine and I personally find "maxlen - 1" less readable here.  I did fix
the tab-vs-spaces violation)

commit bebd25a0e3a2aba0b1f98463a87b24db6c419a66
Author: Gert Doering
Date:   Sat Jun 8 09:56:22 2019 +0200

     Copy one byte less in strncpynt()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20190608075622.11589-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18502.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


