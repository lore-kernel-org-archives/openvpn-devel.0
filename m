References: <49F1B322.6030705@...1032...> <1240630761l.7894l.0l@...1207...>
	<49F34D62.4000302@...1114...>
From: Benny Amorsen <benny+usenet@...1175...>
Date: Mon, 27 Apr 2009 10:45:58 +0200
In-Reply-To: <49F34D62.4000302@...1114...> (David Sommerseth's message
	of "Sat\, 25 Apr 2009 19\:50\:26 +0200")
Message-ID: <m3zle2cwmx.fsf@...1176...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] linux openvpn development job
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David Sommerseth <openvpn.list@...1114...> writes:

> What if OpenVPN on selected platforms also provided it's own kernel driver
> which would do practically the same as the upstream tun.ko modules -
> except it provides a direct API which OpenVPN can utilize, to avoid the
> kernel-userspace-kernel ping-pong.

It seems that OpenVPN is quite far away from the theoretical performance
where kernel-userspace-kernel copying becomes an issue. Right now
encryption is quite expensive, except on a few platforms with dedicated
AES instructions.


/Benny


