Date: Wed, 13 Jul 2022 14:55:39 +0200 (CEST)
Message-Id: <202207131255.26DCtdQj085032@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220713124332.16147-1-a@...2181...>
References: <20220713124332.16147-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking: add net_iface_type
 API
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for the v3 changes.

I tested v2 very thoroughly on "non sitnl" builds (FreeBSD, Linux with
--enable-iproute2) to make sure this really only affects sitnl - and
that has not changed with v3.  What has changed is "-errno", typo fix
in the commit message, and the extra test for "what happens if the
interface does not exist?" - these have been tested in a sitnl build,
and pass.

OpenVPN itself does not yet use that new function, only the unit test.

As agree on IRC, we do not touch the bash-nature of t_net.sh today -
we might want to move to "more POSIX" one day, but today Linux systems
are assumed to have bash, and this is really linux (+sitnl) only.

Your patch has been applied to the master branch.

commit 26b6b6f0673fa1f3806c447a18bb0f705b231b35
Author: Antonio Quartulli
Date:   Wed Jul 13 14:43:32 2022 +0200

     networking: add net_iface_type API

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220713124332.16147-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24688.html
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


