Date: Thu, 21 Oct 2021 15:55:03 +0200 (CEST)
Message-Id: <202110211355.19LDt36p051031@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-7-arne@...1227...>
References: <20211019183127.614175-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate --ecdh-curve with
 OpenSSL 3.0 and adjust mbed TLS message
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

I have not tested this further, just done a cursory stare-at-code.

Your patch has been applied to the master branch.

commit 39eb3125e4f433fc61c92321175f663f13f163e7
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:12 2021 +0200

     Deprecate --ecdh-curve with OpenSSL 3.0 and adjust mbed TLS message

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22999.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


