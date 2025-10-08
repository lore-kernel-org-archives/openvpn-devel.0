Date: Wed, 8 Oct 2025 11:14:11 +0200 (CEST)
Message-Id: <202510080914.5989EBaI078106@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008083046.27209-1-gert@...1296...>
References: <20251008083046.27209-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: PUSH_UPDATE: disabling
 PUSH_UPDATE server and client if DCO is enabled
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

So, to wrap up the discussions we had on IRC about this patch, and the
underlying issue - basically, our current implementation of PUSH_UPDATE
is incompatible with DCO, for different reasons

 - on the server, if PUSH_UDPATE sends new "ifconfig" or "ifconfig-ipv6"
   addresses for the client, DCO needs to be told ("vpn-ip" attribute of
   the in-kernel peer) - and this code is not there yet.  Also, we might
   need to remove + reinstall iroutes, as those are "in the normal routing
   system, with the client vpn-ip next-hop" (on Linux and FreeBSD), which
   we do not have any code for, either.

 - on the client, we current close + reopen the tun device on PUSH_UPDATE
   reception - which is the most simple implementation (as compared to
   "calculate the delta needed, and update the config").  Alas, this does
   not work with DCO either - here, we have no problem with "vpn-ip",
   as this does not matter in client/p2p mode - but here, we have KEYS
   to address. "Close and reopen tun" = "there is no key material in
   kernel for this (new) DCO peer", and thus, no packets pass.
 
   For the client side, we do not really need to worry about DCO handling,
   *if* we can do the ip address / route updates in an incremental way - but
   this is more complex.  So for 2.7.0, we decided to go with "if DCO
   is active, the client will signal 'no support for PUSH_UPDATE' and
   also refuse incoming messages (from a server that does not check the
   IV_ bits) with a clear message".  Afterwards, the necessary changes
   for incremental updates get looked at.

   For the server side, there is another patch coming that improves
   learning/forgetting vpn IP addresses in the userland hash - and a
   future patch could build on that, and update the information in DCO
   with the new peer data.  But this is also no priority for 2.7.0
   (as we consider PUSH_UPDATE server side to be more of a "work in 
   progress" thing).  It does work without DCO.


Thus, for now, refuse PUSH_UPDATE functionality on both ends if DCO is
active on the local end.

I have not tested this beyond what the BBs do (= unit tests are now
fixed and pass).  The actual PUSH_UPDATE code is the same, it is just
not reachable "if (dco)".

Your patch has been applied to the master branch.

commit 373178b32dfa8f272cb9322b5f0092b03c3c61c2
Author: Marco Baffo
Date:   Wed Oct 8 10:30:41 2025 +0200

     PUSH_UPDATE: disabling PUSH_UPDATE server and client if DCO is enabled

     Signed-off-by: Marco Baffo <marco@...2726...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1245
     Message-Id: <20251008083046.27209-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243711/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


