Date: Tue, 24 Nov 2020 19:31:29 +0100 (CET)
Message-Id: <202011241831.0AOIVTR4020772@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201029213259.1636-1-davids@...515...>
References: <20201029213259.1636-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: build: Fix missing install of
 man page in certain environments
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

I have not tested it further, but the explanation + test report make
this "good enough"

Your patch has been applied to the master and release/2.5 branch.

commit fc25ca3a7cf720fbb53889fdba6ac0154c7c9c1a (master)
commit bbac1542cfb4a9d3033999b26813f0dd0618c3f0 (release/2.5)
Author: David Sommerseth
Date:   Thu Oct 29 22:32:59 2020 +0100

     build: Fix missing install of man page in certain environments

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201029213259.1636-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21236.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


