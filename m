Date: Wed, 7 Dec 2016 20:28:41 +0100 (CET)
Message-Id: <201612071928.uB7JSf8C034129@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1481133684-5325-1-git-send-email-steffan@...1856...>
References: <1481133684-5325-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix (and cleanup) crypto flags
	in combination with NCP
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Look good, and doesn't break anything in my test scenarios (and we
have confirmation from the reporter in trac #784 that it fixes the OFB
case).

The "we abort if --no-iv is set without explicitly turning off NCP" is a
bit drastic, but acceptable, I think.  Some people will need to change 
their configs, so I've added a Changes.rst entry...

Your patch has been applied to the master branch.

commit 84f88ca4d57cd0dc40fd945e09ab1cea1b2cd0b7
Author: Steffan Karger
Date:   Wed Dec 7 19:01:24 2016 +0100

     Fix (and cleanup) crypto flags in combination with NCP

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1481133684-5325-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13428.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


