Date: Thu, 1 Apr 2021 08:23:47 +0200 (CEST)
Message-Id: <202104010623.1316NlV4076984@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210328171151.12056-1-toivol@...277...>
References: <20210328171151.12056-1-toivol@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Stop using deprecated getpass()
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
To: toivol@...277...
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

I have compile-tested this across all our supported platforms to be
sure that we do not hit undefined symbols (like, "ECHOK", which was
unknown to me before) - but hat is all OK.  I have given it minimal
testing on my corp VPN profile on Linux (works).

Interesting enough, my corp VPN "password" is 2FA + PIN, which makes
it longer than 8 characters :-) - I've never used that from a Solaris
*client*, otherwise I might have noticed the issue myself...

Thanks for your work!

commit 76ccc62d4884721b6ecc11078abef747ea60d8d0
Author: Tõivo Leedjärv
Date:   Sun Mar 28 17:11:51 2021 +0000

     Stop using deprecated getpass()

     Signed-off-by: Tõivo Leedjärv <toivol@...277...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210328171151.12056-1-toivol@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21889.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


