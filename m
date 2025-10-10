Date: Fri, 10 Oct 2025 16:30:29 +0200 (CEST)
Message-Id: <202510101430.59AEUT5L087578@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251010142002.27308-1-gert@...1296...>
References: <20251010142002.27308-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE server: bug-fix,
 reset buffer after processing
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
To: Marco Baffo <marco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Discovered the problem while testing #1255 with multiple clients online
at the same time, with different capabilities - and it only sent anything
to the very first (capable) client, and then "empty string" because
the buffer in msgs[i] was buf_advance()'d and it shouldn't have been...

So this fixes things by doing a shallow copy to a temp "buffer", which
is safe as long as no writes to the memory is done - reading & advancing
the pointers is fine (we discussed various approaches on IRC, as can
be seen in v1/v3/v4 in gerrit ;-) - and a "make documentation for this
API" issue also appeared...).

Tested this + #1255, and now things behave correctly.

Your patch has been applied to the master branch.

commit 107f80b8e3102cca3a2cc008d37895f96ec2f17c
Author: Marco Baffo
Date:   Fri Oct 10 16:19:56 2025 +0200

     PUSH_UPDATE server: bug-fix, reset buffer after processing

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1264
     Message-Id: <20251010142002.27308-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59244933/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


