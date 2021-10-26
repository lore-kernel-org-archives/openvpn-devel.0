Date: Tue, 26 Oct 2021 19:38:16 +0200 (CEST)
Message-Id: <202110261738.19QHcGpH000807@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-16-arne@...1227...>
References: <20211019183127.614175-16-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not allow CTS ciphers
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

Lightly client-side tested on OpenSSL 1.1.x and 3.0.  No surprises.

Your patch has been applied to the master branch.

commit 14e4f3b1583749adf104be362a3e2422e0c9e524
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:21 2021 +0200

     Do not allow CTS ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-16-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23002.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


