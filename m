Date: Thu, 28 Nov 2024 12:47:46 +0100 (CET)
Message-Id: <202411281147.4ASBlk9S062078@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241128101538.12810-1-gert@...1296...>
References: <20241128101538.12810-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Haiku: Introduce basic platform
 / tun support
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
To: Alexander von Gluck <alex@...2837...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for your contribution, and congratulations to having the first
half of HAIKU support in OpenVPN :-)

I have no Haiku test system (yet...), so I have only looked at the
change - in which ways will it affect other systems, does it follow
our guidelines for formatting & buffer management, etc - and that
is all fine.

There were some whitespace issues which I have fixed on the fly while
merging.  On 2/2, there's more issues, so please submit a new version.

Your patch has been applied to the master branch.

commit f80803710f74c1128f17cae285b6fa2754149d35 (master)
Author: Alexander von Gluck
Date:   Thu Nov 28 11:15:38 2024 +0100

     Haiku: Introduce basic platform / tun support

     Signed-off-by: Alexander von Gluck <alex@...2837...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241128101538.12810-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29947.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


