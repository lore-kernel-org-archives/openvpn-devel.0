Date: Mon, 9 Jan 2023 12:41:12 +0100 (CET)
Message-Id: <202301091141.309BfCeH017773@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230109113046.1678-1-lstipakov@...277...>
References: <20230109113046.1678-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: move
 print_windows_driver() out of tun.h
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

Thanks.  Compile-tested on MinGW, it compiles and the warnings are gone.

Your patch has been applied to the master and release/2.6 branch.

commit a0eb1f764df39d9447b666e5a2cbd3aa01b41983 (master)
commit 9dd0bfb5983fdfbbb9e1fe2195642fbc4cc5f200 (release/2.6)
Author: Lev Stipakov
Date:   Mon Jan 9 13:30:46 2023 +0200

     tun: move print_windows_driver() out of tun.h

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230109113046.1678-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25923.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


