Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN
	startup on Linux
From: Paul Iadonisi <pri.openvpn@...317...>
In-Reply-To: <200411181606.51256@...187...>
References: <1100737211.8135.32.camel@...318...>
	 <1100764891.19571.15.camel@...318...>
	 <Pine.LNX.4.58.0411180452440.6370@...41...>  <200411181606.51256@...187...>
Message-Id: <1100886608.17021.7.camel@...320...>
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
Date: Fri Nov 19 09:52:03 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Thu, 2004-11-18 at 16:06 +0200, Doncho N. Gunchev wrote:

> 
>     Just an idea, would it be acceptable to you bouth if it is done like
> this:
> ---
> TYPE=OpenVPN
> DEVICETYPE=tap1 # or tun1
> OpenVPNCFG=/etc/openvpn/client.conf # or /etc/openvpn/server.openvpn
> USERCTL=no # yes? - use RH/FC's idea to start it
> ONBOOT=yes # no
> USEDIF=eth0 # what other interface is needed up to work, maybe...?
> ---
>     This way the 'real' configuration, except giving users the right to
> start/stop the vpn tunnel, is kept in openvpn's config file, but leaves
> a root for managing with distro's specific configuration tool(s) or by
> hand. Fedora's system-config-network can be extended with OpenVPN specific
> GUI for OpenVPN config file editing too...
>     Is this OK? I hope this scenario will work for most other distros too?
> 
> Just my 0.02 lv :)

  After some thought, I actually like this idea, as it preserves what
appears to be the general consensus that the config file should be
portable across platforms, yet allows for the use of ifup to start
specific VPNs instead of 'service openvpn start' which starts all
tunnels.  One thing I'd probably still check for, though, is the 'dev'
option ... I would probably disallow it in the openvpn *.conf file and
just spit out a statement to that fact.  Only because it conflicts with
the usual way of specifying the DEVICE in the ifcfg-* file.
  Stay tuned ... I may have an updated version in the near future that
does just this.  Actually, it's too easy *not* to implement it. :-)  I
may, however, hang onto my original versions just for posterity's
sake ... bash is just so cool.

-- 
-Paul Iadonisi
 Senior System Administrator
 Red Hat Certified Engineer / Local Linux Lobbyist
 Ever see a penguin fly?  --  Try Linux.
 GPL all the way: Sell services, don't lease secrets


