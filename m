Date: Tue, 17 Dec 2019 21:09:40 +0100 (CET)
Message-Id: <201912172009.xBHK9eUR095973@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191217125041.207-1-lstipakov@...277...>
References: <20191217125041.207-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: wintun: interactive service
 support
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(An ACK on v2, an ACK on v5, this is v5 :-) ).

Test built on Ubuntu 1604 (works), not actually tested anything.

Did a little bit of stare-at-code, which did not turn up anything 
I need to complain about... introducing a new ring_buffer.c file for
less lines of code than the ring_buffer.h header file has seems a bit
excessive, but since this is shared code between openvpn and iservice,
it makes sense.

commit da2e66ca74688094a3dcbf8e2ce0a3bc54478a53
Author: Lev Stipakov
Date:   Tue Dec 17 14:50:41 2019 +0200

     wintun: interactive service support

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20191217125041.207-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19244.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


