Date: Tue, 7 Apr 2026 12:55:42 +0200 (CEST)
Message-Id: <202604071055.637Atg2H046592@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260407095044.28528-1-gert@...1296...>
References: <20260407095044.28528-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_buffer: Add test for
 buf_null_terminate
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

This is easy - it adds a test instance to one of the pre-existing unit
tests, the test works

[ RUN      ] test_buffer_null_terminate
[       OK ] test_buffer_null_terminate

.. and it does so on all the instances in buildbot.  In it goes...

Your patch has been applied to the master branch.

commit 798884d6df200c95b2c22de31860f3e35be617f7
Author: Frank Lichtenheld
Date:   Tue Apr 7 11:50:38 2026 +0200

     test_buffer: Add test for buf_null_terminate

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1580
     Message-Id: <20260407095044.28528-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36532.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


