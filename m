Date: Thu, 21 Apr 2022 09:25:58 +0200 (CEST)
Message-Id: <202204210725.23L7PwiE046184@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220420121322.42732-1-openvpn@...2080...>
References: <20220420121322.42732-1-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools: Remove no longer
 needed openvpn-plugin.h.in patching
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

We've discussed this on IRC - this was a workaround for old uncrustify
(which supposedly segfaulted on openvpn-plugin.h.in) but since we've
converged on "0.72 or 0.74" now, this is no longer relevant.

Your patch has been applied to the master branch.

commit c5c68210c5a38b6ff03d3489aadc519e9a5dd855
Author: David Sommerseth
Date:   Wed Apr 20 14:13:20 2022 +0200

     dev-tools: Remove no longer needed openvpn-plugin.h.in patching

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220420121322.42732-1-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24122.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


