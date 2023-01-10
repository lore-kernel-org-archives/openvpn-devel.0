Date: Tue, 10 Jan 2023 20:46:49 +0100 (CET)
Message-Id: <202301101946.30AJknQe051193@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230110131947.59552-1-frank@...2641...>
References: <20230110131947.59552-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: xkey_pkcs11h_sign: fix dangling
 pointer
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

Haven't tested this beyond "does it compile on Github?" - it looks
correct, though :-)

Your patch has been applied to the master branch.

commit 202b34da386c8574692111bad23814602d0e09f5 (master)
commit 71f3a109f9f73f0d978f58e08caed896c064767f (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Jan 10 14:19:47 2023 +0100

     xkey_pkcs11h_sign: fix dangling pointer

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230110131947.59552-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25942.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


