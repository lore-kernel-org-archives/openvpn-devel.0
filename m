From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Setting source address for UDP replies on multihomed server
References: <16622.28948.53644.813410@...253...>
In-Reply-To: <16622.28948.53644.813410@...253...>
MIME-Version: 1.0
Message-Id: <200407091712.16595.vda@...216...>
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
Date: Fri Jul  9 07:13:36 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Neil Brown <neilb@...253...>, openvpn-devel@lists.sourceforge.net

Hi Neil.

On Friday 09 July 2004 13:19, Neil Brown wrote:
> My server that I hope to use as an OPENVPN server is multi-homed.
> i.e. it has multiple network interfaces and multiple addresses on
> multiple subnets.
>
> When my openvpn client (on my notebook) tries to talk to it, it
> sometimes gets a reply from a different IP address than it sent the
> request to, and it doesn't like that.
> This can be alleviated by using the --float option.  However that
> isn't a complete solution.
>
> When I try using openvpn from home, behind a NAT (masquerading) firewall,
> the reply from a different IP address doesn't get back to me, as the
> firewall doesn't know where to route those UDP packets.
>
> The "correct" solution would be to have openvpn get the destination
> address that was used for each incoming packet, record that, and set
> is as the source address when sending a reply.
>
> This is relatively easy to do (at least in Linux, possibly other POSIX
> os's).  The code link_socket_read_udp_posix in the patch below
> successfully gets the destination address, and the code added to
> link_socket_write_udp_posix sets the source address properly.
> I have checked this by removing the "if (0)" in the latter function,
> so the address is passed around in a global variable.

This is a common problem with UDP servers.

Recently I tried to fix this in ntp. To my great surprise and disappoinment,
ntp folks do not want it to be fixed.

Details at http://bugzilla.ntp.org/show_bug.cgi?id=314

I hope openvpn folks have clue and your patch will fare better.
--
vda


