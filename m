Date: Thu, 25 Jul 2024 13:37:53 +0200 (CEST)
Message-Id: <202407251137.46PBbrvS045088@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240725112248.21075-1-gert@...1296...>
References: <20240725112248.21075-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: add and send
 IV_PROTO_DNS_OPTION_V2 flag
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this beyond "does it compile".

My understanding is that this is to align openvpn 2.x and 3.x in
regards to "if this bit is set, the client understands the new
variants in `--dns`" and since the "new code" is only in master,
so is this patch.

Your patch has been applied to the master branch.

commit 8991f0d5c6c06d1e42919d1d6a0813ca1c46f8a1 (master)
Author: Heiko Hund
Date:   Thu Jul 25 13:22:48 2024 +0200

     add and send IV_PROTO_DNS_OPTION_V2 flag

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240725112248.21075-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28970.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


