Date: Wed, 17 Jan 2024 15:23:15 +0100 (CET)
Message-Id: <202401171423.40HENFWu091767@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231008103641.19864-1-frank@...2641...>
References: <20231008103641.19864-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix various 'Uninitialized
 scalar variable' warnings from Coverity
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

Generally I'm not a big fan of code changes just to appease a checking tool,
but I can see why coverity would warn (we pass on structures that contain
possibly-uninitialized data, and the callee "might decide to use them").

Your patch has been applied to the master branch.

commit 327355f5174772ad2c788aaeb2a7b4db39cff385
Author: Frank Lichtenheld
Date:   Sun Oct 8 12:36:41 2023 +0200

     Fix various 'Uninitialized scalar variable' warnings from Coverity

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231008103641.19864-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27157.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


