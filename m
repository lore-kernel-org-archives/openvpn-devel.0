Date: Mon, 22 Oct 2018 20:37:14 +0200 (CEST)
Message-Id: <201810221837.w9MIbEKK048744@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1540203571-17646-1-git-send-email-lstipakov@...277...>
References: <1540203571-17646-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce openvpn_swprintf()
 with nul termination guarantee
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

Your patch has been applied to the master branch.

I'm not sure I totally like the change to buffer.c/tun.c - for the
single instance where this is called inside openvpn/tun.c, on WIN32, 
we now carry around a new function in buffer.c which is compiled 
everywhere... possibly breaking older systems that have C99 compliant
C compilers but no full C99 library - like my oldest OpenBSD 
buildslave (our mantra on that is "if it breaks for good reasons, 
it will be retired, but we shouldn't carelessly break things").

So if we really want to keep this, it should be #ifdef _WIN32 (until
we find good uses for wide-sprintf() on other platforms).


For the service, which is windows-only code, this change is clearly 
reasonable and beneficial.

commit 43a5a4f3b4e411419639c195fee8a76495fdc88e
Author: Lev Stipakov
Date:   Mon Oct 22 13:19:31 2018 +0300

     Introduce openvpn_swprintf() with nul termination guarantee

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1540203571-17646-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17786.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


