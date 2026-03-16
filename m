Date: Mon, 16 Mar 2026 14:52:08 +0100 (CET)
Message-Id: <202603161352.62GDq8Ht031528@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260316121148.25189-1-frank@...2641...>
References: <20260316121148.25189-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unnecessary OpenSSL init
 and cleanup commands in unit tests
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

This is quite reasonable, making sure the unit tests follow the same 
code paths as "the main application".  As such, I think it needs to go
into 2.7 as well (done).

Lightly tested on an OpenSSL build.

Your patch has been applied to the master and release/2.7 branch.

commit 369c7510788d44747b75fceb61edbf30b87638f0 (master)
commit 0bb9a2502124d97c937a910dc95154ab2db54036 ( release/2.7)
Author: Arne Schwabe
Date:   Mon Mar 16 13:11:48 2026 +0100

     Remove unnecessary OpenSSL init and cleanup commands in unit tests

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1568
     Message-Id: <20260316121148.25189-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36153.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


