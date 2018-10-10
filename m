Date: Wed, 10 Oct 2018 21:38:56 +0200 (CEST)
Message-Id: <201810101938.w9AJcuGb079810@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181007215539.32761-1-arne@...1227...>
References: <20181007215539.32761-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for
 tls-ciphersuites for TLS 1.3
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

Your patch has been applied to the master branch and release/2.4 branch
(long-term compatibility, as agreed last weekend - and it's nicely 
isolated, so if you are not using the new option, nothing changes).

WRT Steffan's formatting nits on v3 - these are unchanged here in v4,
but the *next* TLS 1.3 patch will also pick *these* nits, so I decided
to pass through both patches "as is", instead of changing this one and
then the next one too just to move a whitespace change to a different
commit...  so yes, code formatting ghosts, come haunt me.

Test built on FreeBSD with OpenSSL 1.0.2 and on Linux with OpenSSL 1.1.1
and mbedTLS.  Some cursory tests but no full TLS 1.3 ciphersuites tests.

commit ea4ee31333a0cddb5c8dd4185f9426df13c76947 (master)
commit 9de7fe0a7bf1111ebea9ca9e28b2def9ae3e53ff (release/2.4)
Author: Arne Schwabe
Date:   Sun Oct 7 23:55:39 2018 +0200

     Add support for tls-ciphersuites for TLS 1.3

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20181007215539.32761-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17626.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


