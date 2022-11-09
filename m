Date: Wed, 9 Nov 2022 13:48:41 +0100 (CET)
Message-Id: <202211091248.2A9Cmfv6026858@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221109115208.1248948-1-arne@...1227...>
References: <20221109115208.1248948-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix md_kt_size in mbed TLS when
 queried for size of none
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

Verified that this fixes the (mbedtls-only) crash I was seeing
with --verb 7 - and verified again that it does not happen with
OpenSSL builds:

    Master Encrypt (cipher): 6359ae14 b7069ef7 ...
    Master Encrypt (hmac): 
    Master Decrypt (cipher): 5217f7a8 c3f80df5 ...
    Master Decrypt (hmac): 

Your patch has been applied to the master branch.

commit 6ff2d63c7943b2d7e150c3934b4e789fb5d1e0c0
Author: Arne Schwabe
Date:   Wed Nov 9 12:52:08 2022 +0100

     Fix md_kt_size in mbed TLS when queried for size of none

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221109115208.1248948-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25494.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


