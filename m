Date: Fri, 6 May 2022 15:03:12 +0200 (CEST)
Message-Id: <202205061303.246D3C5T074187@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220503112900.933975-1-arne@...1227...>
References: <20220503112900.933975-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 read_incoming_tls_plaintext into its own function
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

Stared at code for a bit (looks trivial enough), added "and" to the
commit message, ran client test.

Your patch has been applied to the master branch.

commit 413877f522e89ccc6dd2543bc585ac553df3bd42
Author: Arne Schwabe
Date:   Tue May 3 13:29:00 2022 +0200

     Extract read_incoming_tls_plaintext into its own function

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220503112900.933975-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24268.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


