From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Prefixed bytes
In-Reply-To: <1109580659.4222db737a0b4@...358...>
Message-ID: <Pine.LNX.4.58.0502281139400.23437@...41...>
References: <1109580659.4222db737a0b4@...358...>
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
Date: Mon Feb 28 10:49:04 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Bram <openvpn@...357...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 28 Feb 2005, Bram wrote:

> Hello,
> 
> 
> According to this message:
> http://sourceforge.net/mailarchive/message.php?msg_id=10639223 OpenVPN adds a
> cleartext uint16_t length word before every packet, now my question is this: is
> it always the same word? where is it defined/calculated etc?

A uint16_t word is used to packetize TCP streams.  It's not used with UDP 
because UDP is already packetized (so the equivalent length would be in 
the header).

It's not always the same word -- it is a packet length, and will vary with 
every packet.

It's calculated by the stream_buf_x functions in socket.[ch]

James

