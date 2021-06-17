Date: Thu, 17 Jun 2021 16:01:47 +0200 (CEST)
Message-Id: <202106171401.15HE1lIq005140@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210617061226.244-1-lstipakov@...277...>
References: <20210617061226.244-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_openssl.c: disable
 explicit initialization on Windows (CVE-2121-3606)
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

As discussed in the meeting yesterday - this might break people's use
of OpenSSL engines on windows, but we assume that the amount of users
of that will be "close to zero".  For these cases we can find a better
approach after 2.5.3 release.

Your patch has been applied to the master and release/2.5 branch.

commit abd5ee9b7dc4ba85438da5d16bb7dfb31714dac7 (master)
commit 447cfb4f30fd96126f7d2945cd14ef39cc13a08a (release/2.5)
Author: Lev Stipakov
Date:   Thu Jun 17 09:12:26 2021 +0300

     crypto_openssl.c: disable explicit initialization on Windows (CVE-2121-3606)

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210617061226.244-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22568.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


