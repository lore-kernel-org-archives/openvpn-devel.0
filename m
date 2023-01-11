Date: Wed, 11 Jan 2023 16:05:39 +0100 (CET)
Message-Id: <202301111505.30BF5dLY086502@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230111134439.1107915-1-arne@...1227...>
References: <20230111134439.1107915-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate OCC checking
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

Acked-by: Gert Doering <gert@...1296...>

I have stared-at-code a bit (looks reasonable) and ran a few manual
tests - without the patch, one of my t_client instances triggers
this (with verb 3):

2023-01-11 15:42:41 WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1542', remote='link-mtu 1558'

With the patch it needs "verb 7" to be seen -> works as it says on the lid.

As there is nothing in the patch that really changes anything but log-levels
and adds proper {} braces on these #ifdef ... / else / #endif constructs
I haven't done a "full scale server test".

Your patch has been applied to the master and release/2.6 branch.

commit 2104ea62430e4d203f2cd998e053f4192798b9f1 (master)
commit bfd0ef36c46f8326e40229328b5e35cc50755921 (release/2.6)
Author: Arne Schwabe
Date:   Wed Jan 11 14:44:39 2023 +0100

     Deprecate OCC checking

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230111134439.1107915-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25970.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


