Date: Mon, 28 Jul 2025 16:14:27 +0200 (CEST)
Message-Id: <202507281414.56SEERub053800@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250728125647.26992-1-gert@...1296...>
References: <20250728125647.26992-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Simplify function
 setenv_foreign_option
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

Stared at code (simple is good ;-) ).  Tested with manually connecting
to a server that pushes --dns and --dhcp-option <things> (DNS and others),
and verifying the output before/after.  Same.

Your patch has been applied to the master branch.

commit 654671a10b8f26ed0041ce434016fecb11438aae
Author: Frank Lichtenheld
Date:   Mon Jul 28 14:56:41 2025 +0200

     options: Simplify function setenv_foreign_option

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250728125647.26992-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32396.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


