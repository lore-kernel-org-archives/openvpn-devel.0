Date: Sat, 23 Oct 2021 17:44:22 +0200 (CEST)
Message-Id: <202110231544.19NFiM73007609@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211023000706.25016-1-selva.nair@...277...>
References: <20211023000706.25016-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure the current common_name
 is in the environment for scripts
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

Thanks for finding a better theory how to fix this :-) - and then 
finding the single-line "so obvious" place to fix this, without caring
about all our convolutions in changing common_name.

(And thanks to Richard for getting so upset with this bug that he
found nice and reliable ways to test bug and fix)

Your patch has been applied to the master branch.

commit fa5ab2438ad2d8a12eaf43e2cdd8b4294299c175
Author: Selva Nair
Date:   Fri Oct 22 20:07:05 2021 -0400

     Ensure the current common_name is in the environment for scripts

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211023000706.25016-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23051.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


