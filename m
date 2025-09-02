Date: Tue, 2 Sep 2025 19:00:45 +0200 (CEST)
Message-Id: <202509021700.582H0jTp071514@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902164521.23145-1-gert@...1296...>
References: <20250902164521.23145-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: validate tun
 interface before fetching stats
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested this on ubuntu 20.04 + DCO -  --client + --management-hold, connect
to mgmt, "bytecount 1", "hold release", boom, SIGSEGV.

v1 looked correct, but checked the wrong variables, so "no SIGSEGV, but
no counters at all anymore", not so good either ;-)  - v2 fixes that,
no crash *and* working counters.  With proper timing.  So really getting
there, after a day staring at manage.c...

Your patch has been applied to the master branch.

commit 14ced61eef89797e606c3b7600adc4da83a336f4
Author: Ralf Lici
Date:   Tue Sep 2 18:45:15 2025 +0200

     dco_linux: validate tun interface before fetching stats

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250902164521.23145-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32768.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


