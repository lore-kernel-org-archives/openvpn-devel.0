Date: Mon, 19 Dec 2022 18:54:32 +0100 (CET)
Message-Id: <202212191754.2BJHsWsN004981@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221219140405.1221341-1-selva.nair@...277...>
References: <20221219140405.1221341-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not include auth-token in
 pulled option digest
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

Acked-by: Gert Doering <gert@...1296...>

(v2 is sufficiently different from v1 that I'm not taking Arne's ACK
but adding my own)

Only very lightly client-side tested, not doing actual SIGUSR1 restarts
with --persist-tun - but I'm fairly sure that this does what it attempts
to do, as it just extends the existing exception.

Your patch has been applied to the master, release/2.6 and release/2.5
branch (bugfix, same code, auth-token + auth-token-user both exist in 2.5).

commit f778f4f88e56851c0a68205e95110c021f3032b3
commit f922298ca5784577a1309334dafeb16f738ae46a (release/2.6)
commit 1d81df042eae416a4e83e6a433ae2b937c5a10a4 (release/2.5)
Author: Selva Nair
Date:   Mon Dec 19 09:04:05 2022 -0500

     Do not include auth-token in pulled option digest

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221219140405.1221341-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25768.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


