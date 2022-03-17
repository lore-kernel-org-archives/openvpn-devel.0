Date: Thu, 17 Mar 2022 13:53:50 +0100 (CET)
Message-Id: <202203171253.22HCrofW067697@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220301135054.277-1-lstipakov@...277...>
References: <20220301135054.277-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix incorrect default mssfix
 value in server mode
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

Thanks for the band-aid :-) - I have not tested this, trusting you and
Arne to have sufficiently tested this in the context of Win-DCO MSS
handling (as a side note, patches against a tree with "dco_enabled(o)"
in their context do not fit "master without DCO" easily ;-) ).

Your patch has been applied to the master branch.

commit 7a50f5f633ca179214d102806c582de9a076ec8a
Author: Lev Stipakov
Date:   Tue Mar 1 15:50:54 2022 +0200

     Fix incorrect default mssfix value in server mode

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220301135054.277-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23896.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


