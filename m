Date: Mon, 22 Jun 2020 07:55:58 +0200 (CEST)
Message-Id: <202006220555.05M5twkB058585@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200620143940.11704-1-gert@...1296...>
References: <20200620143940.11704-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Convert plugin/auth-pam.c from
 stderr logging to plugin_log().
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

Patch has been applied to the master branch.

As this is neither a bugfix nor "long-term compat" (nor prerequisite for
either), not applied to release/2.4 

commit 933b4ab808891805232f599507fded916b284a43
Author: Gert Doering
Date:   Sat Jun 20 16:39:40 2020 +0200

     Convert plugin/auth-pam.c from stderr logging to plugin_log().

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20200620143940.11704-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20037.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


