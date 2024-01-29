Date: Mon, 29 Jan 2024 14:55:05 +0100 (CET)
Message-Id: <202401291355.40TDt5fG031508@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240129105358.11161-1-gert@...1296...>
References: <20240129105358.11161-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_user_pass: Add UTs for
 character filtering
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

Tested locally and with GHA.  I expect the UTF8 codes in our source to
create issues at some point (because software is so... helpful), but
it's only the test code, and if that happens, we can move to \xbb\xa4
(etc.) in the strings...

Your patch has been applied to the master branch.

commit 55418bf62eaff1c4323d206181cd8a5f88e7c6c7
Author: Frank Lichtenheld
Date:   Mon Jan 29 11:53:57 2024 +0100

     test_user_pass: Add UTs for character filtering

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240129105358.11161-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20240129105358.11161-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


