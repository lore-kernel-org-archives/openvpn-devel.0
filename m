Date: Thu, 9 Jul 2020 17:52:01 +0200 (CEST)
Message-Id: <202007091552.069Fq1mb010309@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200709101603.11941-1-arne@...1227...>
References: <20200709101603.11941-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate ncp-disable and add
 improved ncp to Changes.rst
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Taken the review by Antonio and the subsequent discussion on IRC on 
"where should the message go?" - we leave it where it is, because all the
other DEPRECATED OPTIONS warnings are done the same way (except keysize).

Typos fixed, message wrapped slightly differently to avoid line wrap.

Not checked in any significant way (besides "make" compile test, just to be
sure I didn't break anything).

Your patch has been applied to the master branch.

commit 2b09c1405fdfffe15b2b444b15cce7820263a048
Author: Arne Schwabe
Date:   Thu Jul 9 12:15:56 2020 +0200

     Deprecate ncp-disable and add improved ncp to Changes.rst

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200709101603.11941-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20257.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


