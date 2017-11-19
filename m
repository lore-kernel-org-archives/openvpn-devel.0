Date: Sun, 19 Nov 2017 21:37:56 +0100 (CET)
Message-Id: <201711192037.vAJKbuHH080370@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171112163636.17434-1-steffan@...1856...>
References: <20171112163636.17434-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile option
 for mbedtls builds
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

.. of course this conflicts with o->renegotiate_seconds_min...

Nevertheless, thanks for the patch :-) - it makes my FreeBSD 10.3 
(mbedTLS 2.6) buildslave now happy again (on the default settings - with
--tls-cert-profile preferred, it refuses the old-hash cert, as it should).

Also tested with openssl 1.0.1, where it warns and does nothing, as
expected.  Good :-)

Commit subject amended according to Antonio's comment.

Your patch has been applied to the master and release/2.4 branch.

commit aba758740d26224b7b3957df221def7ab80c5802 (master)
commit 8bcabf0a1621e6ccc7a44465a73de29fd2d541b3 (release/2.4)
Author: Steffan Karger
Date:   Sun Nov 12 17:36:36 2017 +0100

     Add --tls-cert-profile option.

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20171112163636.17434-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15848.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


