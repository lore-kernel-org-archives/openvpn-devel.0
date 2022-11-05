Date: Sat, 5 Nov 2022 19:02:22 +0100 (CET)
Message-Id: <202211051802.2A5I2M87077747@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220921104930.3452270-3-arne@...1227...>
References: <20220921104930.3452270-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add unit test for
 reliable_get_num_output_sequenced_available
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

This adds the unit test for the previously introduced new function - 
and applies nicely on "v6 1/2".  Tested on FreeBSD and Linux, and
"it passes".

..
[ RUN      ] test_get_num_output_sequenced_available
[       OK ] test_get_num_output_sequenced_available
[==========] 7 test(s) run.
[  PASSED  ] 7 test(s).
PASS: packet_id_testdriver

Since this got an ACK from Frank, I did not spend much stare-at-code
to verify that it actually tests something useful - I *have* found a
tab error in tests/unit_tests/openvpn/Makefile.am, though, and fixed
on the fly :-)


Your patch has been applied to the master branch.

commit a5a30ec311ce9d0dbcd6162daab97a225189d570
Author: Arne Schwabe
Date:   Wed Sep 21 12:49:30 2022 +0200

     Add unit test for reliable_get_num_output_sequenced_available

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220921104930.3452270-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25292.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


