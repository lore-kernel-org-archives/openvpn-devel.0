Date: Mon, 25 Apr 2022 17:47:41 +0200 (CEST)
Message-Id: <202204251547.23PFlfFt071388@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422134038.3801239-6-arne@...1227...>
References: <20220422134038.3801239-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extend tls_pre_decrypt_lite to
 return type of packet and keep state
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

This is 05 without the "comment and whitespace" bits that fix 04.

Stared at code, ran client/server tests (including UDP server).

It should be noted that this adds recognition of P_CONTROL_V1 packets
to tls_pre_decrypt_lite() - but they are handled by the caller the
same way as VERDICT_INVALID, so the effective difference is none
("only accept packets that are P_CONTROL_HARD_RESET_CLIENT_V2/V3").

The "free_tls_pre_decrypt_state()" is actually nothing new, it's all
existing free() calls, just moved to that new function (so, not much
consideration on "what sort of data is manipulated here?").

The comment in ssl.h for tls_pre_decrypt_lite() is missing an
explanation of what "struct tls_pre_decrypt_state *state" is for - but
I guess this will come in a followup patch?

Your patch has been applied to the master branch.

commit b67d670b2dedd9a4d39d927956b385903107f82b
Author: Arne Schwabe
Date:   Fri Apr 22 15:40:34 2022 +0200

     Extend tls_pre_decrypt_lite to return type of packet and keep state

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220422134038.3801239-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24148.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


