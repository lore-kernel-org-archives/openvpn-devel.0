From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Question about TAP win32 programming
In-Reply-To: <ICBORZ$D7385F4E922E35DA6840D3A7F8CCEC44@...354...>
Message-ID: <Pine.LNX.4.58.0502231310150.20650@...41...>
References: <ICBORZ$D7385F4E922E35DA6840D3A7F8CCEC44@...354...>
MIME-Version: 1.0
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
Date: Wed Feb 23 12:16:46 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "andi.c@...354..." <andi.c@...354...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, 22 Feb 2005, andi.c@...354... wrote:

> Hi to all,
> i am disperately in need of some advices about a subject not
> strictly about OpenVPN, but maybe there is someone here who
> can help me..
> I ve developed a tunnel-broker apps for Linux using TUN/TAP support,
> based on TUN virtual interfce like OpenVPN. In Linux, create (and open) 
> a TUN device is easy, as i do:
> 
> #include <net/tun.h>
> #include <linux/if_tun.h>
> 
> fp = fopen("/dev/net/tun",O_RDWR);
> ioctl(fd, TUNSETIFF, &ifr);
> 
> and then i can read and write to and from TUN device with simple
> read() and write() calls.
> 
> Now, i'd like to port that software on win32. I have installed the TAP
> DRIVER on my machine, and now i have a TAP davide named "tap0801".
> Can someone explain me how i can do the same thing
> under win32 ?  

Look at the #ifdef WIN32 sections in tun.c.

Look especially for ReadFile, WriteFile, CreateFile, and DeviceIoControl 
calls, as these are used to interact with the TAP-Win32 driver.

James

