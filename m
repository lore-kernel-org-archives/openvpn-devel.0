Date: Tue, 27 Jan 2026 15:41:40 +0100 (CET)
Message-Id: <202601271441.60REfeap014947@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260122125707.108048-1-frank@...2641...>
References: <20260122125707.108048-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: manage: Do not trigger actions
 on management disconnect if not authenticated
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

Confirmed - run a server instance with "--management-disconnect" *and* a
management password set up, and without this patch, "connect and disconnect"
(without entering a password) will disconnect all clients.

We do not consider this to be a security relevant bug ("CVE assigned") as it
needs quite a lot of prerequisites - "management interface active, while
no management client using this" plus setting "--management-disconnect" on
a server instance, which is somewhat questionable to begin with...

Still, it needs fixing :-)

Your patch has been applied to the master and release/2.6 + 2.5 branch
(bugfix, and trivial cherrypicking)

commit 4bf05d487cc10164615ad7c18931d063ca3eecc2 (master)
commit bb27e40799dcfe51a8cd82b236ce404bd7ab93aa (release/2.6)
commit 193b76ef6e95d86078a2636a38c04beb98c241b8 (release/2.5)
Author: Frank Lichtenheld
Date:   Thu Jan 22 13:57:07 2026 +0100

     manage: Do not trigger actions on management disconnect if not authenticated

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1484
     Message-Id: <20260122125707.108048-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35390.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


