Subject: Re: [Openvpn-devel] Radius support (Authentification,
	Authorization and Accounting)
From: Daniel Lehmann <ov_devel@...300...>
In-Reply-To: <Pine.LNX.4.58.0504301327500.25603@...41...>
References: <200504291033.00667.ralfluebben@...68...>
	 <Pine.LNX.4.58.0504291041510.24107@...41...>
	 <200504300904.51200.ralfluebben@...68...>
	 <Pine.LNX.4.58.0504300118280.24107@...41...>
	 <1114864741.22186.28.camel@...344...>
	 <Pine.LNX.4.58.0504301327500.25603@...41...>
Message-Id: <1114978074.22186.63.camel@...344...>
Mime-Version: 1.0
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
Date: Sun May  1 13:09:08 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am Samstag, den 30.04.2005, 13:33 -0600 schrieb James Yonan:
> I agree that this method is not perfect, but it has the two important 
> properties that:
> 
> (1) it lets OpenVPN handle script or plugin calls the same
> (2) it works on all OSes, including Windows
> 
> And remember that you can also optimize out the use of disk files with 
> something like (on Linux):
> 
>   tmp-dir /dev/shm

Hi James,

I still would prefer a "cleaner" solution.
But you see the whole scope of such an decision - for me the windows
support of the mentioned method is irrelevant.

Thx, for the idea of using a ram-drive. I'll give that a try.
leh


