Date: Thu, 26 Nov 2020 12:51:52 +0100 (CET)
Message-Id: <202011261151.0AQBpqUb073051@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023120259.29783-5-arne@...1227...>
References: <20201023120259.29783-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename DECRYPT_KEY_ENABLED to
 TLS_AUTHENTICATED
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

Acked-by: Gert Doering <gert@...1296...>

code wise, this is just mechanical search-and-replace, so easily
tested :-) - "understanding the code" wise this makes sense,
and even brings in extra documentation!

Your patch has been applied to the master branch.

commit 3ac8e5923a12390f68aa901e04ab3204e326d243
Author: Arne Schwabe
Date:   Fri Oct 23 14:02:57 2020 +0200

     Rename DECRYPT_KEY_ENABLED to TLS_AUTHENTICATED

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023120259.29783-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21221.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


