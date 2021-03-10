Date: Wed, 10 Mar 2021 11:12:16 +0100 (CET)
Message-Id: <202103101012.12AACGjO078148@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210226111012.21269-1-arne@...1227...>
References: <20210226111012.21269-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor extract_var_peer_info
 into standalone function and add ssl_util.c
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

Thanks for taking my suggestions to v2 into account (though the ssl.c
newline-at-end-of-file mishap is still there in v3 :-) - ignoring that
hunk).

Stared-at-code, while this looks very different, it's still doing the
same things (and in the same funny way, using strstr() to search for a
single character...).  Tested client-side and server side, does not break 
anything.

Adding my ACK on v3 to Lev's ACK on v2 - multiack!

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the master branch.

commit 88664aba69a8aab0e600200c445024fbaf7bab80
Author: Arne Schwabe
Date:   Fri Feb 26 12:10:12 2021 +0100

     Refactor extract_var_peer_info into standalone function and add ssl_util.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210226111012.21269-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21585.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


