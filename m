Date: Sun, 30 Nov 2014 17:48:50 +0100 (CET)
Message-Id: <201411301648.sAUGmn3S007220@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1416852578-7581-1-git-send-email-openvpn.list@...1114...>
References: <1416852578-7581-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH applied] Re: autotools: Fix wrong
	./configure help screen default values
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

ACK.

Your patch has been applied to the master and release/2.3 branches.

Since we agreed that we actually want to get rid of --enable-password-save
(unconditionally enable it, get rid of the autoconf option) this might 
seem to be a bit redundant, but the patch is there, and it won't harm 
to make what we have correct :-)

As a matter of discussion, I wonder why we have "default=yes" and "no"
in our --help text, and not "default=enabled"/"disabled", which might be
slightly less confusing... any autoconf style guides here?

commit 104360b4f40a4ba29987d9478aed70450fec75a2 (master)
commit 995be6fdc07f1280c46eec0c9b86f690124fb30f (release/2.3)

Author: David Sommerseth
Date:   Mon Nov 24 19:09:38 2014 +0100

     autotools: Fix wrong ./configure help screen default values

     Signed-off-by: David Sommerseth <davids@...1347...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1416852578-7581-1-git-send-email-openvpn.list@...1114...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9278
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


