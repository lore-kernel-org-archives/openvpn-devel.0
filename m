From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Mac OS X tap support
In-Reply-To: <20040911143321.GG31609@...271...>
Message-ID: <Pine.LNX.4.58.0409111018240.23109@...269...>
References: <20040911143321.GG31609@...271...>
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
Date: Sat Sep 11 09:33:05 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Waldemar Brodkorb <wbx@...270...>
Cc: openvpn-devel@lists.sourceforge.net, Mattias Nissler <mattias.nissler@...68...>

On Sat, 11 Sep 2004, Waldemar Brodkorb wrote:

> Hi,
> 
> yesterday we found a new tun/tap kernel extension for Mac OS X
> here:
> http://www-user.rhrk.uni-kl.de/~nissler/tuntap/
> 
> After some short testing and a small patch to OpenVPN
> the Mac OS X client seems to work correctly via the
> TAP device.
> 
> It would be nice if this patch and eventually 
> the driver could be integrated into openvpn like the
> win32 driver. 
> 
> If someone is interested we also would provide a binary
> package, which installs the tap/tun driver and OpenVPN on
> Mac OS X.

That would be great if you wanted to do it.  OpenVPN on OS X really needs 
a maintainer.

> Mattias Nissler: Thanks for providing this driver, there
> was a very short timeslice, where I was thinkning to do a tap
> kernel extension on my own ... but luckily Daniel Lehmann has some
> greater ability to use google correctly ;)

That's cool -- I didn't even know someone had written a new driver.

James


