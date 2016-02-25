Date: Thu, 25 Feb 2016 13:47:11 +0100 (CET)
Message-Id: <201602251247.u1PClB13021015@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1452900938-3636-1-git-send-email-iam@...2070...>
References: <1452900938-3636-1-git-send-email-iam@...2070...>
	<CAKuzo_gEU6OvYZXDdoWPo6pjhzD6yG5REQVWBbG9Pyjmeg8Apw@...278...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update --block-outside-dns to
	work on Windows Vista
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
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks, and sorry for the long delay.

The ACK from Selva is in a different thread, but referring to this patch 
(Message-ID: <CAKuzo_gEU6OvYZXDdoWPo6pjhzD6yG5REQVWBbG9Pyjmeg8Apw@...278...>)

I have added a reference to trac #648 and reformatted the commit message
slightly (too-long lines get wrapped in weird ways by git am).

Your patch has been applied to the master and release/2.3 branch.

commit 236769150f64087c590c718c76916ee3c8c9d3b5 (master)
commit 0209fafea2a4205c43d7952dcc5d32d2dbd353e5 (release/2.3)

Author: ValdikSS
Date:   Sat Jan 16 02:35:38 2016 +0300

     Update --block-outside-dns to work on Windows Vista

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <1452900938-3636-1-git-send-email-iam@...2070...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10998
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


