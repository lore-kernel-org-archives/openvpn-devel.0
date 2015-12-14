Date: Mon, 14 Dec 2015 21:45:26 +0100 (CET)
Message-Id: <201512142045.tBEKjQck056850@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1450123758-31641-1-git-send-email-steffan@...1856...>
References: <1450123758-31641-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Warn user if their certificate
	has expired
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

ACK! WANT!

(Tested with an expired certificate and it works, and looking at OpenSSL
x509_vfy.c and PolarSSL x509_8h, I'm reasonable confident that it will 
also for for not-yet-valid certificates and that we call this all correctly)

Your patch has been applied to the master branch (release/2.3 coming 
when that has migrated to PolarSSL 1.3).

commit 091edd8e2996867447eeb665af957547aa8b3107 (master)

Author: Steffan Karger
Date:   Mon Dec 14 21:09:18 2015 +0100

     Warn user if their certificate has expired

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1450123758-31641-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10794
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


