Date: Sat, 6 Aug 2022 12:41:53 +0200 (CEST)
Message-Id: <202208061041.276Afr6R078802@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220804150301.62856-2-frank@...2641...>
References: <20220804150301.62856-2-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reduce usage of __DATE__
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

Acked-by: Gert Doering <gert@...1296...>

I think this is a workable compromise - thanks.

Building from git gives me

  OpenVPN 2.6_git [git:master/a9b3585d606e5b57] x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Aug  6 2022

doing a "make dist" and building from the resulting tarball gives

  OpenVPN 2.6_git x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD]


Your patch has been applied to the master branch.

commit a9b3585d606e5b5717778777a4f346c8371d2698
Author: Frank Lichtenheld
Date:   Thu Aug 4 17:03:01 2022 +0200

     Reduce usage of __DATE__

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220804150301.62856-2-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24807.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


