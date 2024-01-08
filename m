Date: Mon, 8 Jan 2024 22:33:38 +0100 (CET)
Message-Id: <202401082133.408LXcEf087609@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240108171349.15871-1-gert@...1296...>
References: <20240108171349.15871-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move get_tmp_dir to
 win32-util.c and error out on failure
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

Mildly tested (GHA build).

Fixed "ssl-utils.c -> win32-util.c" in the commit message.

Your patch has been applied to the master branch.

commit f0a17ed8513405af0efb1df2ab2bda3956e01910
Author: Arne Schwabe
Date:   Mon Jan 8 18:13:49 2024 +0100

     Move get_tmp_dir to win32-util.c and error out on failure

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240108171349.15871-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27964.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


