Date: Mon, 14 Feb 2022 08:15:39 +0100 (CET)
Message-Id: <202202140715.21E7FdWT009189@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220214021054.3750071-1-arne@...1227...>
References: <20220214021054.3750071-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix 'defined but not used'
 warnings with enable-small/disable-management
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Ran across the print_vlan_accept() myself yesterday, but did not investigate
- so, very timely patch :-)

Onyl minimally compile tested.

Your patch has been applied to the master branch.

commit b0cbab96cc6e886d9eb8e304068ff61705d2a137
Author: Arne Schwabe
Date:   Mon Feb 14 03:10:53 2022 +0100

     Fix 'defined but not used' warnings with enable-small/disable-management

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220214021054.3750071-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23779.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


