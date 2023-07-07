Date: Fri, 7 Jul 2023 18:33:19 +0200 (CEST)
Message-Id: <202307071633.367GXJmP062756@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230707144628.378541-1-frank@...2641...>
References: <20230707144628.378541-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove old Travis CI related
 files
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

Trivial, and makes sense.

Since this does not touch source files, haven't tested anything
(it does bring up the question "can we get coverity scans up and
running again, somehow?").

Your patch has been applied to the master and release/2.6 branch.

commit fd43636c417b479e95ca9f3eca6b90c410bc7686 (master)
commit c5d31ddead4ce12903fb36cbf8b154afbd2aa7f1 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Jul 7 16:46:28 2023 +0200

     Remove old Travis CI related files

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230707144628.378541-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26834.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


