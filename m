Date: Tue, 9 Dec 2025 10:00:24 +0100 (CET)
Message-Id: <202512090900.5B990Ovt050627@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251209070218.4467-1-gert@...1296...>
References: <20251209070218.4467-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: pull-filter: improve
 documentation
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks :-)

For the other readers: this is a documentation-only update, intending to
emphasize that "pull-filter" is not a secure solution (in the sense of
"a malicious server can not find ways around it") to filter options sent
by a, well, untrusted server.  "Connecting to a server you do not fully
trust" is not unheard-of - consulting customers passing on a VPN config
to access to-be-consulted systems, but you do not want to send them any
other traffic.  Usually those are not actively malicious, though...

Your patch has been applied to the master and release/2.6 branch.

commit d3e03b9a97177f62d31697f2b4b453295ee30e60 (master)
commit f8f1e1afac1a30ef7311bf75716421e08466780e (release/2.6)
Author: Selva Nair
Date:   Tue Dec 9 08:02:11 2025 +0100

     pull-filter: improve documentation

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1415
     Message-Id: <20251209070218.4467-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34930.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


