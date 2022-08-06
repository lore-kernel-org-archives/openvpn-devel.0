Date: Sat, 6 Aug 2022 12:55:11 +0200 (CEST)
Message-Id: <202208061055.276AtBiU079079@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220728111712.94-1-lstipakov@...277...>
References: <20220728111712.94-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: remove
 OpenVPNService state check code
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

I have no idea what this all does :-) - but it builds on Ubuntu20/MinGW, 
and removing code complexity is always welcome.  The change is really
isolated - it removes the set_openvpnserv_state() function and the
(single) call to it.

I have only applied it to "master" for the time being, because I'm not
sure if the new installer source will be used for the next 2.5.x windows
build, or only for 2.6.x - so, please tell me if needed in release/2.5

Your patch has been applied to the master branch.

commit 08d393d4f17ec645450b245756c2429c8fa1fcec
Author: Lev Stipakov
Date:   Thu Jul 28 14:17:12 2022 +0300

     openvpnmsica: remove OpenVPNService state check code

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20220728111712.94-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24752.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


