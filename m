Date: Tue, 21 Jul 2020 18:23:22 +0200 (CEST)
Message-Id: <202007211623.06LGNMiX048979@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200720113010.10450-1-davids@...515...>
References: <20200720113010.10450-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove
 --client-cert-not-required
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

Another easy one for me to grab :-)

Adjusted Changes.rst context to apply, looked at patch, did a test
build.  Agree to the M_FATAL, this is important here to see what is
wrong right away, before having client connects fail.

People will scream at you anyway.

Fixed one grammar error

     msg(M_USAGE, "--verify-client-cert requires --mode server");
                                               ^^

Your patch has been applied to the master branch.

commit 08469ca1eccc5f0ba68edf5166497ac2efcb72c5
Author: David Sommerseth
Date:   Mon Jul 20 13:30:10 2020 +0200

     Remove --client-cert-not-required

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200720113010.10450-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20502.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


