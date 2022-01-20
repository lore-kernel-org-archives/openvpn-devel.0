Date: Thu, 20 Jan 2022 20:11:26 +0100 (CET)
Message-Id: <202201201911.20KJBQDY016143@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220119182126.56880-1-openvpn@...2080...>
References: <20220119182126.56880-1-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: Fix OPENSSL_FIPS
 enabled builds
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

We'll add build tests on Fedora / CentOS, as soon as September brings
the new buildbot infrastructure... so we get the "looks like FIPS but
isn't" stuff tested as well.  (cipher) changed as instructed on IRC.

Your patch has been applied to the master branch.

commit 544330fefedc87a74b4e17e105ad9151b8ad1dc9
Author: David Sommerseth
Date:   Wed Jan 19 19:21:26 2022 +0100

     crypto: Fix OPENSSL_FIPS enabled builds

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220119182126.56880-1-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23570.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


