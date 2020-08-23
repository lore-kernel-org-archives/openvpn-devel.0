Date: Sun, 23 Aug 2020 21:04:21 +0200 (CEST)
Message-Id: <202008231904.07NJ4Ld8026305@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200814080619.2108-1-arne@...1227...>
References: <20200814080619.2108-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix client's poor man NCP
 fallback
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

I have not specifically tested the scenarios that this is fixing (due
to time constraints and really poor Internet $here).  I totally trust 
Steffan's review and Richard's testing, though, to fix the problem
observed.

I have run it through t_client tests (against git master servers 
about ~1 year old) and through the t_server tests (against 2.2/2.3/
2.3-small/2.4 and roughly 4-weeks-old master clients) and these all
pass.  So it's definitely not breaking anything I'm currently 
testing :-)

I have worked in Richard's most recent suggestions for the commit
message and reworded it a bit more.  If it does not make *any* sense
anymore, it's all my fault.

Your patch has been applied to the master and release/2.5 branch.

commit 2ab0a92442dce1d82fcb9e2b305313ef668d40bf (master)
commit a61883406f7caf39aab274979bb2d43d85804df8 (release/2.5)
Author: Arne Schwabe
Date:   Fri Aug 14 10:06:19 2020 +0200

     Fix client's poor man NCP fallback

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Message-Id: <20200814080619.2108-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20734.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


