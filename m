From: Matt <matt@...137...>
Subject: Re: [Openvpn-devel] Working with 2.6
References: <Pine.LNX.4.58.0311180916570.17332@...136...>
In-Reply-To: <Pine.LNX.4.58.0311180916570.17332@...136...>
MIME-Version: 1.0
Message-Id: <200311181004.25751.matt@...137...>
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
Date: Tue Nov 18 09:05:06 2003
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

I've had a simular problem too. 2.6 and Openvpn are a no go.

Matt H.

On Tuesday 18 November 2003 08:18 am, Jon Nelson wrote:
> Just so you all know, I'm using OpenVPN 1.5beta12 (soon to be beta14)
> with Linux 2.6.0-test9 (vanilla, no patching).
>
> The only problem I encountered is that I had to alter by devfs
> configuration because the tun device has moved from /dev/net/tun to
> /dev/misc/net/tun -- fortunately there are existing (commented out)
> directives in the devfs configuration for this.
>
> --
> Democracy is two wolves and a sheep voting on what to have for dinner.
> Liberty is two wolves attempting to have a sheep for dinner and
> finding a well-informed, well-armed sheep.
>
> Jon Nelson <jnelson-openvpn@...135...>
>
>
> -------------------------------------------------------
> This SF. Net email is sponsored by: GoToMyPC
> GoToMyPC is the fast, easy and secure way to access your computer from
> any Web browser or wireless device. Click here to Try it Free!
> https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

