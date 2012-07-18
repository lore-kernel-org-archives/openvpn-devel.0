Message-ID: <5006B1FA.7070706@...1741...>
Date: Wed, 18 Jul 2012 14:54:18 +0200
From: Kai <kai2@...1741...>
MIME-Version: 1.0
References: <1f69c81878808ec20acd5bf8c1ae05c0@...23...>
In-Reply-To: <1f69c81878808ec20acd5bf8c1ae05c0@...23...>
Subject: Re: [Openvpn-devel] ps.c and function is_openvpn_protocol
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello all,

May one please tell me where a good resource is to understand the 
OpenVPN message structure?

I can than try to answer my questions myself.

Many thanks,
Kai

Am 17.07.2012 01:16, schrieb Kai:
>   Hello all,
>
>   While using SSLH ( www.rutschle.net/tech/sslh.shtml ) which tries to
>   use function is_openvpn_protocol from the OpenVPN implementation as much
>   as possible to detect OpenVPN connections (with only one difference), I
>   found that I can not detect OpenVPN connections when they are
>   established via shared secret (via option 'secret
>   /etc/openvpn/somStaticKey.key'). The point is that for shared secret
>   exchanges byte 3 of the initial message is ignored and hence filled by
>   the client with rand data. This leads to randomly having connections
>   even when using shared secrets and if being unlucky it can take up to 20
>   minutes of retries until I can connect.
>
>   After researching, I have the following questions to understand this
>   behavior:
>
>   ____________________________
>   /*
>    * Given either the first 2 or 3 bytes of an initial client -> server
>    * data payload, return true if the protocol is that of an OpenVPN
>    * client attempting to connect with an OpenVPN server.
>    */
>   bool
>   is_openvpn_protocol (const struct buffer *buf)
>   {
>     const unsigned char *p = (const unsigned char *) BSTR (buf);
>     const int len = BLEN (buf);
>     if (len >= 3)
>       {
>         return p[0] == 0
>           && p[1] >= 14
>           && p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2<<P_OPCODE_SHIFT);
>       }
>     else if (len >= 2)
>       {
>         return p[0] == 0 && p[1] >= 14;
>       }
>     else
>       return true; // SSLH returns 0 at that point
>   }
>   ____________________________
>
>
>   1. Because byte 1 + 2 define the message length, shouldn't be the
>   following check better than 'p[0] == 0 && p[1] >= 14;'?
>
>    int packet_len = (p[0]<<8) + (p[1]);
>    if(len - 2 == packet_len) ...
>
>   This worked well in one of my tests. I only tried with shared secret
>   but even in case of the shared secret, the packet_len is set properly.
>
>   2. Why only checking for P_CONTROL_HARD_RESET_CLIENT_V2 but not for
>   P_CONTROL_HARD_RESET_CLIENT_V1 here as well?
>
>   3. Check 2 is only executed if the len is exactly 2. Which kind of
>   empty OpenVPN message does set the message length field to a value that
>   does not fit the message length?
>
>   4. The last 'else' block is only called and says "this is a OpenVPN
>   message" if the message has a length of 0 or 1 independent of which
>   value byte 1 has. I also did not find which kind of initial OpenVPN
>   messages look like this.
>
>   5. Finally, I'm seeking for a good criteria to identify OpenVPN initial
>   messages if a shared secret is used. What would be a good probe for
>   that? Is there any other in addition to 'if(len - 2 == packet_len)' as
>   described in point 1?
>
>   Many thanks for all input
>   /Kai
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


