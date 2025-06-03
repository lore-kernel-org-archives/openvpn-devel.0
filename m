Date: Tue, 3 Jun 2025 16:26:28 +0200 (CEST)
Message-Id: <202506031426.553EQSIH021983@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250603142035.13685-1-gert@...1296...>
References: <20250603142035.13685-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: Test different
 permutations of --dh
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks, this is a very welcome addition to catch future oversights around
--dh variants.

The buildbots have tested this, and found it to their liking :-) - I have
just stared at it and liked it as well.

Your patch has been applied to the master branch.

commit 4d104a3857a21cf22774ba50b66fe575a682ae32
Author: Frank Lichtenheld
Date:   Tue Jun 3 16:20:29 2025 +0200

     t_server_null: Test different permutations of --dh

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250603142035.13685-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31868.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


