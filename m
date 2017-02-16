Date: Thu, 16 Feb 2017 08:47:06 +0100 (CET)
Message-Id: <201702160747.v1G7l61Y058076@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170213183826.73008-1-O2Graphics@...2243...>
References: <20170213183826.73008-1-O2Graphics@...2243...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix building with LibreSSL
	2.5.1 by cleaning a hack. Similar to what is done in curl:
	https://github.com/curl/curl/blob/028391df5d84d9fae3433afdee9261d565900355/lib/vtls/openssl.c#L603-L619
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
To: O2 Graphics <olivierw.ml@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

Not sure if it is something we want in release/2.3, but it wouldn't apply
with "git cherry-pick" - too much formatting changes, so one would need
to do it manually ("but we knew this").

commit dcfd3b6173d8cdb4658de23db1dd0bd932b390d2 (master)
commit fb802b9b0d9366093b5567c0f3e9845b2f30e9cc (release/2.4)
Author: Olivier Wahrenberger
Date:   Mon Feb 13 19:38:26 2017 +0100

     Fix building with LibreSSL 2.5.1 by cleaning a hack.

     Signed-off-by: Olivier Wahrenberger <olivierw.ml@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170213183826.73008-1-O2Graphics@...2243...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14045.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


