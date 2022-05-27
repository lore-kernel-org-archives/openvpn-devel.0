Date: Fri, 27 May 2022 10:20:09 +0200 (CEST)
Message-Id: <202205270820.24R8K9Gq047337@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220527012457.1819262-3-heiko@...2662...>
References: <20220527012457.1819262-3-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: remove dead foreign-option
 parsing code
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Trivial.  Inside #if 0, has been like that since the dawn of times,
so really nobody can ever miss that one.

Your patch has been applied to the master branch.

commit ccdd7096ae9a5fe6f07451f525cbdd40885f3acc
Author: Heiko Hund
Date:   Fri May 27 03:24:55 2022 +0200

     remove dead foreign-option parsing code

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220527012457.1819262-3-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24434.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


