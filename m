Date: Fri, 27 Mar 2020 16:26:59 +0100 (CET)
Message-Id: <202003271526.02RFQxwg089154@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200312113654.16184-1-arne@...1227...>
References: <20200312113654.16184-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Normalise ncp-ciphers option
 and restrict it to 127 bytes
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

Your patch has been applied to the master branch.

(v5 and v6 indeed differ only in the cmocka tests and should fix the
crash in v5 with mbedtls)

commit be4531564e2be7c8a0222e6923e3f7580b358cab
Author: Arne Schwabe
Date:   Thu Mar 12 12:36:54 2020 +0100

     Normalise ncp-ciphers option and restrict it to 127 bytes

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20200312113654.16184-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19546.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


