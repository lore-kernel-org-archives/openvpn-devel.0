Date: Thu, 9 Aug 2018 14:14:45 +0200 (CEST)
Message-Id: <201808091214.w79CEjdq029217@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <8110ED8B-4084-4D47-87E2-7B1C14041268@...1031...>
References: <8110ED8B-4084-4D47-87E2-7B1C14041268@...1031...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix subnet topology on NetBSD.
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
To: Adam Ciarcin?ski <adam@...1031...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  And a good vacation to you :-)

Tested on NetBSD 7.0.1, and passes all my tests.

(Given that the changes are all #ifdef TARGET_NETBSD, I do not 
expect surprises on other platforms).

Your patch has been applied to the master and release/2.4 branch
(well, *this* patch was applied to "master", and the previous patch
was applied to release/2.4, since "git cherrypick" refused to play
nicely - so there will be two "patch applied" mails).


commit 98e1d917fceb4c003fda0b43270325091768484f (master)
commit de4c7767b6b30ebd8f05cffb0fabe7e68bdc5e38 (release/2.4)
Author: Adam Ciarcin?ski
Date:   Thu Aug 2 16:17:56 2018 +0200

     Fix subnet topology on NetBSD.

     Signed-off-by: Adam Ciarcin?ski <adam@...1031...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <8110ED8B-4084-4D47-87E2-7B1C14041268@...1031...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17399.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


