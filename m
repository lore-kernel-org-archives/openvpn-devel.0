Message-ID: <3F4222AD.7030308@...61...>
From: julien Touche <julien.touche@...61...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Need 1.5 beta testers for *BSD, Linux 2.2, OS
 X
References: <twig.1061064433.9996@...41...>
In-Reply-To: <twig.1061064433.9996@...41...>
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
Date: Tue Aug 19 06:15:06 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


James Yonan wrote:

> If anyone out there is running 1.5-beta5 or later on OpenBSD, FreeBSD, NetBSD,
> Mac OS X, or Linux 2.2, please let me know.
> 

i test it today in the following conf:

linux 2.4 (openvpn 1.3) <-> openbsd 3.2-stable (beta): ping OK

linux 2.4 (1.3 or beta) <-> windows2k (beta): problem on linux side with tap

# /tmp/openvpn-1.5-beta6/openvpn --cd /etc/openvpn/ --config vpn10.conf
[ snip ]
Tue Aug 19 15:06:55 2003 6: Data Channel MTU parms [ link_mtu=1609 
extra_frame=45 extra_buffer=19 extra_tun=64 ]
Tue Aug 19 15:06:55 2003 7: TUN/TAP device tap0 opened
Tue Aug 19 15:06:55 2003 8: tap0 is not a tun device.  The --ifconfig 
option works only for tun devices.  You should use an --up script to 
ifconfig a tap device.
Tue Aug 19 15:06:55 2003 9: Exiting

note than /dev/tunX exist but no /dev/tapX

vpn10.conf:
dev tap0
remote 192.168.2.10
ifconfig 10.0.3.2 10.0.3.1
up ./tap.up
secret key/test.txt
user nobody
group nogroup
comp-lzo
ping 15
verb 3
tun-mtu 1500
tun-mtu-extra 6


i will try to test it on openbsd 3.4-beta for the end of the week.

Regards

		Julien


