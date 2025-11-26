Date: Wed, 26 Nov 2025 19:33:53 +0100 (CET)
Message-Id: <202511261833.5AQIXrjC040640@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251126114047.10280-1-gert@...1296...>
References: <20251126114047.10280-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: error: Allow status argument to
 check_status to be ssize_t
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

Most of this is really straightforward.

The "int64_t" for register_activity() seems a bit excessive ("we know
that whatever comes back there will not be larger than 1 IP packet, so
64kbytes max...") - but then, this is all inlined, and the compiler can
do whatever his integer rules make it feel happy, and efficient.

Your patch has been applied to the master branch.

commit ea2f8ef6fa19e7619e3dc2e7addc1a067f472abc
Author: Frank Lichtenheld
Date:   Wed Nov 26 12:40:40 2025 +0100

     error: Allow status argument to check_status to be ssize_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1357
     Message-Id: <20251126114047.10280-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34701.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


