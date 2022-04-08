Date: Fri, 8 Apr 2022 07:55:44 +0200 (CEST)
Message-Id: <202204080555.2385tibi075667@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220407201411.22486-1-a@...2181...>
References: <20220407201411.22486-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking_iproute2: don't pass
 M_WARN to openvpn_execve_check()
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Good catch :-)

Your patch introduced a whitespace change on the second line.  I asked
uncrustify, uncrustify said "previous indent is correct", so only
changing the first line.

Your patch has been applied to the master and release/2.5 branch.

commit 545f6bdea30e04a09b118c4e1faf6523544fd935 (master)
commit 113b6c4192ecb927997b187de023aec71712f312 (release/2.5)
Author: Antonio Quartulli
Date:   Thu Apr 7 22:14:11 2022 +0200

     networking_iproute2: don't pass M_WARN to openvpn_execve_check()

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220407201411.22486-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24090.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


