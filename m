Date: Sat, 22 Mar 2014 18:37:36 +0100 (CET)
Message-Id: <201403221737.s2MHbarW000184@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395407925-25518-3-git-send-email-arne@...1227...>
References: <1395407925-25518-3-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move the initialization of the
	environment to the top so c2.es is initialized
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, with the explanation given on IRC:

13:54 <@plai> that patch is FOSDEM last year time
13:58 <@plai> Something could fail with an msg (M_FATAL, which calls then 
              openvpn_exit with calls the exit script hook, which fails if the 
              env is not available


Your patch has been applied to the master branch.

commit ac1c2f259b44d1229a65a3e639b09d57a4e2a53b
Author: Arne Schwabe
Date:   Fri Mar 21 14:18:35 2014 +0100

     Move the initialization of the environment to the top so c2.es is initialized

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395407925-25518-3-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8372
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


