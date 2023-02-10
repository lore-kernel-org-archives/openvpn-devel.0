Date: Fri, 10 Feb 2023 21:47:49 +0100 (CET)
Message-Id: <202302102047.31AKlnRk032676@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230201141518.119157-1-gert@...1296...>
References: <20230201141518.119157-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Get rid of unused 'bool
 tuntap_buffer' arguments.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This time, it actually compiles on Linux *and* Windows... (GH says so :-) ).

Patch has been applied to the master and release/2.6 branch.

commit 092ceadb762a42a50191e38bd7cf0fe9f6528a59 (master)
commit eca101ac4426442c1ad17e6a706d84c7960a8262 (release/2.6)
Author: Gert Doering
Date:   Wed Feb 1 14:15:18 2023 +0000

     Get rid of unused 'bool tuntap_buffer' arguments.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230130161730.110021-1-gert@...1296...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230201141518.119157-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26122.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


