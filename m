Date: Sun, 6 Mar 2016 10:41:58 +0100 (CET)
Message-Id: <201603060941.u269fwCY045984@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1457256715-4467-1-git-send-email-steffan@...1856...>
References: <1457256715-4467-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make AEAD modes work with
	OpenSSL 1.0.1-1.0.1c
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

ACK.  

Tested on Ubuntu 12.04, makes "make check" succeed for AES*GCM modes
(and has no effect on systems with older/newer OpenSSL versions).

Your patch has been applied to the master branch.

commit 13de0103ea361e2be24ab8b16f5be269c6ab7496
Author: Steffan Karger
Date:   Sun Mar 6 10:31:55 2016 +0100

     Make AEAD modes work with OpenSSL 1.0.1-1.0.1c

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1457256715-4467-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11322
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


