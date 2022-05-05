Date: Thu, 5 May 2022 13:42:58 +0200 (CEST)
Message-Id: <202205051142.245BgwE6026821@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220422142953.3805364-12-arne@...1227...>
References: <20220422142953.3805364-12-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 read_incoming_tls_ciphertext into function
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

Stare-at-code and running client/server tests confirm that this is,
indeed, only trivial move-around.

Your patch has been applied to the master branch.

commit 8b9b8f91b76af59e26edee46f1a1f4eebdca762b
Author: Arne Schwabe
Date:   Fri Apr 22 16:29:46 2022 +0200

     Extract read_incoming_tls_ciphertext into function

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220422142953.3805364-12-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24152.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


