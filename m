Date: Tue, 29 Sep 2020 11:26:24 +0200 (CEST)
Message-Id: <202009290926.08T9QOxW008500@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200922100021.20329-1-lstipakov@...277...>
References: <20200922100021.20329-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Alias ADAPTER_DOMAIN_SUFFIX to
 DOMAIN
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

Acked-by: Gert Doering <gert@...1296...>

I think this is reasonable for AS compatibility, which is 
desirable.  (Otherwise, I do have some reservation on
"why do we need to work around uncoordinated actions on the 
v3/AS side in the v2 source?")

I have not tested this besides "stare at source" and "compile
with MinGW", but it looks trivially correct enough.

Your patch has been applied to the master and release/2.5 branch.

commit d6720203fa9ba446497798a284c17093b92de1dc (master)
commit 2062876f3a4c87a552ce5d7cb68113e349a5c872 (release/2.5)
Author: Lev Stipakov
Date:   Tue Sep 22 13:00:21 2020 +0300

     Alias ADAPTER_DOMAIN_SUFFIX to DOMAIN

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200922100021.20329-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21107.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


