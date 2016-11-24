Date: Thu, 24 Nov 2016 11:04:53 +0100 (CET)
Message-Id: <201611241004.uAOA4rK9069236@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479931325-25919-2-git-send-email-steffan@...1856...>
References: <1479931325-25919-2-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor data channel key
	generation API
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

ACK.  This is slightly different from the refactoring in "v4"
(as tls_session_generate_data_channel_keys() is now "static" and
no longer needs to be called externally, so the actual change is
much smaller).  The change to ssl.c is mostly identical, though,
so this was now reviewed and tested twice :-) - "just code being
moved around".  Passes all tests on server and client side.

Your patch has been applied to the master branch.

commit e2ffdb7c83faaee6541c248e8d83eb3dfb5a32f1
Author: Steffan Karger
Date:   Wed Nov 23 21:02:05 2016 +0100

     Refactor data channel key generation API

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479931325-25919-2-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13216.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


