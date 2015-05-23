Date: Sat, 23 May 2015 13:50:16 +0200 (CEST)
Message-Id: <201505231150.t4NBoG61011612@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <555BF270.3090706@...1147...>
References: <555BF270.3090706@...1147...>
Subject: [Openvpn-devel] [PATCH applied] Re: patch for bug #93: up-restart
	env vars
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master and release/2.3 branches.

I have taken a few liberties here - namely, merging the openvpn.8 patch
into yours as it's sort sort of "one big change" anyway, and reformatting
do_ifconfig_setenv() according to our new and improved coding style
(it didn't follow the old one or the new one, and if I reformat it 
anyway, go for the new one).  The code is unchanged, just indenting.

commit db950be85d37eab40d8fffe0bc2060059f8a7e10 (master)
commit 30256bede8f7ef6c82f1c2ed0d9f6c2177002926 (release/2.3)

Author: Jan Just Keijser
Date:   Wed May 20 04:33:20 2015 +0200

     patch for bug #93: up-restart env vars

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <555BF270.3090706@...1147...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9705
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


