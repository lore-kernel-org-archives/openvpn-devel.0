From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063802542.39225@...41...>
Subject: [Openvpn-devel] TAP driver stalls on Linux
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
Date: Wed Sep 17 05:43:19 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

I'm testing a new version of OpenVPN which has the ability to lower the MSS on
TCP SYN packets as they pass through a tun or tap tunnel, similar to the
existing iptables capability.  I am testing by running FTP transfers over the
tunnel.

I am finding that everything works perfectly over tun tunnels.  The MSS is
lowered and TCP properly uses the MSS as an upper bound on TCP payload size.

On tap tunnels however, an FTP put appears to progress to the end of the data
transfer then stall just prior to data channel close.  The stall can be broken
by pinging the remote tunnel endpoint from the ftp client machine.  The ping
causes the FTP client to instantly complete the stalled transfer.

I am testing by running the tunnel between two x86 systems running Linux
2.4.22, both locally connected to a 100mbps ethernet LAN.  I have also tested
on 2.4.21 with the same results.

The test sequence is as follows:

(1) Start up OpenVPN on two locally connected Linux machines
(2) I'm using a fairly simple config and a cleartext tunnel
(3) Copy files ranging from 1 to 30 megabytes over the tunnel using FTP
(4) Use a lowered TCP MSS of 1000
(5) Quite often the FTP transfer will stall close to the end of the transfer
(6) Pinging the remote VPN endpoint unstalls the transfer and it completes
normally

I have checked fairly carefully to make sure this isn't a bug in OpenVPN. When
the stall occurs, OpenVPN is blocking on a select() that is waiting for data
to become available on the tap character device.  Pinging the remote tunnel
endpoint unblocks the select call as it should with readable data appearing on
the tap device.  The ping completes, triggering the resumption of the nearly
complete but stalled FTP transfer.  I have been unable to reproduce this
stalling behavior using tun (i.e. point-to-point IPv4) tunnels.  Only tap
(i.e. virtual 802.3 ethernet) tunnels show this stalling behavior.

Somehow the ping seems to kick the stalled TCP session into completing.

Has anyone else seen a similar problem?

James


