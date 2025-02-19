Date: Wed, 19 Feb 2025 12:38:27 +0100 (CET)
Message-Id: <202502191138.51JBcRCC055107@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250219105930.29508-1-gert@...1296...>
References: <20250219105930.29508-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: add more (void) to windows
 specific function prototypes and declarations
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

This has been tested on ubuntu 22.04 / MinGW.  Not sure why I did not
see *these* (void) non-occurances when I did the last patch, but anyway,
now all those have been fixed.  I hope.

Patch has been applied to the master branch.

commit 8720bc8e2e4fbccd16ca4bffd27c416575b1bfee
Author: Gert Doering
Date:   Wed Feb 19 11:59:30 2025 +0100

     add more (void) to windows specific function prototypes and declarations

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250219105930.29508-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30929.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


