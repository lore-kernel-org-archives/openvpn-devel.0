Date: Wed, 27 Apr 2016 20:02:19 +0200 (CEST)
Message-Id: <201604271802.u3RI2JCG036189@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <49496.109.81.184.65.1461736834.squirrel@...1899...>
References: <49496.109.81.184.65.1461736834.squirrel@...1899...>
Subject: [Openvpn-devel] [PATCH applied] Re: Exported keying material is
	always sizeof(unsigned char*)
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
To: Daniel Kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net

ACK!

Your patch has been applied to the master branch.

Sorry for ACKing the patch that broke the code - ACKing the fix now :-)
(I've taken the liberty to make the commit message more readable - no
code changes)

commit 13a882ae39efb7144d9a9c5ac61100b1e27b1003
Author: Daniel Kubec
Date:   Wed Apr 27 08:00:34 2016 +0200

     Fix buffer size parameter for exported keying material.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <49496.109.81.184.65.1461736834.squirrel@...1899...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11509
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


