Date: Mon, 6 Dec 2021 13:38:42 +0100 (CET)
Message-Id: <202112061238.1B6Ccg5l030194@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211201180727.2496903-6-arne@...1227...>
References: <20211201180727.2496903-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove key_type->hmac_length
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

Fairly straightforward, as was 5/9...  except for the tls1_P_hash(),
but comparing old/new code paths & reading the comment helps :-)

Client-side and server-side (= more coverage wrt "old peer = old PRF")
tested.

Your patch has been applied to the master branch.

commit 459d9669d1b5ca110107306762625a4fb5650c58
Author: Arne Schwabe
Date:   Wed Dec 1 19:07:24 2021 +0100

     Remove key_type->hmac_length

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211201180727.2496903-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23274.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


