Date: Wed, 6 Oct 2021 11:53:08 +0200 (CEST)
Message-Id: <202110060953.1969r8h9045199@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211006090709.200-1-lstipakov@...277...>
References: <20211006090709.200-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix loading PKCS12 files on
 Windows
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

As discussed on IRC, and checked with the OpenSSL documentation and
"Internet knowledge".  Most important: confirmed that it breaks with
--pkcs12 without that patch, and works with it (IRC, I did not test
myself).

Your patch has been applied to the master and release/2.5 branch.

commit af5de933a0633436e0fe00c42464f4a7ab5ac509 (master)
commit f397c3bfe728e0163fe6d226f62874e1dd25ec60 (release/2.5)
Author: Lev Stipakov
Date:   Wed Oct 6 12:07:09 2021 +0300

     Fix loading PKCS12 files on Windows

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211006090709.200-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22920.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


