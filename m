Date: Mon, 20 Jan 2020 20:19:06 +0100 (CET)
Message-Id: <202001201919.00KJJ6oE022117@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <E1itVts-0007ZG-NO@...2479...>
References: <E1itVts-0007ZG-NO@...2479...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move keying material exporter
 check from syshead.h to configure.ac
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
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(This time, I did actually test an mingw build :-) - plus Linux+OpenSSL
and FreeBSD+mbedtls 2.16.  Gentoo 2.19 is still not fixed Distro-Upstream)

As a side note, the message-id: below is what I received the mail
with, which does not look like "it was sent with that" - but Lev referenced
this message-ID, so that's what the archives have...

commit 5defbba4787ce2713ac3abc99e1b140731b761d6
Author: Steffan Karger
Date:   Mon Jan 20 12:55:18 2020 +0100

     Move keying material exporter check from syshead.h to configure.ac

     Signed-off-by: Steffan Karger <steffan.karger@...2507...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <E1itVts-0007ZG-NO@...2479...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19328.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


