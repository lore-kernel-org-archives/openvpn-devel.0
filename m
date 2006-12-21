From: Charles Duffy <cduffy@...294...>
Date: Wed, 20 Dec 2006 19:28:09 -0600
Message-ID: <emcnvg$hs5$1@...165...>
References: <000901c72472$58388800$16ada8c0@...576...>
Mime-Version: 1.0
In-Reply-To: <000901c72472$58388800$16ada8c0@...576...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] Does 'topology subnet' obviate
	'client-to-client'?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Dave wrote:
> It's not documented as such explicitly, but I'm assuming it's true that
> client-to-client is not needed when the 'subnet topology' option is used.
> True?  Am I missing a subtlety?

Just as you still need client-to-client if you want clients to
communicate with each other *without going through the host IP stack*
with ifconfig-pool-linear on 2.0, it should still be necessary with
topology subnet on 2.1.


