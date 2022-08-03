Date: Wed, 3 Aug 2022 17:56:22 +0200 (CEST)
Message-Id: <202208031556.273FuMUk009231@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220803095012.24975-1-a@...2181...>
References: <20220803095012.24975-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: split option parsing
 routines
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

Acked-by: Gert Doering <gert@...1296...>

Subjected to the full set of server side tests that so nicely crashed
11/25 v2 :-) (passed) and to client Linux/FreeBSD t_client tests including
P2P NCP (passes as well).

The code looks good, and more correct as well.  Thanks for all the
comments and for renaming the function - if it helps my brain, future
contributors might benefit from it as well.

Just for reference: do_deferred_p2p_ncp() is all "part2" type stuff,
so it gets moved as a whole, not split.

NOTE: there is a small change in behaviour, which I'm not sure if 
problematic or not.  The "part2" behaviour was previously encapsulated
in

 if (c->options.pull)
 {
    ...
 }

and is no longer checking this in "_part2()".

This makes (as far as I can see) a difference if and only if a client
*without* --pull (-> c->options.pull) will receive a PUSH_REPLY from
a server that is behaving different from what we do - we only send
PUSH_REPLY in reply to a PUSH_REQUEST, or to IV_PROTO=IV_PROTO_REQUEST_PUSH
(and that is only happening if --pull / --client is set on the client).

In the server instance - which is called from multi.c - this would
make a difference *if* we called _part2() from multi.c - but we do not(!),
as that code path calls multi_client_generate_tls_keys(), which does
the tls_session_update_crypto_params() for us...  so, server would
not call it before (!options.pull) and doesn't call it now (no call
to _part2()) -> no change here.


Your patch has been applied to the master branch.

commit 6b9f4d71d859c27a9a71699aa899c9a2c5c3b680
Author: Antonio Quartulli
Date:   Wed Aug 3 11:50:12 2022 +0200

     dco: split option parsing routines

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220803095012.24975-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24789.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


