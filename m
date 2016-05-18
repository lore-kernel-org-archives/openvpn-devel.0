Date: Wed, 18 May 2016 08:37:11 +0200 (CEST)
Message-Id: <201605180637.u4I6bBLA049723@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <53F1DA95.7020701@...1085...>
References: <53F1DA95.7020701@...1085...>
Subject: [Openvpn-devel] [PATCH applied] Re: Push an IPv6 CIDR mask used by
	the server, not the pool's size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

Well, thanks for cleaning up my not-so-well-considered code... this is
quite obviously the right fix (and I never noticed, because I always only
do --server-ipv6, not call --ifconfig-ipv6 and --ifconfig-ipv6-pool
individually... need to change one of my test systems here).  So, another
ACK from me - and thanks to Arne for digging this up and making sure it's
not forgotten.

Your patch has been applied to the master and release/2.3 branch.

I've taken the liberty of fixing two whitespace errors in the original
code right next to the multi.c line that has been changed - "git complained, 
so I obeyed".

commit c4ed931a70502a351ff1089aa1bfb8001586f788 (master)
commit b8c4684f01701742eceb9dc6bfc4e2564278f6fd (release/2.3)

Author: Josh Cepek
Date:   Mon Aug 18 05:51:01 2014 -0500

     Push an IPv6 CIDR mask used by the server, not the pool's size

     Signed-off-by: Josh Cepek <josh.cepek@...1085...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <53F1DA95.7020701@...1085...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8990
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


