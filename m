Date: Sat, 13 Aug 2022 20:57:13 +0200 (CEST)
Message-Id: <202208131857.27DIvDDd053495@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220812130657.29899-9-a@...2181...>
References: <20220812130657.29899-9-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: ovpn-dco: print some netlink
 messages to debug level
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

As we discussed :-) - trivial enough.

Without that patch:

$ openvpn --verb 3 ...
2022-08-13 20:51:06 Cannot find ovpn_dco netlink component: Object not found
2022-08-13 20:51:06 Note: Kernel support for ovpn-dco missing, disabling data channel offload.
2022-08-13 20:51:06 OpenVPN 2.6_git [git:master/d7f16eea8e939b42] x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Aug 13 2022

with that patch:

2022-08-13 20:52:12 Note: Kernel support for ovpn-dco missing, disabling data channel offload.
2022-08-13 20:52:12 OpenVPN 2.6_git [git:master/29f20e738531f0e6] x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Aug 13 2022

and with --verb 7 it shows up again.

The way we currently print some informational messages before and others
after the version number is highly improvable, and I've opened a Trac
ticket for it... (#1470)


Your patch has been applied to the master branch.

commit 29f20e738531f0e65df1bc330f598b3d1eb60b22
Author: Antonio Quartulli
Date:   Fri Aug 12 15:06:55 2022 +0200

     ovpn-dco: print some netlink messages to debug level

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220812130657.29899-9-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24892.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


