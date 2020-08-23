Date: Sun, 23 Aug 2020 22:11:42 +0200 (CEST)
Message-Id: <202008232011.07NKBgpP035163@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200723121949.78223-1-gert@...1296...>
References: <20200723121949.78223-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Workaround FreeBSD 12+ race
 condition on tun/tap open with IPv6.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

commit 5e19cc2c1bf22d44f10dc585ba69d48951dc7a86 (master)
commit 6dac3342d851995bdee75db4b52cfb3a3f9232e3 (release/2.5)
Author: Gert Doering
Date:   Thu Jul 23 14:19:49 2020 +0200

     Workaround FreeBSD 12+ race condition on tun/tap open with IPv6.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200723121949.78223-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20553.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


