Date: Wed, 3 Feb 2021 11:27:57 +0100 (CET)
Message-Id: <202102031027.113ARvEu087082@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1612163389-16421-1-git-send-email-gcox@...1057...>
References: <1612163389-16421-1-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH applied] Re: Explain structver usage in
 sample defer plugin.
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
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master, release/2.5 and release/2.4 branch.

I have taken the liberty of changing "structvar" to "structver" in the
Subject:

(As a side note, I do not think the structver check in openvpn_plugin_func_v3()
is really necessary - if "open_v3" succeeds, we already know which struct ver
openvpn uses...)

commit fdfbd4441c2225dc69431c57d18291e103c466cf (master)
commit 1f61f3f755a84ed9765da744c7b61a35f36c4d4b (release/2.5)
commit 5b17607ad593bc081dc35b2ed1d6b852786a0d23 (release/2.4)
Author: Greg Cox
Date:   Mon Feb 1 07:09:49 2021 +0000

     Explain structver usage in sample defer plugin.

     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1612163389-16421-1-git-send-email-gcox@...1057...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21540.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


