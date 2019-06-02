Date: Sun, 2 Jun 2019 21:14:18 +0200 (CEST)
Message-Id: <201906021914.x52JEIpe044813@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-8-a@...2181...>
References: <20181219050118.6568-8-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: travis.yml: add test for
 iproute2 net implementation
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

Your patch has been applied to the master branch.

Sufficiently trivial and independent of piece 4+5+6 that I applied
this in between.  Failed, of course, because the context of .travis.yml
got modified in between... we really need to focus our development on
"one large thing at a time"...

commit d595562d946aec4811ac0deffff0770fb9c32a21
Author: Antonio Quartulli
Date:   Wed Dec 19 15:01:18 2018 +1000

     travis.yml: add test for iproute2 net implementation

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20181219050118.6568-8-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18032.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


