Date: Tue, 27 Jun 2023 16:59:50 +0200 (CEST)
Message-Id: <202306271459.35RExoZM096512@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230626130939.3267280-1-sergey.korolev@...2736...>
References: <20230626130939.3267280-1-sergey.korolev@...2736...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-linux: fix counter print
 format
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
To: Sergey Korolev <sergey.korolev@...2736...>
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this beyond "does it still compile?", but a quick
glance at the changes and the definitions agrees with Antonio's ACK.

Your patch has been applied to the master and release/2.6 branches.

commit 330bef679544b6a22d16a800c898927a785d74fc (master)
commit fa434643534d506c834df3eb1dbb6073fb74b9f4 (HEAD -> release/2.6)
Author: Sergey Korolev via Openvpn-devel
Date:   Mon Jun 26 16:09:39 2023 +0300

     dco-linux: fix counter print format

     Signed-off-by: Sergey Korolev <sergey.korolev@...2736...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20230626130939.3267280-1-sergey.korolev@...2736...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26767.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


