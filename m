From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] route option deleting routes it didn't set
References: <20040528142953.GG1243@...30...>
In-Reply-To: <20040528142953.GG1243@...30...>
MIME-Version: 1.0
Message-Id: <200405282334.29774.vda@...216...>
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
Date: Fri May 28 13:36:06 2004
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Alberto Gonzalez Iniesta <agi@...5...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Friday 28 May 2004 17:29, Alberto Gonzalez Iniesta wrote:
> Hi,
>
> We got a bug report at Debian [1] regarding the route option.
> It turns out that if a route added by openvpn is later
> modified (removed and added to other iface), openvpn will modify
> (delete) the later one.
>
> As the bug submitter states, maybe openvpn should specify the device it
> wants the route deleted from.

I think openvpn's routing options are intended for 'typical use' only.
It is impossible for openvpn to know each and every non-trivial setup
possible.

If you modify openvpn-created route after it starts, your setup
is at least a bit non-typical.

Use:
       --route-up cmd
              Execute shell command cmd after routes  are  added,  subject  to
              --route-delay.
       --route-noexec
              Don't add or remove routes automatically.  Instead  pass  routes
              to --route-up script using environmental variables.
       --up cmd
              Shell  command  to run after successful TUN/TAP device open (pre
              --user UID change).  The up  script  is  useful  for  specifying
              route  commands which route IP traffic destined for private sub-
              nets which exist at the other end of the VPN connection into the
              tunnel.

or, if you are really drowning in tons of interfaces going up and down,
run routing daemon, like zebra. I did not need it, yet, but eventually will do :)
--
vda


