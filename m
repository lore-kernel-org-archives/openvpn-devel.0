Date: Tue, 21 Nov 2023 12:01:01 +0100 (CET)
Message-Id: <202311211101.3ALB118J065891@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231121104037.15307-1-frank@...2641...>
References: <20231121104037.15307-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused function
 prototype crypto_adjust_frame_parameters
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

This was an easy one.  Quick local review and test compile, and ship it :-)

Your patch has been applied to the master and release/2.6 branch
(because it really is no actual *code* change at all, and keeping changes
between branches small is desirable).

commit 66f109117649237947e3e5cd33a36f81bde71a2b (master)
commit d25b408db680be0ffc357126cc421231b880f18b (release/2.6)
Author: Arne Schwabe
Date:   Tue Nov 21 11:40:37 2023 +0100

     Remove unused function prototype crypto_adjust_frame_parameters

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231121104037.15307-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27524.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


