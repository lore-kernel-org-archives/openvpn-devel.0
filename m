Date: Mon, 4 Jan 2016 20:40:37 +0100 (CET)
Message-Id: <201601041940.u04Jebxf026098@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1451842066-13475-1-git-send-email-arne@...1227...>
References: <1451842066-13475-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement the compression V2
	data format for stub and lz4.
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

ACK from me as well (and thanks for bearing with Steffan and me).  

I have stared at the code, and ran my test suite - I have not yet 
run end-to-end lz4v2 or stubv2, but my test server will pick up the 
change tomorrow and we'll see... :-)

Your patch has been applied to the master branch.

The {} brackets in lz4v2_compress() have been moved around as suggested 
by Steffan.  Also, I have fixed a typo ("compression schmemes") that
managed to evade earlier review.

commit a75bb2e40a431e053ea1ef328ec022aaf851ccc0 (master)

Author: Arne Schwabe
Date:   Sun Jan 3 18:27:46 2016 +0100

     Implement the compression V2 data format for stub and lz4.

     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1451842066-13475-1-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10925
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


