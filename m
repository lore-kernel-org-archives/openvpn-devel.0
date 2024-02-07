Date: Wed, 7 Feb 2024 11:06:14 +0100 (CET)
Message-Id: <202402071006.417A6E3E024647@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240124152739.28248-1-kprovost@...2661...>
References: <20240124152739.28248-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-freebsd: dynamically
 re-allocate buffer if it's too small
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stare-at-code looks good :-) - there's one possible catch should realloc()
return NULL - in that case we'd pass drv.ifd_data = NULL to the kernel - but
I'm reasonably sure the kernel will then not crash but return EINVAL.

I do not have a sufficient number of clients on a FreeBSD 14 system today
to trigger the original problem, but I can attest that the new dynamic
code will do the right thing - I tested this by reducing the start allocation
to 1 byte and see it grow to 1024 (test with 2 clients, 512 sufficient
for 1 client).

(Also, master+patch passes the full server test rig on FreeBSD 14)

Your patch has been applied to the master and release/2.6 branch (bugfix)

commit 62676935d738f74908845ca96819a36a8c0c230e (master)
commit d8faf568d237667c66141e2c3f6df3f999aa02bd (release/2.6)
Author: Kristof Provost
Date:   Wed Jan 24 16:27:39 2024 +0100

     dco-freebsd: dynamically re-allocate buffer if it's too small

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240124152739.28248-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28128.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


