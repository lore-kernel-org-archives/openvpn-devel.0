Date: Tue, 11 Aug 2020 22:55:56 +0200 (CEST)
Message-Id: <202008112055.07BKtuvm059556@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200811105541.2543-1-arne@...1227...>
References: <20200811105541.2543-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor/Reformat
 tls_pre_decrypt
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

Reviewed again (with and without "-w"), is really "just" moving
data packet handling into its own function and getting rid of
layers of indentation...

Subjected to client and server tests (which do excercise the
"success" case quite thoroughly, but not all possible error cases -
but the code in question hasn't really changed, just moved), passed 
both.

Your patch has been applied to the master branch.

commit a6a15f7030b25f374a527de57dba199dc64745a3
Author: Arne Schwabe
Date:   Tue Aug 11 12:55:41 2020 +0200

     Refactor/Reformat tls_pre_decrypt

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200811105541.2543-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20707.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


