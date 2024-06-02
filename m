Date: Sun, 2 Jun 2024 17:50:30 +0200 (CEST)
Message-Id: <202406021550.452FoU3I061198@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <AE20A784-506C-488B-9302-2D3AE775B168@...2219...>
References: <AE20A784-506C-488B-9302-2D3AE775B168@...2219...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow to set ifmode for
 existing DCO interfaces in FreeBSD
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
To: Franco Fichtner <franco@...2219...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for the patch, and the explanation on IRC.  This is FreeBSD/DCO
specific, and makes the case

  ifconfig ovpn3 create
  openvpn --dev ovpn3 --dev-type tun --topology subnet ...

work correctly (without it, p2p ifconfig claims to work but ipv6 route
addition fails as well).

I have stared at the code (looks good) and tested on my FreeBSD 14/DCO
test VM with and without the patch, adding relevant test cases to the
t_client.rc setup.  With the patch, nothing breaks ;-) and the newly
considered cases work.

There is a slight catch - if the interface (ovpn3) has already been
brought "up", the dco_set_ifmode() call fails with 

  2024-06-02 14:54:06 dco_set_ifmode: failed to set ifmode=00008002: Device busy (errno=16)

.. so it will not work properly in all cases.

(Also, t_client.sh is not really suited for this sort of test today,
as the "compare pre/post ifconfig state" check fails on interface flags
- need to think more how to make this work)


The patch got badly whitespace mangled in transit (empty lines got
turned into extra indent in the following line, and thus).  As I said
on IRC, I'm happy to fix that for occasional submitters, but generally
recommend "git send-email" or pushing to gerrit to avoid outlook induced
garbage.

Your patch has been applied to the master and release/2.6 branch
(highly localized, and arguably a bugfix).

commit 82036c17c45d45c3fe8725f64b33720cb9c94dad (master)
commit 2f2ff186564c3999efaf48d734df95471ac22d84 (release/2.6)
Author: Franco Fichtner
Date:   Tue May 28 17:42:52 2024 +0000

     Allow to set ifmode for existing DCO interfaces in FreeBSD

     Signed-off-by: Franco Fichtner <franco@...2219...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <AE20A784-506C-488B-9302-2D3AE775B168@...2219...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28688.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


