Date: Tue, 9 Dec 2025 19:11:55 +0100 (CET)
Message-Id: <202512091811.5B9IBt2J071427@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251209153715.15832-1-gert@...1296...>
References: <20251209153715.15832-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: Change return type of
 write_tun/read_tun to ssize_t
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

Getting another one from the integer conversion series out of the way,
and getting rid of quite a few #pragmas in one go!

Stared at the change for a bit (makes sense).  Buildbots are happy.  Go.

Your patch has been applied to the master branch.

commit c97aa55a3f356b5ceb537b162b8cf8b9804cc739
Author: Frank Lichtenheld
Date:   Tue Dec 9 16:37:07 2025 +0100

     tun: Change return type of write_tun/read_tun to ssize_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1376
     Message-Id: <20251209153715.15832-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34961.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


