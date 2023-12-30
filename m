Date: Sat, 30 Dec 2023 16:22:07 +0100 (CET)
Message-Id: <202312301522.3BUFM7pC023180@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231230143817.4880-1-gert@...1296...>
References: <20231230143817.4880-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: allow to disable NTLM
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

Lightly tested (one build with and without --disable-ntlm, compare 
resulting strings in binary).  No surprises there, since this code was
already conditionalized, just not exposed to configure.

Your patch has been applied to the master branch.

commit 1da3496abce6c4380651fdf79c1d599750964ef2 (master)
Author: Frank Lichtenheld
Date:   Sat Dec 30 15:38:17 2023 +0100

     configure: allow to disable NTLM

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231230143817.4880-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27863.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


