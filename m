From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] [Patch] Allow multiple TAP devices without
 --dev-node on Windows
In-Reply-To: <Pine.LNX.4.60.0410070800170.32236@...210...>
Message-ID: <Pine.LNX.4.58.0410070418070.4721@...269...>
References: <Pine.WNT.4.60.0410051208240.27592@...254...>
 <Pine.LNX.4.60.0410070800170.32236@...210...>
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
Date: Thu Oct  7 03:34:23 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 7 Oct 2004, Mathias Sundman wrote:

> On Tue, 5 Oct 2004, Mathias Sundman wrote:
> 
> > I was going to ask for a feature yesterday, but though I'd write it myself 
> > instead of just asking for others todo things for me :-)
> >
> > I have about 15 OpenVPN configs on my Windows machine, but I only use 2-3 
> > simulatainously. But, as I need be able to connect to more than one site, 
> > I've had to create one TAP device for EVERY config file, as I had to specify 
> > the the dev-node in every config if I had installed more than one TAP device.
> >
> > With the attached patch this behavior is modified so that if dev-node is not 
> > specified, OpenVPN tries to open the first TAP device is finds. If 
> > CreateFile() fails on this device, it moves on and tries to open next device.
> >
> > If all CreateFile() fails on all avaiable TAP devices, first then openvpn 
> > terminates.
> >
> > This works great as long as all TAP configuration is done dynamically from 
> > OpenVPN which is always the case for me. If you have static configuration 
> > done on the TAP devices, you need to use dev-node to specify which device to 
> > use anyway, so I don't think this patch should brake anything.
> 
> Now that Eric Tanner has showed us how we can install the TAP device as 
> hidden this patch became even more useful, as it's a little troublesome to 
> change the TAP device name, when it's not visible in "Network Connections" 
> :-)

Yes, the NCF_HIDDEN flag in the INF file is rather cool, if not a bit
subversive.  I modified the TAP-Win32 code a while back to not depend on
an adapter being listed in the Network Connections panel so that
NCF_HIDDEN would work.  If it's hidden, you can still open it by name, but
you must use the GUID name.  The Network Connections panel is basically a
link from a friendly name to the GUID name.

> James, could you consider applying this patch for the beta12 release?
> 
> If there's something with the patch you dislike or would like to have 
> implemented in a diffrent way, let me know, and I'll try fixing it...

Yes, I do plan to merge it.

James


