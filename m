From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] First post and an alternative idea for OpenVPN
 startup on Linux
In-Reply-To: <1100737211.8135.32.camel@...318...>
Message-ID: <Pine.LNX.4.61.0411180705550.7280@...210...>
References: <1100737211.8135.32.camel@...318...>
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
Date: Wed Nov 17 22:26:08 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Paul Iadonisi <pri.openvpn@...317...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Wed, 17 Nov 2004, Paul Iadonisi wrote:

>  While working with various setups, I felt there might be a better way 
> to start up the VPN(s) with a little more granularity.  In fact, at 
> least in the case of Fedora Core (2 and 3 in my case), I thought it 
> might be a good idea to integrate it into the /etc/sysconfig/network- 
> scripts infrastructure so that I could just type 'ifup vpntowork' or 
> 'ifup vpntoworksite2' to bring up individual vpn interfaces.
>  A few days later, I now have a pretty good set of scripts that do just
> that.  And to top it off, I have a workaround now for a problem that has
> been discussed on this list regarding chroot and/or uid/gid settings:
> running a --down script that needs root access.  In my setup, I have two
> wrapper scripts, upwrap-openvpn and downwrap-openvpn, which invoke the
> user's specified --up and --down scripts respectively.  However,
> downwrap is not passed to openvpn; it is instead run by the ifdown-
> openvpn script.  Details are in comments in the scripts themselves.
>  One thing I haven't commented on in the scripts is that both TYPE and
> DEVICETYPE need to be set (TYPE=OpenVPN and DEVICETYPE=openvpn) in your
> ifcfg-<interface-or-nickname> script.  Normally, you don't set
> DEVICETYPE in ifcfg-<interface> scripts -- it is used internally by
> 'ifup'.  The proper way to do this is to actually patch a case statement
> in ifup, but I figured I'd take care of that after I determined how much
> interest there was in this.
>
> ...
> 
> DEVICE=tap0
> ONBOOT=no
> USERCTL=yes
> TYPE=OpenVPN
> DEVICETYPE=openvpn
> #
> MODE=client
> UP=client.up
> DOWN=client.down
> PROTO=udp
> REMOTE="my-server-host 5000"
> RESOLV_RETRY=infinite
> NOBIND=yes
> CA=sample-ca.crt
> CERT=sample-cert.crt
> KEY=sample-key.key
> TLS_AUTH="ta.key 1"
> COMP_LZO=yes
> VERB=4

I think it's a good idea to have simple "redhat look-alike" scripts to 
start / stop individual openvpn tunnels, to make life easier for users.

But, I hounestly dislike the idea of introducing a new config file format 
like this. I don't really see the purpose. Why not just refer to an 
OpenVPN config file instead?

Perhaps this makes it easier in the short run for users to get going, but 
when they run into problems and start digging in the OpenVPN documentation 
or asks questions here on the forum, I think it will just cause confusion 
having the configuration in an other place, and in a slightly diffrent 
format.

It will also make it harder to cut and paste sample configs, or move 
configs betweens diffrent platforms.

Just my $0.02.

/Mathias

