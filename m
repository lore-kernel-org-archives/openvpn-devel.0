MIME-Version: 1.0
In-Reply-To: <CAA1Abx+fvhCoDNhKF44UmwZm7Xm-k_+gQ8gTCwCrw2UDtdPsDg@...278...>
References: <1445597397.4113.184.camel@...1866...>
	<CAA1Abx+fvhCoDNhKF44UmwZm7Xm-k_+gQ8gTCwCrw2UDtdPsDg@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 26 Oct 2015 00:15:43 +0100
Message-ID: <CAA1Abx+z_BmrZgR-2MFBmqFS8QK6LOeN1FDDfZSGQw1_EUgq4w@...278...>
Subject: Re: [Openvpn-devel] [RFC] --passtos default on/off, and IPv6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Oct 26, 2015 at 12:09 AM, Steffan Karger <steffan@...1856...> wrote:
> For
> covert channels, it means 23 possible values per 1500-byte packet, or
> ~5 bits for BF, and 12 possible values (~4 bits) for AES-CBC. That is
> still less than the 8 bits QoS/ToS.

Grmbl, at the moment I hit send I realize I messed up bytes and bits
in this back-of-the-envelope calculation.  For 1500-bytes packets,
there are 187 possible lengths (~8 bits) for BF-CBC, and 93 possible
lengths (~7 bits) for AES-CBC.  So just barely less than QoS/ToS, but
--passtos would still double the bandwidth.

-Steffan

