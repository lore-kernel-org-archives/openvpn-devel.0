Date: Fri, 25 Apr 2025 15:21:30 +0200 (CEST)
Message-Id: <202504251321.53PDLULX030917@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250425131002.21772-1-gert@...1296...>
References: <20250425131002.21772-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix mbed TLS key exporter
 functionality in 3.6.x and cmake
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

This is basically a cmake build system fix (no code changes) together 
with code safeguards that we do not end up in a SIGSEGV because parts
of the code assume "key exporter present" and the actual calls are
not there...  haven't tested this myself, but the buildbots have
(and the macOS buildbot uncovered this originally).

Your patch has been applied to the master branch.

commit f563556bbfee729053d5c123ebc1bad6277f4c65
Author: Arne Schwabe
Date:   Fri Apr 25 15:09:54 2025 +0200

     Fix mbed TLS key exporter functionality in 3.6.x and cmake

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250425131002.21772-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31510.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


