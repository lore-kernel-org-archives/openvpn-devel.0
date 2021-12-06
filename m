Date: Mon, 6 Dec 2021 18:27:45 +0100 (CET)
Message-Id: <202112061727.1B6HRjvc044474@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211206010007.3072528-1-arne@...1227...>
References: <20211206010007.3072528-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make --nobind default for --pull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

Your patch has been applied to the master branch.  Thanks for the
extra comments, with these, I can understand what's going on
without maximum coffee level :-)

Tested locally (my t_client tests all set --nobind, so this was
not spectacularily enlightening... ran a few cases manually to
see what would happen.  Does the job. --bind still binds, --lport still
binds, "default --client" does not bind).

Comment adjusted as instructed ("an explicit option", no "s").

commit de02c828f5aa3fbaca78918d4392b48b47547770 (master)
Author: Arne Schwabe
Date:   Mon Dec 6 02:00:07 2021 +0100

     Make --nobind default for --pull

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20211206010007.3072528-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23303.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


