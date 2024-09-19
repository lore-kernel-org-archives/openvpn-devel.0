Date: Thu, 19 Sep 2024 08:15:11 +0200 (CEST)
Message-Id: <202409190615.48J6FBFJ031468@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240918204844.2820-1-gert@...1296...>
References: <20240918204844.2820-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Change return types of
 link_socket_write* to ssize_t
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

This is fallout from the -Wconversion patch set (commit 53449cb61f)
where it turned out that the whole link_socket* call chain used
inconsistent return types - so now it's consistent with sendmsg() etc.,
all using ssize_t.  Stared-at-code and asked GHA :-)

Your patch has been applied to the master branch.

commit 2cc77debf0221fa0cef3ea470c1328d25397d021 (master)
Author: Frank Lichtenheld
Date:   Wed Sep 18 22:48:44 2024 +0200

     socket: Change return types of link_socket_write* to ssize_t

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240918204844.2820-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29323.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


