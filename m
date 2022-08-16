Date: Tue, 16 Aug 2022 08:20:47 +0200 (CEST)
Message-Id: <202208160620.27G6KlFp011610@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220814215303.305-1-lstipakov@...277...>
References: <20220814215303.305-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: properly handle device
 interface list
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Did a bit of "staring at the code", all looks quite reasonable.

My Ubuntu 18/mingw test rig exploded after commit 2e359a088226a (for
the "make dist" part, it requires libpcap-ng-dev, but apt refuses to
install that...) so I could not compile-test.

Commit message extended with "use gc_malloc()..."

Your patch has been applied to the master branch.

commit 5c4fa12b0be29dcb18edac62c8c29f91f4ff59b1
Author: Lev Stipakov
Date:   Sun Aug 14 23:53:03 2022 +0200

     tun: properly handle device interface list

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20220814215303.305-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24938.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


