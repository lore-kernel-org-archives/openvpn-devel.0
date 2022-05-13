Date: Fri, 13 May 2022 09:23:43 +0200 (CEST)
Message-Id: <202205130723.24D7NhI1093690@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220512121429.2096164-7-arne@...1227...>
References: <20220512121429.2096164-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix allowing/showing
 unsupported ciphers and digests
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

Acked-by: Gert Doering <gert@...1296...>

Code is close enough to the master version, and it nicely does what it
says ("openvpn --providers legacy --show-ciphers" vs. "--show-ciphers").

While this fixes the "cipher loopback test", it now breaks 
tls_crypt_testdriver, as that one expects BF-CBC to be universally
available...

Unsupported cipher in --data-ciphers: BF-CBC
Unsupported cipher in --data-ciphers: BF-CBC
[  ERROR   ] --- Test failed with exception: Segmentation fault(11)

.. to be fixed in 7/7.

(Breakage only in 3.0.x builds, of course, 1.1.x builds are fine)

Fixed one spurious newline, and another uncrustify complaint
introduced by crypto_unload_provider().

Your patch has been applied to the release/2.5 branch.

commit 3690939126cf84b166157bad96e724caea61346d
Author: Arne Schwabe
Date:   Thu May 12 14:14:28 2022 +0200

     Fix allowing/showing unsupported ciphers and digests

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220512121429.2096164-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24334.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


