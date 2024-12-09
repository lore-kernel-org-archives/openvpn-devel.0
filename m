Date: Mon, 9 Dec 2024 21:09:13 +0100 (CET)
Message-Id: <202412092009.4B9K9D6j088367@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241209194957.358-1-gert@...1296...>
References: <20241209194957.358-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leak in ntlm_support
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

Haven't really tested but looks reasonable and still works as expected
on the OpenSSL test instance here.

Your patch has been applied to the master branch.

commit ae82631be17ca8c49d356510c9e7709ddcf19db3
Author: Frank Lichtenheld
Date:   Mon Dec 9 20:49:57 2024 +0100

     Fix memory leak in ntlm_support

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20241209194957.358-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30049.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


