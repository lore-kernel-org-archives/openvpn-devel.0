Date: Mon, 8 Dec 2025 12:33:46 +0100 (CET)
Message-Id: <202512081133.5B8BXkLQ007936@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251207210529.9949-1-gert@...1296...>
References: <20251207210529.9949-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Prevent crash on invalid
 server-ipv6 argument
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
To: Klemens Nanni <kn@...2273...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for your patch.  

Repeating what was said in https://github.com/OpenVPN/openvpn/pull/930,
for the sake of the archives - on FreeBSD and Linux, this does not crash,
because the libraries handle "ai == NULL" gracefully.  The FreeBSD 
implementation mentions that the standard is not clear, so OpenBSD is
free to crash on us.

This said, we do guard all other paths to freeaddrinfo() (either because
the call is only on the "success" branch, or with an explicit check) - so
this is a good fix to make our code consistent.

Your patch has been applied to the master and release/2.6 branch.

commit 0ff66c056f951dcf01cf6ccb3e9b21948e5ca5ad (master)
commit 09c35f8421028ce8aed4895a526c2f4c4b4be01b (release/2.6)
Author: Klemens Nanni
Date:   Sun Dec 7 22:05:18 2025 +0100

     Prevent crash on invalid server-ipv6 argument

     Signed-off-by: Klemens Nanni <kn@...2273...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1418
     Message-Id: <20251207210529.9949-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34870.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


