Date: Tue, 27 Jul 2021 16:24:30 +0200 (CEST)
Message-Id: <202107271424.16REOU3Y024343@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210714162533.10098-1-david@...2627...>
References: <20210714162533.10098-1-david@...2627...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix argv leaks in add_route()
 and add_route_ipv6()
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
To: David Korczynski <david@...2627...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for your patch.  I have not seriously tested (just a basic
compile test) as it is "obviously correct" for that special case.

I have extended the commit message a bit to explain why the change
was done (this is what Antonio was talking about - "help the casual
reader who wants to understand this change in +3 years").

Your patch has been applied to the master, release/2.5 and release/2.4 
branch (bugfixes get backported to all supported branches).

commit a11bea18b1c93b260352ec505db15be0ec9431ee (master)
commit 5e88f131b55af96782532f3d1e086de4e17260fe (release/2.5)
commit f2f64e058b819d07da9125824717e4bc4d8f9a9d (HEAD -> release/2.4)
Author: David Korczynski
Date:   Wed Jul 14 17:25:33 2021 +0100

     Fix argv leaks in add_route() and add_route_ipv6()

     Signed-off-by: David Korczynski <david@...2627...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210714162533.10098-1-david@...2627...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22637.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


