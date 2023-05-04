Date: Thu, 4 May 2023 16:21:45 +0200 (CEST)
Message-Id: <202305041421.344ELjJ7016795@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230418141446.1755363-1-selva.nair@...277...>
References: <20230418141446.1755363-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Format Windows error message in
 Unicode
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

I have not tested this myself (as in "trigger a nationalized error message
with non-ASCII characters in it"), but have test-built on mingw + GHA.

Your patch has been applied to the master and release/2.6 branch.

commit fed67642dccbcf115952df0709a98929c1fc52b8 (master)
commit d8cb1b5a397edf287745372afe9a6457edaf2ae8 (release/2.6)
Author: Selva Nair
Date:   Tue Apr 18 10:14:46 2023 -0400

     Format Windows error message in Unicode

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230418141446.1755363-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26598.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


