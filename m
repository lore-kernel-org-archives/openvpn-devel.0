Date: Tue, 24 Nov 2015 21:27:45 +0100 (CET)
Message-Id: <201511242027.tAOKRjZA086256@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447246899-22769-1-git-send-email-openvpn@...2080...>
References: <1447246899-22769-1-git-send-email-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid partial authentication
	state when using --disabled in CCD configs
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, thanks.  As discussed in #521 and #180, I'm thinking more along the
lines of a more radical approach to this (removing CAS_PARTIAL, or at
least make it do the right thing - call plugin destructors, and send
AUTH_FAILED).  But for the time being this one fixes nicely and cleanly
the issue at hand, with no possibly intended consequences.

Your patch has been applied to the master and release/2.3 branch.

commit 6c2d790ad8f10029e95aecb0d39377ef06ea8b2a (master)
commit 4b0a6f808e20f1d6d6a0b60391f053bc8ab94772 (release/2.3)

Author: David Sommerseth
Date:   Wed Nov 11 14:01:39 2015 +0100

     Avoid partial authentication state when using --disabled in CCD configs

     Signed-off-by: David Sommerseth <davids@...1347...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1447246899-22769-1-git-send-email-openvpn@...2080...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10486
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


