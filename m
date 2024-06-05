Date: Wed, 5 Jun 2024 13:17:19 +0200 (CEST)
Message-Id: <202406051117.455BHJlO001148@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240605111012.3023-1-gert@...1296...>
References: <20240605111012.3023-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_user_pass: Fix building
 with --enable-systemd
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

Your patch has been applied to the master branch (this unit test is not
in release/2.6, so nothing to fix there).  Not tested myself as I do not
have anything with systemd, but it does not break "non-systemd tests",
as confirmed by gerrit/all the buildbots.

commit 7dfff75659e6c06abe500f5b8716d9712aa41bcc (master)
Author: Frank Lichtenheld
Date:   Wed Jun 5 13:10:12 2024 +0200

     test_user_pass: Fix building with --enable-systemd

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240605111012.3023-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28708.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


