Message-ID: <3F5B1FAE.1030801@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Need 1.5 beta testers for *BSD, Linux 2.2, OS
 X
References: <twig.1062309326.34391@...41...>
In-Reply-To: <twig.1062309326.34391@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Sep  7 05:08:03 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


James Yonan wrote:

> I'm thinking about something like this in a more generalized context, where
> OpenVPN running as a server would actually generate the config file for the
> client, and send it to the client via SSL after an initial authentication
> handshake.  This would simplify the configuration on the client side, and
> allow the server to send routes back to the client.
> 

one extra could be:
for a client side hidden behind a gateway (so no public ip) could 
contact and establish a vpn with a public box.

would it be possible without any relay on the client gateway ?


Regards

		Julien


