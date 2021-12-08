Date: Wed, 8 Dec 2021 14:52:41 +0100 (CET)
Message-Id: <202112081352.1B8DqfXU091273@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211208134655.28905-1-maximilian.fillinger@...2507...>
References: <20211208134655.28905-1-maximilian.fillinger@...2507...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't use BF-CBC in unit tests
 if we don't have it
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
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I do not have a "non blowfish" mbedtls to test with, but the fix
is "obviously correct", as discussed on IRC.

Your patch has been applied to the master + release/2.5 branch (bugfix).

commit 0e075c0e1b7b1d55a837d98b7a6c2bc8c7d65375 (master)
commit 57820e8bb1eca8e9e08df003204b8da76379b714 (release/2.5)
Author: Max Fillinger
Date:   Wed Dec 8 14:46:55 2021 +0100

     Don't use BF-CBC in unit tests if we don't have it

     Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211208134655.28905-1-maximilian.fillinger@...2507...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23354.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


