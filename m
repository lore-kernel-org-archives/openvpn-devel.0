Date: Mon, 11 Nov 2024 09:06:08 +0100 (CET)
Message-Id: <202411110806.4AB8680S053305@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241111074355.17918-1-gert@...1296...>
References: <20241111074355.17918-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move
 should_trigger_renegotiation into its own function
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

Stared at the code, compared all the individual conditions before/after,
reasonably sure it does the same thing.  Tested a few cases 
(--reneg-sec 151, --reneg-pkts 20, --reneg-bytes 10000).

Noticed an interesting inconsistency...

2024-11-11 08:55:36 TLS: soft reset sec=151/151 bytes=7002/-1 pkts=74/0

.. "bytes" is initialized to -1 if not used, "pkts" to "0", and
the code also does "> 0" vs. "!= 0" (implicit)...  but this is as it 
was before, so not a change this patch introduces.


I have fixed the broken indentation (uncrustify build fail) on the fly,
"just one space to add".

Your patch has been applied to the master branch.

commit a4d0de10883fbec691a0301dd6fa04b095664711
Author: Arne Schwabe
Date:   Mon Nov 11 08:43:55 2024 +0100

     Move should_trigger_renegotiation into its own function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241111074355.17918-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29740.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


