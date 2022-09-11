Date: Sun, 11 Sep 2022 22:34:18 +0200 (CEST)
Message-Id: <202209112034.28BKYIdL040029@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210304114018.8442-1-arne@...1227...>
References: <20210304114018.8442-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add example script
 demonstrating TOTP via auth-pending
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

I have not tested this, no proper testbed, no client support.  But it's
not changing OpenVPN code, just adding a script, and David has ACKed it.

I *have* changed the reference to match the script name, as instructed :-)

Your patch has been applied to the master branch.

commit 20ce5e3173cf1b086e1241619e8d949f0a6d0687
Author: Arne Schwabe
Date:   Thu Mar 4 12:40:18 2021 +0100

     Add example script demonstrating TOTP via auth-pending

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20210304114018.8442-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21603.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


