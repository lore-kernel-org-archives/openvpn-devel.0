Date: Mon, 16 May 2016 20:20:38 +0200 (CEST)
Message-Id: <201605161820.u4GIKcR0032755@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1457671646-4322-1-git-send-email-selva.nair@...277...>
References: <1457671646-4322-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for register-dns
	through interactive service
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Thanks a lot, and sorry for the delay in reviewing.

I've stared at the code, and it looks good to me (very clean code, 
if I may say so :-) ) - the openvpn code is definitely good, the iservice 
code "looks reasonable", though I might be missing some windows intricacies.

Compile-tested on my mingw test environment, but have not run it yet - I'm 
going to be lazy and wait for Samuli's build snapshot.

Your patch has been applied to the master branch.

commit 3e42a558103e4e3f45ed28ccb761cefed20e8247 (master)
Author: Selva Nair
Date:   Thu Mar 10 23:47:26 2016 -0500

     Add support for register-dns through interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1457671646-4322-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11354
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


