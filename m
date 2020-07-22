Date: Wed, 22 Jul 2020 09:41:47 +0200 (CEST)
Message-Id: <202007220741.06M7flGX006684@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200717134739.21168-7-arne@...1227...>
References: <20200717134739.21168-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid sending --cipher to
 clients not supporting NCP
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

Acked-by: Gert Doering <gert@...1296...>

Verify by staring at the testbed.  2.2/2.3 clients or 2.4 or master
with --ncp-disable won't get cipher pushed, the rest will.

Works!

Your patch has been applied to the master branch.

commit 4b59e2644a978074f0eed492d6541ba7b30b01a7
Author: Arne Schwabe
Date:   Fri Jul 17 15:47:37 2020 +0200

     Avoid sending --cipher to clients not supporting NCP

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200717134739.21168-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20437.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


