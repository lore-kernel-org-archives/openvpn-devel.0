Message-ID: <551A972F.50103@...277...>
Date: Tue, 31 Mar 2015 14:46:39 +0200
From: Jiri Horky <jiri.horky@...277...>
MIME-Version: 1.0
References: <551A5509.702@...277...> <551A6EAA.8010109@...1114...>
In-Reply-To: <551A6EAA.8010109@...1114...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: FF Systems <ff-system@...2025...>


On 03/31/2015 11:53 AM, David Sommerseth wrote:
> On 31/03/15 10:04, Jiri Horky wrote:
>> Hi all,
>>
>> continuing yesterday's IRC discussion. I would like to ask whether you
>> can think of a reason why TUN_MTU_MIN is set to only 100 bytes, and
>> maybe more importantly, why this value is effectively enforced in function
>>
>> static void
>> tls_init_control_channel_frame_parameters(const struct frame
>> *data_channel_frame,
>>                  struct frame *frame)
>> ....
>>   /* set dynamic link MTU to minimum value */
>>   frame_set_mtu_dynamic (frame, 0, SET_MTU_TUN);
>>
>> We were debugging slow connection establishment on links with higher RTT
>> (>200ms), which takes about 7seconds. We tracked the problem down to
>> certificate handshake on a control channel, where client and server need
>> to exchange certificates which are about 3KiB each, and because the
>> enforced low MTU during tls init, and the fact that there are at maximum
>> 4 unacknowledged packets on wire (CONTROL_SEND_ACK_MAX), it takes quite
>> a lot of round trips to transfer it (it is clearly visible in wireshark,
>> that the openvpn fragments are exactly of 100Bytes).
>>
>> I tried to increase the TUN_MTU_MIN to 1000 (which should be safe on
>> nowadays Internet), which immediately helped.
>>
>> Before I make the change on our servers, I would like to understand
>> whether I may not break something by doing so.
>>
> Just to summarize what was said on the IRC chat as well.
>
> The frame_set_mtu_dynamic() sets the *dynamic* MTU on the *control
> channel*.  That should never go below TUN_MTU_MIN.
>
> It's good that you've found a potential bug, which is improved by
> increasing the TUN_MTU_MIN.  However, I believe it is wrong to just
> increase that value and be happy.  We need to understand better why the
> dynamic MTU on the control channel isn't set to a higher value in the
> TLS handshake process.
>
> You mentioned you saw in your logs:
>
>     Control Channel MTU parms [ L:1558 D:138 EF:38 EB:0 ET:0 EL:0 ]
>
> The D: field says here the dynamic MTU is starting at 138, while the L:
> is the link MTU.  Could you please enable debug logging and set
> verbosity level to 7 and see if you find any "MTU DYNAMIC mtu=" messages
> in your log file?  That should give an indication if the dynamic MTU is
> changing at all.\
Actually, this is exactly why I am asking here - to better understand
why it is enforced to MIN value in tls init.

Here is the log from client:

hotgeorge ~ # tail -n 10000 /var/log/messages | grep openvpn | grep -i MTU

<ar 31 14:42:30 hotgeorge openvpn[719]:   tun_mtu = 1500
Mar 31 14:42:30 hotgeorge openvpn[719]:   tun_mtu_defined = ENABLED
Mar 31 14:42:30 hotgeorge openvpn[719]:   link_mtu = 1500
Mar 31 14:42:30 hotgeorge openvpn[719]:   link_mtu_defined = DISABLED
Mar 31 14:42:30 hotgeorge openvpn[719]:   tun_mtu_extra = 0
Mar 31 14:42:30 hotgeorge openvpn[719]:   tun_mtu_extra_defined = DISABLED
Mar 31 14:42:30 hotgeorge openvpn[719]:   mtu_discover_type = -1
Mar 31 14:42:30 hotgeorge openvpn[719]:   mtu_test = 0
Mar 31 14:42:30 hotgeorge openvpn[719]: MTU DYNAMIC mtu=0, flags=1, 0 -> 138
Mar 31 14:42:30 hotgeorge openvpn[719]: Control Channel MTU parms [
L:1558 D:138 EF:38 EB:0 ET:0 EL:0 ]
Mar 31 14:42:30 hotgeorge openvpn[719]: MTU DYNAMIC mtu=1450, flags=2,
1558 -> 1450
Mar 31 14:42:30 hotgeorge openvpn[719]: Data Channel MTU parms [ L:1558
D:1450 EF:58 EB:135 ET:0 EL:0 AF:3/1 ]
Mar 31 14:42:30 hotgeorge openvpn[719]: Local Options String:
'V4,dev-type tun,link-mtu 1558,tun-mtu 1500,proto UDPv4,comp-lzo,cipher
AES-256-CBC,auth SHA1,keysize 256,key-method 2,tls-client'
Mar 31 14:42:30 hotgeorge openvpn[719]: Expected Remote Options String:
'V4,dev-type tun,link-mtu 1558,tun-mtu 1500,proto UDPv4,comp-lzo,cipher
AES-256-CBC,auth SHA1,keysize 256,key-method 2,tls-server'

Jirka H.


