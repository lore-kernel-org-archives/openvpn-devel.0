Date: Mon, 30 Mar 2026 14:55:09 +0200 (CEST)
Message-Id: <202603301255.62UCt9jY037820@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260330113826.20057-1-gert@...1296...>
References: <20260330113826.20057-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: wfp_block: Avoid sign-compare
 warning with Fwpm* return types
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

A bit of an annoyance, but still an easy one, and one set of #pragmas
gone...

Compile-tested on Ubuntu 24.04 / MinGW.

Your patch has been applied to the master branch.

commit 88325a9a75cc27af225a5ed215ad76fd76e8c9b0
Author: Frank Lichtenheld
Date:   Mon Mar 30 13:38:19 2026 +0200

     wfp_block: Avoid sign-compare warning with Fwpm* return types

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1506
     Message-Id: <20260330113826.20057-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36337.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


