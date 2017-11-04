Date: Sat, 4 Nov 2017 21:01:54 +0100 (CET)
Message-Id: <201711042001.vA4K1s53027908@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170327221620.24639-1-davids@...515...>
References: <20170327221620.24639-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: systemd: Add and ship
 README.systemd
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

ACK.

Arguably I have no idea about systemd, but documentation is generally
welcome, and "how to use openvpn in a systemd environment" is something
we better document :-) - since there is no code change involved, I do not
need to verify if this actually correct, but I assume that David knows
better than the rest of us anyway...

Patch has been applied to the master and release/2.4 branch.

commit 3230057d3a569ccedb0a41116e7819a229bd4a3f (master)
commit b6642f170e38eb2464a6806f91ce8f95e6a4ab99 (release/2.4)
Author: David Sommerseth
Date:   Tue Mar 28 00:16:20 2017 +0200

     systemd: Add and ship README.systemd

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170327221620.24639-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14311.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


