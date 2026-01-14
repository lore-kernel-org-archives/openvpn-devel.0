Date: Wed, 14 Jan 2026 19:40:34 +0100 (CET)
Message-Id: <202601141840.60EIeYwl035685@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260114135807.20637-1-gert@...1296...>
References: <20260114135807.20637-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socks: In
 establish_socks_proxy_udpassoc check result of recv_socks_reply
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

We don't currently have "known failing" SOCKS test in our t_client setup
(maybe we should, but the release t_client.sh script has no concept of
"this test is expected to fail" yet), so this is not automatically tested.

That said, the change makes sense, and will hopefully ease someone's
future debugging when talking to a SOCKS proxy that is refusing
cooperation.

Your patch has been applied to the master branch.

commit b2cc5c2ec49c3cfc428f0ecef9684ac318845a84
Author: Frank Lichtenheld
Date:   Wed Jan 14 14:58:02 2026 +0100

     socks: In establish_socks_proxy_udpassoc check result of recv_socks_reply

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1469
     Message-Id: <20260114135807.20637-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35249.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


