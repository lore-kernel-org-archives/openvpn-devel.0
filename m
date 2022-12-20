Date: Tue, 20 Dec 2022 01:13:07 +0100 (CET)
Message-Id: <202212200013.2BK0D723055659@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221219174027.2567505-1-arne@...1227...>
References: <20221219174027.2567505-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure that dco keepalive and
 mssfix options are also set in pure p2p mode
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

This indeed is good news - as in, the p2p --tls-server test case that
used to reliably break when the client disconnected because --ping wasn't
working is now working.  Tested on Linux/DCO, FreeBSD/DCO and "Linux no DCO",
with the full set of client/server tests - it fixes some bits, and breaks
nothing else, so good :-)

Stare-at-code and thinking about the flow of control also confirms that
this is a good fix - do_up() is executed always (after PUSH_REPLY for
--client, and "on init" for --tls-client / --tls-server) so setting
up DCO ping/mss is needed there.

(And thanks for adding the logging entry to dco_freebsd.c - I was 
staring at my logs and wondering why I didn't see anything, even in
p2mp mode...)

(... and, as an afterthought, I re-checked to be sure we've not lost
multipoint keepalive on the way - we haven't, I can see proper
"ping interval..." messages for peer-id 0, 1, 2 in my udp-p2mp
instance)


Your patch has been applied to the master and release/2.6 branch.

commit 7c66a6dab54d8efcde57c8fb562f95d95f9b18d4 (master)
commit c6ba846384b6a7ab610e5d7de689868fa0a48395 (release/2.6)
Author: Arne Schwabe
Date:   Mon Dec 19 18:40:27 2022 +0100

     Ensure that dco keepalive and mssfix options are also set in pure p2p mode

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221219174027.2567505-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20221219174027.2567505-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


