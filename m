Date: Mon, 3 May 2021 15:54:53 +0200 (CEST)
Message-Id: <202105031354.143Dsrj8052517@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210331155508.19423-1-arne@...1227...>
References: <20210331155508.19423-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix binary and (&) used in
 auth-token check instead of logical and (&&)
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

Acked-by: Gert Doering <gert@...1296...>

Your patch has been applied to the master branch.

Release/2.5 has this fix already, as part of commit 3aca477a1b58.

Antonio complained about the patch subject:, and asked for a v2 - which
I did not see anywhere, so I rewrote the commit subject and now it's 
out of my work queue :-)

commit 0cbfa10e6aac01831bebe42ab33dc56c4704c1a6
Author: Arne Schwabe
Date:   Wed Mar 31 17:55:08 2021 +0200

     Fix binary and (&) used in auth-token check instead of logical and (&&)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210331155508.19423-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21911.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


