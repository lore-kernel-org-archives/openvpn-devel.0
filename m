Date: Sun, 19 Oct 2025 19:07:30 +0200 (CEST)
Message-Id: <202510191707.59JH7UAr079564@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251019170249.30942-1-gert@...1296...>
References: <20251019170249.30942-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-freebsd: store peer stats
 directly in c2
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested this, and it indeed does the right thing - the code in question
is only called when a client exit is notified from the kernel (ping
timeout, for example) and we do receive the proper value and put it
into the correct place now :-)

(I have a patch in my FreeBSD-testing tree that logs all these counters)

Your patch has been applied to the master branch.

commit bf01a965dfbfc2651eaf3dbe4d37da74f3071628
Author: Ralf Lici
Date:   Sun Oct 19 19:02:42 2025 +0200

     dco-freebsd: store peer stats directly in c2

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1275
     Message-Id: <20251019170249.30942-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33791.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


