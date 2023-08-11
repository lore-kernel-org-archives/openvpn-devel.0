Date: Fri, 11 Aug 2023 18:04:05 +0200 (CEST)
Message-Id: <202308111604.37BG45gs088092@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230128215901.2207208-2-selva.nair@...277...>
References: <20230128215901.2207208-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: signal_reset(): combine check
 and reset operations
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Has taken us long enough...

Tested in the server threadmill (Linux), and on buildbot/GHA (all
the OSes).  No explosions.

Also, stared a bit at the code, if Frank has overlooked anything,
just for completeness - haven't found anything :-)

Your patch has been applied to the master branch.

commit a854a7f30c129049ae55b51c22208fad97e80250
Author: Selva Nair
Date:   Sat Jan 28 16:59:01 2023 -0500

     signal_reset(): combine check and reset operations

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230128215901.2207208-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26088.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


