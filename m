Date: Tue, 30 Jun 2015 09:37:01 +0200 (CEST)
Message-Id: <201506300737.t5U7b1SZ001795@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1435581995-11820-1-git-send-email-arne@...1227...>
References: <1435581995-11820-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Report missing endtags of
	inline files as warnings
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master and release/2.3 branch.

I've added a reference to trac #568 and made it M_FATAL / "ERROR:" for
2.4, while the release/2.3 patch went in "as is".

commit 68eecf76978a80bd5d88e944e4ed5e42bf2fd8e4 (master)
commit 19475259c92b4747c4c9d3a3d025bdeb170e859c (release/2.3)

Author: Arne Schwabe
Date:   Mon Jun 29 14:46:35 2015 +0200

     Report missing endtags of inline files as warnings

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1435581995-11820-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9830
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


