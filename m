Date: Sat, 21 Dec 2024 23:19:07 +0100 (CET)
Message-Id: <202412212219.4BLMJ7aM051435@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241221153731.1755-1-gert@...1296...>
References: <20241221153731.1755-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Trigger renegotiation of data
 key if getting close to the AEAD usage limit
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

So, I tested this as instructed, setting a ridiculously low limit
(10000), and "it does rekey often".  There is one interesting aspect
to it

2024-12-21 23:04:19 TLS: soft reset sec=91/3600 bytes=1043562/-1 pkts=6886/0 aead_limit_send=50100/8750 aead_limit_recv=6886/8750

.. with this low limit, we can exceed the limit by quite some marging
- which is due to "tls_process()" only being called every 15-16 seconds
when in steady state (this is what checks should_trigger_renegotiation()),
so "what happens in these 15 seconds" can go over the limit.  Which is not
a problem for the normal limit (~68719476736 *7/8, so roughly 8589934592
AEAD blocks in 15 seconds - we're fast, but not that fast).


Besides this, the code does nothing unexpected - it passes all client/server
side tests, and changes nothing in process behaviour.  So ACK from me,
on top of the "crypto looks good" +1 from MaxF and Steffan.

Your patch has been applied to the master branch.

commit fb691d2dcc63a29dafdf11ca33837c758e2b13b7
Author: Arne Schwabe
Date:   Sat Dec 21 16:37:30 2024 +0100

     Trigger renegotiation of data key if getting close to the AEAD usage limit

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241221153731.1755-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30144.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


