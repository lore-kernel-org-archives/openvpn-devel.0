Date: Tue, 1 Nov 2016 09:47:48 +0100 (CET)
Message-Id: <201611010847.uA18lmhU099672@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1477955229-20164-1-git-send-email-davids@...515...>
References: <1477955229-20164-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix builds with --disable-crypto
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.

Build tested with default options, --disable-crypto, --disable-management,
and --disable-server.  All compile fine and pass whatever test can still
be run (not much for --disable-crypto today).

Your patch has been applied to the master branch.

commit 51d4d1543a64158cc24f176a8d45e51cbda8cd91
Author: David Sommerseth
Date:   Tue Nov 1 00:07:09 2016 +0100

     Fix builds with --disable-crypto

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1477955229-20164-1-git-send-email-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12857.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


