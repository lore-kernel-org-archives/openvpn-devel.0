Date: Sat, 9 May 2015 15:49:20 +0200 (CEST)
Message-Id: <201505091349.t49DnJ1Z014796@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1430840857-6123-1-git-send-email-steffan@...1856...>
References: <1430840857-6123-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve --tls-cipher and
	--show-tls man page description
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

Patch has been applied to the master and release/2.3 branch.  

Applying to release/2.3 took some convincing, as Samuli's doc changes and 
some differences in ssl_polarssl.c got in the way (but as the change itself
is trivial, I don't think I could break anything :-) ).

commit 5f66f907cfc57b89110c08e50c7aab228e090911 (master)
commit 98e8dbbe3d0f8489fee0e814c57122097b16da20 (release/2.3)

Author: Steffan Karger
Date:   Tue May 5 17:47:37 2015 +0200

     Improve --tls-cipher and --show-tls man page description

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1430840857-6123-1-git-send-email-steffan@...1856...>
L/gmane.network.openvpn.devel/9651
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


