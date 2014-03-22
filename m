Date: Sat, 22 Mar 2014 19:17:53 +0100 (CET)
Message-Id: <201403221817.s2MIHrZ9017576@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395407925-25518-4-git-send-email-arne@...1227...>
References: <1395407925-25518-4-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Workaround broken Android 4.4
	VpnService API for persist-tun mode
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

ACK.  This has limited impact on "the core" as it's all #ifdef ANDROID
only - and is obviously necessary changes, as well contained as possible.

I have amended the commit message somewhat to make it more clear what
the patch does.

Patch has been applied to the master branch.

commit c058cbffc182b6618182a3ff8b13c66d01ce937d

Author: Arne Schwabe
Date:   Fri Mar 21 14:18:36 2014 +0100

     Workaround broken Android 4.4 VpnService API for persist-tun mode

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395407925-25518-4-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8373
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


