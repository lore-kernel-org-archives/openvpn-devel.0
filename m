Resent-Message-ID: <20090704191407.GA14701@...1233...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Sat, 4 Jul 2009 21:08:53 +0200
From: Christof Meerwald <cmeerw@...1232...>
Message-ID: <20090704190853.GA17320@...1233...>
References: <eec247fc0906301008s527c6809ka944e7cb3cd85aab@...278...>
MIME-Version: 1.0
In-Reply-To: <eec247fc0906301008s527c6809ka944e7cb3cd85aab@...278...>
Subject: Re: [Openvpn-devel] OpenVPN packet structure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 30 Jun 2009 20:08:34 +0300, Cosmin Marin wrote:
> I was wondering if the payload of an OpenVPN packet has the same structure
> as a normal IP packet(ethernet header/ip header/tcp or udp header).

Depending on whether you are using tun or tap mode you either get the raw IP
packet or the raw ethernet frame in the OpenVPN packet.


> I know that OpenVPN adds fields like the packet header and data payload
> header after encryption and another IP header and TCP/UDP header, but
> i have been trying to get the old ip source and destionation addresses after
> i have decrypted the packet and i am out of luck.

The easiest thing might be to start with "cipher none" to disable encryption
and have a look at the packets.


Christof

-- 

http://cmeerw.org                              sip:cmeerw at cmeerw.org
mailto:cmeerw at cmeerw.org                   xmpp:cmeerw at cmeerw.org

