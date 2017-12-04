Date: Mon, 4 Dec 2017 19:27:03 +0100 (CET)
Message-Id: <201712041827.vB4IR3Kl056164@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171204010110.22091-1-a@...2181...>
References: <20171204010110.22091-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove ENABLE_CRYPTO
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

I've done a quick review and the changes make sense.  Tested with local
t_client tests on Linux and FreeBSD (unsurprisingly, no suprises).

Since this series is refactoring (though mostly not very intrusive), 
"master only" rule applies.

Your patch has been applied to the master branch.

commit c7ca91332d330b3cbbc2a8faef4f3a3ae70048c5
Author: Antonio Quartulli
Date:   Mon Dec 4 09:01:10 2017 +0800

     Remove ENABLE_CRYPTO

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20171204010110.22091-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16004.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


