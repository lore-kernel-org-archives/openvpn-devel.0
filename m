From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvwrhv4sxr.fsf-monnier+INBOX@...1269...>
References: <4DCBFE39.7080508@...1114...>
Date: Thu, 12 May 2011 16:46:16 -0300
In-Reply-To: <4DCBFE39.7080508@...1114...> (David Sommerseth's message
	of "Thu, 12 May 2011 17:35:21 +0200")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Fwd: Re: [Openvpn-users] behavior of remote
	address with more than one A	record
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> You can test this by making sure the TTL is set low enough on your server
> records (say 60 seconds), make sure that your client will do a new DNS
> lookup with the proper TTL (you can check this with 'dig').  Then connect
> to your server and break the connection after one minute and then
> reconnect.  In this case, if the DNS server does the job properly, it would
> now give your second server - which OpenVPN should use.

But this is about load-balancing, whereas the OP's issue is with
fail-over.  If the TTL is not low enough then the fail-over will not
happen (OpenVPN will keep trying to connect to same first host in the
list).  It seems that for fail-over, OpenVPN should do a single DNS
request and then cycle though the list of hosts it received.


        Stefan

