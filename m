Date: Mon, 14 Sep 2020 11:13:32 +0200 (CEST)
Message-Id: <202009140913.08E9DWS6053838@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200914084444.96-1-lstipakov@...277...>
References: <20200914084444.96-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: better support for 32bit
 architecture
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

I won't claim to understand all the intricacies, but the change looks
like it would do what the text says - and you're the MSVC master anyway.

Your patch has been applied to the master and release/2.5 branch.

commit fb94fbc31f9d6e434af465bf8a345763f89fddc9 (master)
commit 2f0be578e6385941c8135acefd9ef99a6c23c973 (release/2.5)
Author: Lev Stipakov
Date:   Mon Sep 14 11:44:44 2020 +0300

     msvc: better support for 32bit architecture

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200914084444.96-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20990.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


