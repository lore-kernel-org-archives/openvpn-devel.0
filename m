Date: Fri, 6 May 2022 15:02:06 +0200 (CEST)
Message-Id: <202205061302.246D26Gj074009@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-14-arne@...1227...>
References: <20220422142953.3805364-14-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Optimise three-way handshake
 condition for S_PRE_START to S_START
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

As instructed, I have done quite a bit of wording changes in the
commit message and the tls_process_state() comment.  No code change.

Also, I've left off the hunk for test_pkt.c, as that is already in
(v2 or v3 of one of the previous patches in the series).

S-O-B added.

I have not explicitly counted handshake packets, but the explanation
seems to match the actual code change, and the explanation makes sense.

Lightly (client-side only) tested.

Your patch has been applied to the master branch.

commit 3f5626891e6bc569456ab168b3a5e5f76e0538bd
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:48 2022 +0200

     Optimise three-way handshake condition for S_PRE_START to S_START

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422142953.3805364-14-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24161.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


