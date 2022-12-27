Date: Tue, 27 Dec 2022 10:31:35 +0100 (CET)
Message-Id: <202212270931.2BR9VZjj094118@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210907223126.8440-3-selva.nair@...277...>
References: <20210907223126.8440-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use a template for 'unsupported
 management commands' error
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

Removed the hunk related to "client-pf".  The rest went in just fine.

Verified with my favourite "why does this not work at --management-hold
time?" new command :-)

    >HOLD:Waiting for hold release:0
    remote-entry-count
    ERROR: The 'remote-entry-count' command is not supported by the current daemon mode

Your patch has been applied to the master and release/2.6 branch.

commit caf1b9030f28a984a0e12dd87b128b428d3683f0 (master)
commit cad95bcc564e06dc53ec88e9ec4f529146569c0d (release/2.6)
Author: Selva Nair
Date:   Tue Sep 7 18:31:26 2021 -0400

     Use a template for 'unsupported management commands' error

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210907223126.8440-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22814.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


