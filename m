Date: Mon, 16 Feb 2026 16:26:44 +0100 (CET)
Message-Id: <202602161526.61GFQibK068641@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260216151033.16585-1-gert@...1296...>
References: <20260216151033.16585-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Mbed TLS 3: Remove prediction
 resistance option
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
To: Max Fillinger <maximilian.fillinger@...2918...>
Cc: openvpn-devel@lists.sourceforge.net

We had a bit of discussion on this in the GH issue (964), and it turns
out that it's unclear why this was considered necessary at all, and is
certainly not required with modern mbedTLS 3.x versions, and to the
contrary, quite excessive wrt system random use.  mbedTLS 4.x does not
support that, mbedTLS 2.x is no longer supported by us, so out with this.

BB and GHA test various mbedTLS versions, but neither will call 
"--use-prediction-resistance", so wrt testing, this is a no-op.

I think we should apply this to release/2.7 as well, since this is sort
of cleanup that only affects a small number of builds, and even there,
it's not turned-on-by-default... you might see a followup e-mail here.

Your patch has been applied to the master branch.

commit 880bd69254a3e0975f4da215367be4ae4ef6053c (master)
Author: Max Fillinger
Date:   Mon Feb 16 16:10:27 2026 +0100

     Mbed TLS 3: Remove prediction resistance option

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1530
     Message-Id: <20260216151033.16585-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35658.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


