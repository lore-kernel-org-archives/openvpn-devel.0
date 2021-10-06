Date: Wed, 6 Oct 2021 12:00:24 +0200 (CEST)
Message-Id: <202110061000.196A0OMt045458@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211005122736.4060-1-a@...2181...>
References: <20211005122736.4060-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: remove useless
 -Wno-* from default CFLAGS
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Because it makes sense"

Your patch has been applied to the master and release/2.5 branch
(this will not directly effect actual code generation, but if we can see 
and fix a warning in 2.5 that way, all the better).

commit 01ce6ca39d1f4bf45dcd49baede0094c4c990d3b (master)
commit 64c96c003264fd69327bb54f7c28bb41b13d0ab7 (release/2.5)
Author: Antonio Quartulli
Date:   Tue Oct 5 14:27:36 2021 +0200

     configure: remove useless -Wno-* from default CFLAGS

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211005122736.4060-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22917.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


