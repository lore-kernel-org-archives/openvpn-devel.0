Date: Thu, 19 Jan 2023 08:37:36 +0100 (CET)
Message-Id: <202301190737.30J7banu002664@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230118074633.27586-1-gert@...1296...>
References: <20230118074633.27586-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repair special-casing of EEXIST
 for Linux/SITNL route install
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

For good measure, ran through all the client & server side tests on
Linux (other platforms not affected).  Since this is where I developed
and tested the patch, no surprises :-)

Thanks to having RTA_SUCCESS/RTA_EEXIST now, doing a double-review
again ("did I get all the numbers right?") was also very straightforward.

Patch has been applied to the master and release/2.6 branch.

commit adc54f483b210484ff1488e01c8aee1b2b0ea477 (master)
commit eb85961e72c927256ce9267a43f3519d3ab4edcb (release/2.6)
Author: Gert Doering
Date:   Wed Jan 18 08:46:33 2023 +0100

     Repair special-casing of EEXIST for Linux/SITNL route install

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230118074633.27586-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26046.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


