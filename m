Date: Mon, 11 May 2020 21:00:27 +0200 (CEST)
Message-Id: <202005111900.04BJ0R1S041296@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200326172332.2356-2-arne@...1227...>
References: <20200326172332.2356-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix session id in env missing
 first byte
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

Haven't actually tested this in any server setup - but "this is your code,
if you say this is the way it needs to be, it is, the explanation makes 
sense and the code change matches".  An all other occurences use strlen()
as well... So,

Acked-by: Gert Doering <gert@...1296...>

commit 42fe3e8175822a4cf2c85cc4ce3fdffd41d74455
Author: Arne Schwabe
Date:   Thu Mar 26 18:23:31 2020 +0100

     Fix session id in env missing first byte

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200326172332.2356-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19622.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


