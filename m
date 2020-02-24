MIME-Version: 1.0
References: <88cfd76e-a163-28a0-d4f4-d23c41f902d7@...2542...>
 <43700754-2df3-3090-7808-39fc9c081b97@...2542...>
In-Reply-To: <43700754-2df3-3090-7808-39fc9c081b97@...2542...>
From: Derek Zimmer <derek@...2095...>
Date: Mon, 24 Feb 2020 13:33:44 -0600
Message-ID: <CAJY0qZLBtpQz0=PzsCkuMyaCG=7vR9wqxSo9F+93YakgpJXKgw@...278...>
Subject: Re: [Openvpn-devel] MTU auto-discovery
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Radu Hociung <radu.ovpndev@...2542...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

I'm thinking that this feature would need to be able to be toggled
on/off, because it will be noisy on networks that are trying to
circumvent censorship systems, making for easy discovery of openvpn
tunnels in Egypt / China / India / etc.

It does look like a significant improvement for normal uses of OpenVPN, though.

Derek Zimmer
Chief Executive Officer
Open Source Technology Improvement Fund

On Mon, Feb 24, 2020 at 1:26 PM Radu Hociung <radu.ovpndev@...2542...> wrote:
>
> Hello,
>
> I would like to gauge interest in including my upcoming MTU patch into
> the 2.5 release, and also to notify you that I am working on this patch,
> to avoid effort duplication, if any.
>
> Description of the "MTU auto-negotiation" patch:
>
>         MTU settings will be fully auto-negotiated between server and
>         client, making most if not all related options unnecessary,
>         such as --tun-mtu, --link-mtu, --mssfix, --fragment, etc.
>         Interoperation with old (pre-patch) servers and clients will be
>         guaranteed by design and tested with the included test suite.
>
> Summary of operation:
>         Peers will use the P_CONTROL_HARD_RESET_* messages to do Path
>         MTU discovery, and configure their own send/receive buffers
>         accordingly. The "reliable" layer's ability to ACK packets it
>         can receive, including repeated packets, is leveraged.
>         The algorithm will re-send one or more HARD_RESET_* messsages,
>         padded to a larger size, after the initial reset packet is
>         acked by the remote, in order to discover the largest packet
>         the remote can receive (and thus ack). Regular TLS handshake
>         will start after one padded HARD_RESET message is acked, with
>         frame buffer parameters set appropriately.
>
>         After the connection is established, Path MTU will be monitored
>         with a new PING message over the TLS channel, configurable with
>         an option like "--ping-pmtud <number>" that will complement or
>         replace the regular "--ping" which is sent over the data
>         channel. Each peer will adjust the max size of packet
>         transmitted over the link when/if the reliable --ping-pmtud
>         indicates the path MTU has decreased.
>
>         The TUN interface MTU setting will be adjusted dynamically
>         as a result of link PMTUD results, if possible.
>
>         The patch will generate ICMP messages "fragmentation needed"
>         on the TUN interface to handle the case where interface MTU
>         cannot be changed, and also the client-to-client communication
>         case where a client with a larger link-mtu sends traffic to a
>         client with a smaller link-mtu (as described in RFC1191)
>
>         The user-facing configuration like --link-mtu etc, are
>         deprecated, and only indicate ceiling values, while the PMTUD
>         algo will set buffers to smaller sizes if needed. In the future,
>         these options should be completely ignored, and/or obsoleted.
>
> Testing:
>         The patch will include a comprehensive test suite that can be
>         run (unattended) to verify inter-operation with other versions
>         of ovpn, and with various combinations of settings like cipher,
>         compression, link MTU, etc. The test suite requires two hosts
>         (server and client), with root capability, as to vary the link's
>         MTU configuration. The host running the test suite runs
>         the server side of the test, and it starts a client with the
>         appropriate configuration on the other host, via ssh. It
>         requires both test host to have access to a shared filesystem,
>         and installed older versions of ovpn in addition to the patched
>         version.
>
> I am developing this patch on the 2.3 branch, as that is what I use for
> my networking needs, but the files I am touching have not changed in
> incompatible ways on the master. At the moment, the "Great
> Reformatting" commit is the biggest stumbling block to rebasing this
> patch to the master.
>
> Also, I don't have the resources to test it on anything other than
> Linux, but I am hoping that the existing continuous integration magic
> will help overcome this limitation.
>
> At the moment, I expect it will take another two weeks until the patch
> is ready to be released on 2.3
>
> Any comments or offers to assist with testing are welcome. Specifically,
> how does this patch fit in with the release plans for 2.5 or 2.6+?
>
> Thank you
> Radu Hociung.
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

