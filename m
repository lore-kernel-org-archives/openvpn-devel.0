Date: Wed, 8 Apr 2026 14:34:19 +0200 (CEST)
Message-Id: <202604081234.638CYJPw072701@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260407205344.31263-1-gert@...1296...>
References: <20260407205344.31263-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Remove redundant
 bit-wise operation
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

Maybe it's just me, but I needed to look twice until I saw it... 
("SYNCHRONIZE" was or-ed in twice, which won't make it any stronger)
- but then it's quite obviously correct.  BB compile-tested for me.

Since this isn't changing/fixing functionality, it does not need to
go to 2.7

Your patch has been applied to the master branch.

commit df430b03d5959e87fbf502b7430be07f49a0d0ba
Author: Frank Lichtenheld
Date:   Tue Apr 7 22:53:36 2026 +0200

     openvpnserv: Remove redundant bit-wise operation

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1623
     Message-Id: <20260407205344.31263-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36547.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


