Date: Thu, 18 May 2017 14:17:16 +0200 (CEST)
Message-Id: <201705181217.v4ICHGS6084133@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170518102246.5496-1-gert@...1296...>
References: <20170518102246.5496-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix NCP behaviour on TLS
	reconnect.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.4 branch, with
the soft/hard correction pointed out by Steffan.

Thanks to everyone helping here.

commit 5634cecf71ee9a92227bc9c8414c614d1b741abb (master)
commit 13c05ca4e9da88ef30a778c16a97f0c0d767b448 (release/2.4)
Author: Gert Doering
Date:   Thu May 18 12:22:46 2017 +0200

     Fix NCP behaviour on TLS reconnect.

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170518102246.5496-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14666.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


