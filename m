Date: Tue, 28 Oct 2025 18:46:36 +0100 (CET)
Message-Id: <202510281746.59SHkajr020655@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251023155614.20642-1-gert@...1296...>
References: <20251023155614.20642-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Warn if push is used without
 --mode server/--server/--server-bridge
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

Change is straightforward enough... interestingly enough I do have a
t_server test instance that is "p2p --mode tls-server with --push" so
I could test this right away...

2025-10-28 18:39:08 us=773113 Note: Using --push without --mode server is an unsupported configuration. Negotiation of OpenVPN features is expected to fail.

.. and there you go.  Indeed it then fails cipher negotiation (without
--pull on the other end, it won't PUSH_REPLY, but with --pull, it fails
p2p cipher negotiation... and goes to lala land)

Interesting find on PUSH_DEFINED()... you could have removed the redundant
PULL_DEFINED() as well, while at it.  Next time.

Your patch has been applied to the master branch.

commit d6a0cf599c68edc672c67c6afa4bdff0e1a30b8a
Author: Arne Schwabe
Date:   Thu Oct 23 17:56:08 2025 +0200

     Warn if push is used without --mode server/--server/--server-bridge

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1288
     Message-Id: <20251023155614.20642-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33856.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


