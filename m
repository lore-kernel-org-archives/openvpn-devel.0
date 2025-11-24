Date: Mon, 24 Nov 2025 19:49:43 +0100 (CET)
Message-Id: <202511241849.5AOInhQI044422@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251124175832.21352-1-gert@...1296...>
References: <20251124175832.21352-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: multi-socket: do not return
 tuntap flags on server-side
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

So we discused this at length on IRC (and in gerrit).  I'm still not sure
if I grok all the intricacies involved here, but some of the changes
are very obvious because the way "non udp socket events" have changed
in the multisocket patch makes the code in mudp.c obsolete now - others
not so much, but master + this passes all client/server tests, with single
and multisocket, and async scripts, so I guess all events are still being
properly addressed...

I would have gotten rid of get_io_flags_dowork_udp() at the same time
(just include the 2-3 lines in the single caller...), but this can be
done another time.

Same for the odd indent at the end of multi_io_process_io()...

Your patch has been applied to the master branch.

commit 6244e466217a367dd4d858f5e930e3aab415fc42
Author: Gianmarco De Gregori
Date:   Mon Nov 24 18:58:27 2025 +0100

     multi-socket: do not return tuntap flags on server-side

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1364
     Message-Id: <20251124175832.21352-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34650.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


