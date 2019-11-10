Date: Sun, 10 Nov 2019 13:42:31 +0100 (CET)
Message-Id: <201911101242.xAACgV6Z000397@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191109174235.20511-1-steffan@...1856...>
References: <20191109174235.20511-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update sample configs to use
 modern cipher, remove static key examples
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

After a quick discussion in the group, we're all OK with kicking out
static-key samples (only the samples, not the functionality yet) BUT 
we can't do the AES-256-GCM thing in 2.4 due to "RHEL6 and Debian 8"
support (no AES-GCM there).  So, master.

Your patch has been applied to the master branch.

commit ac10391f48e4ecc5c6db541e47bc747955ef1c93
Author: Steffan Karger
Date:   Sat Nov 9 18:42:35 2019 +0100

     Update sample configs to use modern cipher, remove static key examples

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191109174235.20511-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19081.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


