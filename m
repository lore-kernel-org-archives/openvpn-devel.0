Date: Thu, 27 Mar 2025 17:08:34 +0100 (CET)
Message-Id: <202503271608.52RG8YmE034092@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250327153606.15282-1-gert@...1296...>
References: <20250327153606.15282-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not leave half-initialised
 key wrap struct when dynamic tls-crypt fails
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

Looking at this with "git show --color-moved=zebra -U20" makes clear
that it's just moving around the call that could fail, and if it fails,
do not modify anything else that might then become inconsistent.  As
far as I can see, nothing of this has side effects where order would
be important (except when erroring-out, of course).

Your patch has been applied to the master branch.

commit 7825a8c586a8beba209370f1594cd0987b653ab7
Author: Arne Schwabe
Date:   Thu Mar 27 16:36:00 2025 +0100

     Do not leave half-initialised key wrap struct when dynamic tls-crypt fails

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250327153606.15282-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31267.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


