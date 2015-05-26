Date: Tue, 26 May 2015 16:40:54 +0200 (CEST)
Message-Id: <201505261440.t4QEes9P012776@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1430144937-4149-1-git-send-email-steffan@...1856...>
References: <1430144937-4149-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Call daemon() before
	initializing crypto library
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master and release/2.3 branch.

(I spent quite some thought on whether this is 2.3 material - and decided
"yes it is".  While it is a complicated patch, I'm fairly sure it has
no adverse side effects - and it *does* fix a real and observed problem,
has been tested good by the FreeBSD folks affected, and gets rid of 
some extra convolutions that should have never been there - so, blame
me if it breaks anything, I'll be doing the tracs for 2.3.8 anyway...)

commit da9b292733e929a2900dc32d37f0424c3d588366 (master)
commit f025de005d719201a69ad0313d545a1ddd244752 (release/2.3)

Author: Steffan Karger
Date:   Mon Apr 27 16:28:57 2015 +0200

     Call daemon() before initializing crypto library

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1430144937-4149-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9609
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


