Date: Wed, 21 Jun 2023 14:34:52 +0200 (CEST)
Message-Id: <202306211234.35LCYqox061029@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230619132934.76085-4-frank@...2641...>
References: <20230619132934.76085-4-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: unit_tests: Add missing
 cert_data.h to source list for unit tests
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"make sense".  Verified that it still builds ;-) - and adds this extra
file to the tarball.

The patch does not apply to release/2.6, because the whole pkey_test_utils.c
part is not part of 2.6.

Your patch has been applied to the master branch.

commit 97223cb057a0edfafd28b34427449bb3eda7d0be
Author: Frank Lichtenheld
Date:   Mon Jun 19 15:29:33 2023 +0200

     unit_tests: Add missing cert_data.h to source list for unit tests

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230619132934.76085-4-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26750.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


