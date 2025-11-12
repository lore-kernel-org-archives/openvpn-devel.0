Date: Wed, 12 Nov 2025 16:33:01 +0100 (CET)
Message-Id: <202511121533.5ACFX15d052974@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251112141335.17417-1-gert@...1296...>
References: <20251112141335.17417-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix construction of invalid
 pointer in tls_pre_decrypt
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

Trivially-correct avoidance of the invalid-index pointer read... and 
quite likely this is what the compiler does as well "this is only needed
after the if(), so let's do that one first", or suchabouts.  Where this
is now, we know i is TM_ACTIVE (0) or TM_UNTRUSTED (1), and so ->session[i]
is valid.

Tested the master patch on the t_server testbed, 2.6 and 2.5 just on the
clients (which is arguably not excercising this code very heavily).

Your patch has been applied to the master, release/2.6 and release/2.5 branch.

Since this is arguably a bug, but has been shown to have no adverse effects,
and everything older has been out of support for a long time, I decided to
be lazy and not backport to 2.4, 2.3, 2.2 and 2.1...

commit 5cdf3f9724c89b278c88fd408714a8d2c1f4d1a1 (master)
commit 4e31670b1e1215130ffaec0f6769e084169da0f1 (release/2.6)
commit 03385f89a1cd95f12bc8ff92b76c209d8b11ef83 (release/2.5)
Author: Arne Schwabe
Date:   Wed Nov 12 15:13:28 2025 +0100

     Fix construction of invalid pointer in tls_pre_decrypt

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1373
     Message-Id: <20251112141335.17417-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


