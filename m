Date: Wed, 14 Dec 2022 16:13:59 +0100 (CET)
Message-Id: <202212141513.2BEFDxgE005238@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221205164103.9190-4-kprovost@...2661...>
References: <20221205164103.9190-4-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: Read the peer deletion reason
 from the kernel
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Makes sense & goes hand in hand with kernel change "commit da69782bf06",
which has landed in the official tree now.  So I've tested this, of
course :-)

As the change only touches dco_freebsd.c I have only tested this
on FreeBSD (but client/server, with/without DCO).  Logging is a bit
thin there, so I added a msg() to my local tree print out the reason
given (just to verify that "yes, it's coming up").

I can see counters and disconnect reason coming out of the kernel - which
is very nice - but after a few connect/disconnects the box crashes hard
on me.  So something is not good there...  OTOH, this is a kernel side
thing, doesn't stop me from shipping this userland patch.


Your patch has been applied to the master and release/2.6 branch.

commit 10ea19092ded38ff25a445f987ad948aa9eac49f (master)
commit 3186566e6967f0afb31e0426f5ec3490b0a363e9 (release/2.6)
Author: Kristof Provost
Date:   Mon Dec 5 17:41:02 2022 +0100

     Read the peer deletion reason from the kernel

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221205164103.9190-4-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25617.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


