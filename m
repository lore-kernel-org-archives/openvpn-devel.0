Date: Fri, 12 Dec 2025 13:52:38 +0100 (CET)
Message-Id: <202512121252.5BCCqcdh010432@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251212120352.17402-1-gert@...1296...>
References: <20251212120352.17402-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbuf: Add unit tests
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

Additional unit tests are good, especially when we have no real test
coverage for this important data structure yet.

The approach of having memory-intensive tests be disabled by default
(and be disabled by the standard unix build) is also useful - smaller
systems would have spurious failures that scare people, with little
gain.

I had some reservations about the ASSERT()s being added - but I have
come to the conclusion that they are fine.  One is needed to test the
maximum allocation size, and the other one can never fire in the
current source (because both callers pass in a pointer to a local
variable).

A quick local (autoconf) test passes, BB is also all green.

Your patch has been applied to the master branch.

commit 75cc34eccca990a2efbaa02639311def6b2cd70f
Author: Frank Lichtenheld
Date:   Fri Dec 12 13:03:46 2025 +0100

     mbuf: Add unit tests

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1432
     Message-Id: <20251212120352.17402-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35050.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


