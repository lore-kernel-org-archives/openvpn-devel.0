Date: Mon, 13 May 2024 17:23:54 +0200 (CEST)
Message-Id: <202405131523.44DFNsrP096318@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240508220540.12554-1-gert@...1296...>
References: <20240508220540.12554-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Workaround issue in LibreSSL
 crashing when enumerating digests/ciphers
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

This is one of many not-so-good approaches to the problem, but 
LibreSSL upstream says "can not backport to OpenBSD 7.5" and since we
just got a new and shiny OpenBSD 7.5 buildbot, everything fails without
this patch... we can remove it from master as soon as OpenBSD 7.6 is
there (+ the buildbot upgraded).

Tested on FreeBSD with OpenSSL 1.1 & 3.0, and OpenBSD 7.5, of course :)

Your patch has been applied to the master and release/2.6 branch.

commit b3a271b11723cbe520ad4ce6b4b0459de57ade06 (master)
commit 8aed156be81a3bdd3098bfed5e8f95662d06633c (release/2.6)
Author: Arne Schwabe
Date:   Thu May 9 00:05:40 2024 +0200

     Workaround issue in LibreSSL crashing when enumerating digests/ciphers

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240508220540.12554-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28649.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


