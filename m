Date: Thu, 18 Aug 2022 20:14:38 +0200 (CEST)
Message-Id: <202208181814.27IIEc5W071386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220802130312.18871-1-a@...2181...>
References: <20220802130312.18871-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: move availability check to
 the end of check_option_conflict() function
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

Thanks.  This was left hanging in the cold for some reason... merged
now.  I've subjected it to the usual test for DCO related stuff (client
with no-dco kernel, client with dco, server with dco) and verified that
the same instances have DCO enabled that had before - glad for Arne's
GLOBAL_STATS patch now :-)

This *should* be safe even on windows, as windows patch 1/7 changes
the first condition to "if (!dco_enabled(o) ...)" so it won't abort on
DCO-incompatible option in a config that does not have "windows-driver dco"
in the first place.

I have rewrapped the comment to better fit into 80 char line constraints
(since the second line was quite short)

Your patch has been applied to the master branch.

commit 78b8d0e162e1fa34780ee3d3ea84691539a0b1f3
Author: Antonio Quartulli
Date:   Tue Aug 2 15:03:12 2022 +0200

     dco: move availability check to the end of check_option_conflict() function

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220802130312.18871-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24783.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


