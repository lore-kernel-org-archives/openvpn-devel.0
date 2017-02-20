Date: Mon, 20 Feb 2017 20:47:48 +0100 (CET)
Message-Id: <201702201947.v1KJlmXL014209@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170131112131.13570-1-a@...2181...>
References: <20170131112131.13570-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: attempt to add IPv6 route even
	when no IPv6 address was configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  What we had was too strict in some cases, breaking people's
configs - with this change, we give users enough rope to hang themselves
if they insist to do so, but point out in the log file that this might
be a stupid idea...

(That this came up in the first place is a consequence of commit
86e2fa5597fd1ad8e, 2.3 "supported" this mode of operation "fine")

Tested on linux - and it does the right motions.  Whether or not 
"route6 without ifconfig6" does the right thing on platform <x>
is not something we guarantee or promise :-)


Your patch has been applied to the master and release/2.4 branch.

commit 2b7650e7ec9241745e4f66c932d6cffaece927d7 (master)
commit c74d574417b8b491fe6ad44e89843af8479cc9be (release/2.4)
Author: Antonio Quartulli
Date:   Tue Jan 31 19:21:31 2017 +0800

     attempt to add IPv6 route even when no IPv6 address was configured

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170131112131.13570-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13994.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


