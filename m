Date: Wed, 17 Aug 2022 16:18:39 +0200 (CEST)
Message-Id: <202208171418.27HEIdol040022@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220817131817.467-1-timo@...2669...>
References: <20220817131817.467-1-timo@...2669...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: disable DCO if --user
 specified but unable to retain capabilities
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Bernhard has already tested this on his Debian/NM testing 
environment and confirms it fixes the issues seen in 

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1017379

I've added a bit of explanatory text to the commit message (quite a 
bit of blurb, actually, but the issue was confusing us enough that
this might help future readers).

Your patch has been applied to the master branch.

commit da31c1654c8534658157cfe9c9de5750ee752608
Author: Timo Rothenpieler
Date:   Wed Aug 17 15:18:17 2022 +0200

     dco: disable DCO if --user specified but unable to retain capabilities

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220817131817.467-1-timo@...2669...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24952.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


