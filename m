Date: Thu, 16 Apr 2020 10:16:20 +0200 (CEST)
Message-Id: <202004160816.03G8GKC6041301@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200415073017.22839-1-lstipakov@...277...>
References: <20200415073017.22839-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix illegal client float
 (CVE-2020-11810)
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

Your patch has been applied to the master and release/2.4 branch (bugfix).

I have amended the commit message to make it more clear what is the 
risk (DoS against another random user of the same server, but no traffic 
injection or stealing)

Code change is "obviously correct".  Have still given it a t_client
run for good measure :-)

commit 37bc691e7d26ea4eb61a8a434ebd7a9ae76225ab (master)
commit f7b318f811bb43c0d3aa7f337ec6242ed2c33881 (release/2.4)
Author: Lev Stipakov
Date:   Wed Apr 15 10:30:17 2020 +0300

     Fix illegal client float (CVE-2020-11810)

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200415073017.22839-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19720.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


