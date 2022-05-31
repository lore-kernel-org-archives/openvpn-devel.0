Date: Tue, 31 May 2022 13:48:56 +0200 (CEST)
Message-Id: <202205311148.24VBmuK9040353@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220530224149.201883-1-arne@...1227...>
References: <20220530224149.201883-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove useless empty line from
 CR_RESPONSE message
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

"Obviously correct".  Didn't want to go in (the push.c hunk has an
ENABLE_PLUGIN in the context, which is not in master), but that was
easy to fix.

Lightly "make check" tested.

Your patch has been applied to the master and release/2.5 branch.

commit 0dbcaba4f301c21e68a5cd032a4b56eb75c17c37 (master)
commit 400da02714abd36218954c988a2ef81dade0b59d (release/2.5)
Author: Arne Schwabe
Date:   Tue May 31 00:41:49 2022 +0200

     Remove useless empty line from CR_RESPONSE message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220530224149.201883-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24447.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


