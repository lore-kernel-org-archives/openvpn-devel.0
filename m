Date: Mon, 11 May 2020 14:33:06 +0200 (CEST)
Message-Id: <202005111233.04BCX6as036195@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200510140017.16837-1-a@...2181...>
References: <20200510140017.16837-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: tls-crypt-v2: fix testing of
 inline key
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

Your patch has been applied to the master branch.

David beat me with the ACK - I had just advanced through my daily interrupt
load enough to be able to reproduce the problem ("testing the patch next!")
when the ACK arrived.  Thanks anyway :-))

JFTR, after having created a tls-crypt-v2 server-key (in /tmp/s.key)

  $ ./openvpn --tls-crypt-v2 /tmp/s.key --genkey tls-crypt-v2-client

this command ("print to stdout") fails without the patch at hand, while
it nicely works with the patch.  So, functionality confirmed.

We need some sort of test framework for the tls-crypt(-v2) and/or inline
blob handling.


commit d7e26a34319495e39b8e23a5717304d28a417c30
Author: Antonio Quartulli
Date:   Sun May 10 16:00:17 2020 +0200

     tls-crypt-v2: fix testing of inline key

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20200510140017.16837-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19870.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


