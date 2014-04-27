Date: Sun, 27 Apr 2014 14:43:28 +0200 (CEST)
Message-Id: <201404271243.s3RChS5m013961@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1398585348-7969-1-git-send-email-steffan@...1856...>
References: <1398585348-7969-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Change signedness of hash in
	x509_get_sha1_hash(), fixes compiler warning.
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

ACK ("obviously correct")

Your patch has been applied to the master and release/2.3 branches.

commit d4309c21d9cde43c777985e373242afa78afefa1 (master)
commit b36515a7115cec9a0f1c4240a83d4b5d184235f1 (release/2.3)

Author: Steffan Karger
Date:   Sun Apr 27 09:55:48 2014 +0200

     Change signedness of hash in x509_get_sha1_hash(), fixes compiler warning.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1398585348-7969-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8647
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


