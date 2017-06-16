Date: Fri, 16 Jun 2017 09:57:39 +0200 (CEST)
Message-Id: <201706160757.v5G7vdnr099835@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1497574736-2092-1-git-send-email-gv@...2280...>
References: <1497574736-2092-1-git-send-email-gv@...2280...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix a null-pointer dereference
 in establish_http_proxy_passthru()
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
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  Stared-at-code, and ran normal proxy tests, not having
a malicious proxy at hand to actually trigger that error.

(And thanks for using git-send-email, makes my life much easier ;-) )

Your patch has been applied to the master, release/2.4, 2.3 and 2.2 branch
(2.2 and 2.3 with whitespace reformatting to match coding style).

commit 14865773ad64d861128bc80ad44c37bdc307c996 (master)
commit bf547b8ac79b15a2b2dc59e27c0cb2ade73a3941 (release/2.4)
commit 479b6d13d8c230c11b6315665bf00998a1424eef (release/2.3)
commit 0c8cf64cc141cbb417997aedbc401979ca71949b (release/2.2)
Author: Guido Vranken
Date:   Fri Jun 16 02:58:56 2017 +0200

     Fix a null-pointer dereference in establish_http_proxy_passthru()

     Signed-off-by: Guido Vranken <guidovranken@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1497574736-2092-1-git-send-email-gv@...2280...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14844.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


