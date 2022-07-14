Date: Thu, 14 Jul 2022 20:55:01 +0200 (CEST)
Message-Id: <202207141855.26EIt1Qx030490@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220630190549.16675-3-selva.nair@...277...>
References: <20220630190549.16675-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log address of management
 client on accept
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

Acked-by: Gert Doering <gert@...1296...>

Silly code, this...

Before:

2022-07-14 20:50:12 us=826150 MANAGEMENT: Client connected from [AF_INET]127.0.0.1:0

After:

2022-07-14 20:51:18 us=100211 MANAGEMENT: TCP Socket listening on [AF_INET]127.0.0.1:49334
2022-07-14 20:51:22 us=443453 MANAGEMENT: Client connected from [AF_INET]127.0.0.1:50184

.. and also dual-stacked...

2022-07-14 20:52:03 us=916048 MANAGEMENT: Client connected from [AF_INET6]::1:29800
2022-07-14 20:52:09 us=636212 MANAGEMENT: Client connected from [AF_INET6]::ffff:127.0.0.1:30335

(Yeah, that one could be printed more pretty... we might have a _ex() thingie
for it... but it's already much more useful than before)

New code looks good, and does what it promises.

Your patch has been applied to the master branch.

commit dd98c38b31c02cbca7f88ed0a709e68f24361195
Author: Selva Nair
Date:   Thu Jun 30 15:05:49 2022 -0400

     Log address of management client on accept

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220630190549.16675-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24619.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


