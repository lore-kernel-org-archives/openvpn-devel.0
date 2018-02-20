Date: Tue, 20 Feb 2018 10:41:08 +0100 (CET)
Message-Id: <201802200941.w1K9f8NK054824@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180201154521.7642-1-steffan@...1856...>
References: <20180201154521.7642-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable stricter compiler
 warnings by default
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

Tested on FreeBSD 10, Linux and, indeed, AIX 7 :-) - Linux/gcc is nicely
clean, FreeBSD/clang finds a few that are silly and want fixing...

    ../../../openvpn/src/openvpn/push.c:42:13: warning: unused variable
	  'push_reply_cmd' [-Wunused-variable]
    static char push_reply_cmd[] = "PUSH_REPLY";

    ../../../openvpn/src/openvpn/ssl_verify.c:1222:1: warning: unused label
	  'cleanup' [-Wunused-label]
    cleanup:

AIX 7 with gcc has quite a few warnings, but those are "AIX is annoying"
style things like these two:

    options.c:4947:16: warning: missing braces around initializer [-Wmissing-braces]
    options.c:4947:16: warning: (near initialization for 'remote.u6_addr') [-Wmissing-braces]

    tun.c:1791:13: warning: implicit declaration of function 'if_nametoindex' [-Wimplicit-function-declaration]

and interesting enough, one that should have been visible on the other
platforms as well - maybe different OpenSSL version?

    ssl_openssl.c: In function 'backend_tls_ctx_reload_crl':
    ssl_openssl.c:967:13: warning: value computed is not used [-Wunused-value]

.. but overall, AIX is much less noisy than I would have expected
(like, 20 warnings in total, half of them format warnings that Selva's
patch will address).  Good :-)


I have applied the patch to release/2.4 as well, as my worries about
"breaking some platform that previously was compiling nicely" shouldn't
be triggered (this is just turning on *warnings*, after all), and also
because the amount of warnings triggered is so small.


commit adbf68c00bf40089489c5e039138f855fc5e2392 (master)
commit b9d186211c87f52711592f1c29399a088912bf39 (release/2.4)
Author: Steffan Karger
Date:   Thu Feb 1 16:45:21 2018 +0100

     Enable stricter compiler warnings by default

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20180201154521.7642-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16426.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


