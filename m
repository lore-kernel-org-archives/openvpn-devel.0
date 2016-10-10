Date: Mon, 10 Oct 2016 20:24:35 +0200 (CEST)
Message-Id: <201610101824.u9AIOZHg012317@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1474121738-19420-1-git-send-email-arne@...1227...>
References: <1474121738-19420-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable TCP non-linear packet ID
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

Amazingly simple - "just remove all notion of TCP in the packet ID code".

Your patch has been applied to the master branch.

I have fixed a small whitespace error in comp.c.

commit 55755e6ee56516c96525e6bf313c173653af1a4b
Author: Arne Schwabe
Date:   Sat Sep 17 16:15:38 2016 +0200

     Enable TCP non-linear packet ID

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474121738-19420-1-git-send-email-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12513.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


