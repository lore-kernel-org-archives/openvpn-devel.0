Date: Wed, 25 Dec 2024 17:07:37 +0100 (CET)
Message-Id: <202412251607.4BPG7bc4030564@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <dcc7e538-2035-4697-b306-10eb470632f3@...68...>
References: <dcc7e538-2035-4697-b306-10eb470632f3@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support IPv6 towards port-share
 proxy receiver
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
To: Corubba Smith <corubba@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is a nice min-feature, to improve on IPv6 support in OpenVPN - thanks.

I have stared at the code ("looks reasonable") and then actually set up
a port-share test setup, with a v6-only lighttpd behind an OpenVPN port-share,
and "it just works"

    Dec 25 16:59:53 TCP connection established with [AF_INET6]2001:608:4::ce:c0f:54067
    Dec 25 16:59:53 TCPv6_SERVER link remote: [AF_INET6]2001:608:4::ce:c0f:54067
    Dec 25 16:59:53 2001:608:4::ce:c0f Non-OpenVPN client protocol detected

.. it doesn't show the target here, but the connection arrives, and is
also documented properly in the "[dir]"

# ls -l
-rw-r----- 1 root root   34 Dec 25 17:00 '[AF_INET6]::1:33956'
# cat *
[AF_INET6]2001:608:4::ce:c0f:54067

(the [AF_INET6] blob looks a bit confusing, but I guess this is the
way it has always been for the port-share status files - port numbers are
ugly as well, but indeed, this is a long-standing itch in our printing
routines)

I have adjusted From: and Signed-Off-By: of this patch to match the
later "v2" patches in the other series - full names are important for
us for correct attribution.

Your patch has been applied to the master branch.

commit 993449a3b6c0ae57c47844c9c19ea54633cbd914
Author: Corubba Smith
Date:   Sat Dec 14 20:56:56 2024 +0100

     Support IPv6 towards port-share proxy receiver

     Signed-off-by: Corubba Smith <corubba@...68...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <dcc7e538-2035-4697-b306-10eb470632f3@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30115.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


