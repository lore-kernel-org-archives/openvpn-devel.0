Date: Fri, 10 Sep 2021 11:52:30 +0200 (CEST)
Message-Id: <202109100952.18A9qUJn050335@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210818213354.687736-1-arne@...1227...>
References: <20210818213354.687736-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Detect unusable ciphers on
 patched OpenSSL of RHEL/Centos
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

Thanks for the test on CentOS 8.  I have skimmed the code, but since
I have no FIPS enabled OpenSSL around, haven't tested anything.

Your patch has been applied to the master branch.

commit 8f25cefea15481cc0338bca40a89d96fbe745b9f
Author: Arne Schwabe
Date:   Wed Aug 18 23:33:53 2021 +0200

     Detect unusable ciphers on patched OpenSSL of RHEL/Centos

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20210818213354.687736-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22746.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


