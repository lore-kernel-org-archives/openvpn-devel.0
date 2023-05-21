Date: Sun, 21 May 2023 17:50:49 +0200 (CEST)
Message-Id: <202305211550.34LFon3T065194@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230519082548.1714-1-lstipakov@...277...>
References: <20230519082548.1714-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: generate
 driver-specific adapter names
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

Your patch has been applied to the master and release/2.6 branch.

I have not tested it beyond "does it compile on MinGW and GHA" - I intended
to create a few interfaces across the landscape (Win7, Win10, Win11/ARM)
but things got in the way.  Will do later.

Staring at the code for a bit and things look all reasonable - memory
handling, strdup()/free(), etc.

commit 4323b8277814495f5a9a24d3225679c6e7a971a4 (master)
commit 868286fa756f7faf768bdd7e18a44e6a92e47066 (release/2.6)
Author: Lev Stipakov
Date:   Fri May 19 11:25:48 2023 +0300

     tapctl: generate driver-specific adapter names

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230519082548.1714-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26712.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


