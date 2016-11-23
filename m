Date: Wed, 23 Nov 2016 23:16:58 +0100 (CET)
Message-Id: <201611232216.uANMGwWk061543@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479936104-4045-1-git-send-email-steffan@...1856...>
References: <1479936104-4045-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Poor man's NCP for non-NCP peers
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

ACK.  We made it :-)

I've made three changes (as discussed on IRC) to avoid another round
for "minor nuisances"

 - moved prototype in options.h outside #ifdef ENABLE_OCC
   (warning if --disable-small)

 - undo the moving of #if P2MP_SERVER in key_method_2_read()
   (would break --disable-server)

 - add an extra "if (multi->remote_ciphername == NULL || ...) clause
   to the reasons for setting opt->ncp_enabled = false
   (remote_ciphername will be NULL if talking to a peer that has been
    built without ENABLE_OCC aka --enable-small)

I've tested this on the "t_server" testbed (2.2, 2.3, master clients,
plus one extra with --enable-small), client-with-patch against an older
server (falling back to BF-CBC, complaining :-) ) and of course full 
t_client tests (though nothing in the change suspects a possible client 
failure in that test set).

Your patch has been applied to the master branch.  Thanks!

commit 6e5ad2fa0b1e7ca2e05e0a38f47ed5561cda63b0
Author: Steffan Karger
Date:   Wed Nov 23 22:21:44 2016 +0100

     Poor man's NCP for non-NCP peers

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479936104-4045-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13218.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


