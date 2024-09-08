Date: Sun, 8 Sep 2024 23:13:48 +0200 (CEST)
Message-Id: <202409082113.488LDmce004974@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906103814.36839-1-frank@...2641...>
References: <20240906103814.36839-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add a test for loading
 certificate and key to ssl context
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Testing this one was easy - look at the patch "only test code affected",
and run "make check" on a few different machines :-) - passes FreeBSD + ossl3,
FreeBSD + mbedTLS, FreeBSD + ossl 1.1.1w, Gentoo + ossl 1.1.1 (and all
the GH builds, with various OpenSSL and mbedTLS versions).

Your patch has been applied to the master branch.

release/2.6 does not have enough backported unit test code for this to
apply (but given the way our patches flow, always master -> release/x,
this is not a big loss).

commit 0fe3a9877468ecfb3b97c67ecca5495eed7a8683 (master)
Author: Selva Nair
Date:   Fri Sep 6 12:38:14 2024 +0200

     Add a test for loading certificate and key to ssl context

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240906103814.36839-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29074.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


