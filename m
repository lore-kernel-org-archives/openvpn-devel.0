Date: Sun, 19 Jan 2020 14:00:40 +0100 (CET)
Message-Id: <202001191300.00JD0eGS060029@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200108115224.38-1-simon@...2293...>
References: <20200108115224.38-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: stop sending
 TAP-Windows6 ioctls to NDIS device
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Test compiled, and stared at the code a bit, seems to make sense :)

commit 948b4f938a02dee78fb5246bcd44bc0162619b2d
Author: Simon Rozman
Date:   Wed Jan 8 12:52:24 2020 +0100

     wintun: stop sending TAP-Windows6 ioctls to NDIS device

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200108115224.38-1-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19309.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


