Date: Wed, 21 Feb 2018 19:47:47 +0100 (CET)
Message-Id: <201802211847.w1LIllO3087014@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1519191510-3826-1-git-send-email-selva.nair@...277...>
References: <1519191510-3826-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Adapt to RegGetValue brokenness
 in Windows 7
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

Patch matches the problem discussed in the mail thread here and on
stackoverflow (RRF_RT_REG_SZ|RRF_RT_REG_EXPAND_SZ broken on Win7),
cross compiled on ubuntu 16.04, installed & tested on Win7/64, and 
works again :-)

Thanks.

Your patch has been applied to the master and release/2.4 branch.

commit 7de0ee4f6f6f44fab48717e4cc2073ff4e8580f6 (master)
commit e9b85ebd2895fda85daeb15a9794d5a2e3a79fab (release/2.4)
Author: Selva Nair
Date:   Wed Feb 21 00:38:30 2018 -0500

     Adapt to RegGetValue brokenness in Windows 7

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1519191510-3826-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16513.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


