Message-ID: <40A12427.1060104@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] 2.0: public linux <- nat -> private win2k
References: <twig.1084300129.5764@...41...>
In-Reply-To: <twig.1084300129.5764@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue May 11 12:07:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

James Yonan wrote:

> That's just the --verb 5 debugging mode that shows packet flows through
> OpenVPN.  Try using --verb 4 or lower to suppress that output.
> 
ok i've missed the changelog, thanks

> 
>>the pull options seems also to not work or is it only for "mode server"
>>as i'm using "proto tcp-server" (in this setup, udp returns udp port X
>>unreachable) and shared secret for now ?
> 
> 
> Right now --push/--pull is primarily oriented towards --mode server usage,
> though it should also work in OpenVPN's traditional peer-to-peer mode if TLS
> is used.
why is it reserved for tls mode ?

Regards

		Julien


