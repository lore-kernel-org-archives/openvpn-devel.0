Date: Wed, 27 Nov 2013 20:23:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131127192346.GA11083@...1296...>
MIME-Version: 1.0
In-Reply-To: <1385382680-5912-4-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: change the type of remote to
	addrinfo.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Code reviewed, understood, makes sense (and some of the ASSERT(0)
in there are to-be-cleanedup markers being fixed in the next hunks).

I have taken the liberty of carefully massaging some of the whitespace,
pull up one fix to init.c from 6/9, and change one mishap in socket.h -
a diff between "previous master + 4/9" and "6c5db192c30ff" is attached.

Word of warning: with this patch in place, connecting via "udp" or
"tcp-client" to a host that has IPv4+IPv6 in place, on an OS that will
prefer IPv6 to IPv4, will always fail.  The remote_list will have IPv6
in it's first entry, while the socket will try to do AF_INET, and that
will not work.  This will be fixed when merging 6/9.

Patch has been applied to the master branch.

commit 6c5db192c30ff0c6b89e2e0aefec00329de39302

Author: Arne Schwabe
Date:   Mon Nov 25 13:31:15 2013 +0100

     change the type of remote to addrinfo.

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385382680-5912-4-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8053
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


