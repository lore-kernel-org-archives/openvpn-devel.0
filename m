Date: Wed, 6 Nov 2024 08:04:37 +0100 (CET)
Message-Id: <202411060704.4A674bXr020373@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241104085808.17039-1-gert@...1296...>
References: <20241104085808.17039-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: send uname() release as
 IV_PLAT_VER= on non-windows versions
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

Thanks Antonio for the review.

Patch has been applied to the master and release/2.6 branch (localized
mini-feature that can help admins keep track of macOS etc. client versions)

commit d5b4713153ce95e88651d93aa1ef25b2676d0cfc (master)
commit f104d00af8ace124ff283e3adb7c7d4d867d6bbf (release/2.6)
Author: Gert Doering
Date:   Mon Nov 4 09:58:08 2024 +0100

     send uname() release as IV_PLAT_VER= on non-windows versions

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20241104085808.17039-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29699.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


