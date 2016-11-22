Date: Tue, 22 Nov 2016 22:36:50 +0100 (CET)
Message-Id: <201611222136.uAMLao8Z036868@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479845366-15774-1-git-send-email-steffan@...1856...>
References: <1479845366-15774-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: generate_key_expansion: make
	assumption explicit, use C99 features
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

ACK.  Except for the check, it boils down to "the same code", and the
check makes sense.

Your patch has been applied to the master branch.

commit 48d41413c4b181e00769cdb83ccfe179299ad8e4
Author: Steffan Karger
Date:   Tue Nov 22 21:09:26 2016 +0100

     generate_key_expansion: make assumption explicit, use C99 features

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479845366-15774-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13202.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


