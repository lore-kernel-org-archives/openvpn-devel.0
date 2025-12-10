Date: Wed, 10 Dec 2025 09:50:03 +0100 (CET)
Message-Id: <202512100850.5BA8o3H4006085@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251210075056.27185-1-gert@...1296...>
References: <20251210075056.27185-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Remove some verbose
 error messages for options deprecated in 2.4
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

Thanks for cleaning this up.

The Buildbots have one build fail, but that was a spurious t_client fail
("something mumble mumble network").  The rest is fine, so the actual
code change compiles everywhere - and it's straightforward enough.

Your patch has been applied to the master branch.

commit d4df0a3fbc59edda7b14ea505286d5801e315a4b
Author: Frank Lichtenheld
Date:   Wed Dec 10 08:50:50 2025 +0100

     options: Remove some verbose error messages for options deprecated in 2.4

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1427
     Message-Id: <20251210075056.27185-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34972.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


