Date: Mon, 25 Mar 2024 18:22:41 +0100 (CET)
Message-Id: <202403251722.42PHMfdf043432@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240325071448.12143-1-gert@...1296...>
References: <20240325071448.12143-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: phase2_tcp_server: fix Coverity
 issue 'Dereference after null check'
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

This is arguably a correct fix, though we could go a bit further in
terms of refactoring and fully get rid of signal_received - if my
understanding of the code is correct, it's only passed to a single
function (socket_listen_accept()), which is only called from here - 
so "just pass on sig_info and use that" would be a bit less convoluted.

But that's refactoring, so for future master...

Lightly tested on the server framework.

Your patch has been applied to the master and release/2.6 branch.

commit e8c629fe64c67ea0a8454753be99db44df7ce53e (master)
commit 5591af17694d98054da2cdf4cfd42508a8a4fb8e (release/2.6)
Author: Frank Lichtenheld
Date:   Mon Mar 25 08:14:48 2024 +0100

     phase2_tcp_server: fix Coverity issue 'Dereference after null check'

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240325071448.12143-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28452.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


