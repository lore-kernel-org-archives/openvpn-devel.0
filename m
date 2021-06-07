Date: Mon, 7 Jun 2021 21:41:48 +0200 (CEST)
Message-Id: <202106071941.157JfmTG054220@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210607184820.343-1-lstipakov@...277...>
References: <20210607184820.343-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: options.c: fix msvc build error
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Yeah, windows... sorry for breaking MSVC again, thanks for fixing 
the typo :-) - only compile-tested on FreeBSD.

(Adding Selva's ACK on v1, for good measure)

Your patch has been applied to the master branch.

commit 88395a8307964ad48c3841c0b2fb60dce826ebf1
Author: Lev Stipakov
Date:   Mon Jun 7 21:48:20 2021 +0300

     options.c: fix msvc build error

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: selva.nair@...277...
     Message-Id: <20210607184820.343-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22506.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


