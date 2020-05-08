Date: Fri, 8 May 2020 23:53:08 +0200 (CEST)
Message-Id: <202005082153.048Lr8JU073553@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200508114411.15762-1-davids@...515...>
References: <20200508114411.15762-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Restore --tls-crypt-v2
 inline file capability
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

Your patch has been applied to the master branch.

Not done any testing either, but this is very similar to the other hunks,
so makes sense.  Patch lingered for too long, new inline-capable options
added :-(

commit 7ae8dbb7c4a2ca4a23efae7b08222a8db0efc529
Author: David Sommerseth
Date:   Fri May 8 13:44:11 2020 +0200

     options: Restore --tls-crypt-v2 inline file capability

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200508114411.15762-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19859.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


