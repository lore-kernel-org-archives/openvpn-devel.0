Date: Wed, 6 Dec 2023 13:15:08 +0100 (CET)
Message-Id: <202312061215.3B6CF8oU085373@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231122190057.120384-1-dazo+openvpn@...2108...>
References: <20231122190057.120384-1-dazo+openvpn@...2108...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove superfluous
 x509_write_pem()
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Does what it says on the lid.  Test compiled on FreeBSD, but that
brought no surprises as "git grep" confirms this function is no longer
called.

I could have squashed this with the previous patch, but since it hit
the list as two patches, I decided to keep the direct references intact
instead.

Your patch has been applied to the master and release/2.6 branch.

commit f015643fe23d7847ad45b7763f31bfc6baed2159 (master)
commit 5552391a362e16f02e41b056ea18b89b2e49a757 (release/2.6)
Author: David Sommerseth
Date:   Wed Nov 22 20:00:57 2023 +0100

     Remove superfluous x509_write_pem()

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231122190057.120384-1-dazo+openvpn@...2108...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27561.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


