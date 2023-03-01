Date: Wed, 1 Mar 2023 14:30:21 +0100 (CET)
Message-Id: <202303011330.321DULsv073932@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230214134323.1033590-1-arne@...1227...>
References: <20230214134323.1033590-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use proper print format/casting
 when converting msg_channel handle
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

I have not tested this beyond "compile on mingw", which didn't warn
before the patch either.  But it looks innocent enough, and if Lev
confirms it actually works, good enough.

Your patch has been applied to the master and release/2.6 branch.

commit 9c52e0c610ef1229561c2d038ca41fe2cbefe8da (master)
commit 27dac5061cfeff75470dca11e07dadb1fb0ad180 (release/2.6)
Author: Arne Schwabe
Date:   Tue Feb 14 14:43:23 2023 +0100

     Use proper print format/casting when converting msg_channel handle

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230214134323.1033590-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26255.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


