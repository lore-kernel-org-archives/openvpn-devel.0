Date: Wed, 8 Oct 2025 15:05:04 +0200 (CEST)
Message-Id: <202510081305.598D54TV086954@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008123757.18670-1-gert@...1296...>
References: <20251008123757.18670-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: support for epoch data
 channel
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

I haven't tested this, just stared at the code a bit - and most
changes are trivial enough.  The only "need to look closely" bit
is the new data structure for V2 ioctl()s - but the "v1" part of
it is the same as before, so it's just a few pointers to look at.

Your patch has been applied to the master branch.

commit ebc9d4bc27064d1287a523efda75e16654ba7bea
Author: Lev Stipakov
Date:   Wed Oct 8 14:37:51 2025 +0200

     dco-win: support for epoch data channel

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1219
     Message-Id: <20251008123757.18670-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243920/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


