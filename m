Date: Mon, 9 Mar 2020 14:22:44 +0100 (CET)
Message-Id: <202003091322.029DMi41093114@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200221100746.7065-1-arne@...1227...>
References: <20200221100746.7065-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move NCP related function into
 a seperate file and add unit tests
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

Your patch has been applied to the master branch.

Taking the ACK from Lev on the v4 patch, verified that v5 has the same
code changes ("diff -uw v4.txt v5.txt") and that the difference is indeed
only in the test module.

Tested on FreeBSD 11.3 / openssl 1.0.2s which does not have chacha20-poly
and *does* have AES-GCM.  The output is:

[ RUN      ] test_check_ncp_ciphers_list
Unsupported cipher in --ncp-ciphers: CHACHA20-POLY1305
Unsupported cipher in --ncp-ciphers: vollbit
Unsupported cipher in --ncp-ciphers: vollbit
[       OK ] test_check_ncp_ciphers_list

.. which looks good to me. 

Given David's comment about breakage on RHEL 7.7, I tried building
and testing on "CentOS 7.7.1908" with "OpenSSL 1.0.2k 19.el7", which 
hopefully relates.  It also passes nicely...

[==========] Running 4 test(s).
[ RUN      ] test_check_ncp_ciphers_list
Unsupported cipher in --ncp-ciphers: CHACHA20-POLY1305
Unsupported cipher in --ncp-ciphers: vollbit
Unsupported cipher in --ncp-ciphers: vollbit
[       OK ] test_check_ncp_ciphers_list

So, I consider David's NAK to be sufficiently addressed :-)


commit 1828f9c199cc8cdf4e9d8d0bf072e726604f69dc
Author: Arne Schwabe
Date:   Fri Feb 21 11:07:46 2020 +0100

     Move NCP related function into a seperate file and add unit tests

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200221100746.7065-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19499.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


