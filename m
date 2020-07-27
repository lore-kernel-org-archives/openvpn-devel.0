Date: Mon, 27 Jul 2020 16:14:26 +0200 (CEST)
Message-Id: <202007271414.06REEQlc082928@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200717171818.230371-1-matthias.andree@...68...>
References: <20200717171818.230371-1-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix stack buffer overruns in
 NEXTADDR() macro:
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch
(bugfix).

Thanks for the fix.  Yes, this was "very obvious in hindsight".

To my defense, I can only argue that it's always been that way -
while I was the last one to touch that line (in 2ff366f78), 
the *order* of operations was "always like this"...

-            l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
+            l = ROUNDUP( ((struct sockaddr *)&(u))->sa_len); memmove(cp, &(u), l); cp += l;\

.. anyway.  I have tested your fix on all platforms that use this
code path and which I had available, which is 

 - FreeBSD 7.4/amd64           (works)
 - FreeBSD 11.3/amd64          (works)
 - FreeBSD 12.1/amd64          (works)
 - FreeBSD 12.1/i386           (works)
 - FreeBSD 12.x/sparc64        (postponed, hardware down)
 - FreeBSD 12.1/arm64 (rPI 3)  (works)
 - NetBSD 8.1/i386 (turns out to be broken before and after)
     ("GDG6: problem writing to routing socket", already trac #734)
 - OpenBSD 6.5/amd64           (works)
 - MacOS Mojave/amd64          (works)
 - MacOS 10.5/i386             (works)   [only tested 2.4]

and the code is excercised by "openvpn --show-gateway" (and by 
the internal user of this, "do we need an IPv6 redirect route").

OpenSolaris, Linux and Windows use different code paths.

(The OpenSolaris NEXTADDR() actually has the same problem, just
nobody noticed it so far - so I'll send a followup patch to fix
it over there as well)


commit 5fde831c580775aa5c1fe3539b06260d994eee10 (master)
commit 7c428ca19a8df6b9630734eafce1132f457be951 (release/2.4)
Author: Matthias Andree
Date:   Fri Jul 17 19:18:18 2020 +0200

     Fix stack buffer overruns in NEXTADDR() macro:

     Signed-off-by: Matthias Andree <matthias.andree@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200717171818.230371-1-matthias.andree@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20461.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


