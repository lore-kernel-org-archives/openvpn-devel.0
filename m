Date: Thu, 30 Oct 2025 22:03:43 +0100 (CET)
Message-Id: <202510302103.59UL3hnH026019@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251030193638.1010-1-gert@...1296...>
References: <20251030193638.1010-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensure return value of snprintf
 is correctly checked
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

Checked each individual location.  I don't think any of these can
reasonably ever overflow - but if we do have checks, we must ensure that
the check is meaningful.  So this is a good fix.

BB also confirms "does not break anything" ;-)

(Not applied to 2.6, as many snprintf() calls looks quite different there)

Your patch has been applied to the master branch.

commit d7f86ddaf403aafa4a6098d02d76910a821b038e
Author: Arne Schwabe
Date:   Thu Oct 30 20:36:30 2025 +0100

     Ensure return value of snprintf is correctly checked

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1330
     Message-Id: <20251030193638.1010-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34063.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


