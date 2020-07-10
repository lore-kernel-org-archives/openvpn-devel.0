Date: Fri, 10 Jul 2020 17:22:49 +0200 (CEST)
Message-Id: <202007101522.06AFMnBQ043401@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200709101603.11941-4-arne@...1227...>
References: <20200709101603.11941-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move protocol option
 negotiation from push_prepare to new function
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

Your patch has been applied to the master branch.

I have stared at the code, Antonio has stared at the code, and
it makes sense.  The test server says "but it breaks async auth",
so I've amended the commit message with a big fat NOTE that says 
"this breaks async auth, but we'll fix it next commit".

I have not tested async-push (it might be broken as well), but
we'll see to that next week when Lev is back.

commit 6344ea1218583d84baa986e6747e0c023d747245
Author: Arne Schwabe
Date:   Thu Jul 9 12:15:59 2020 +0200

     Move protocol option negotiation from push_prepare to new function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200709101603.11941-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20255.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


