Message-ID: <53D8246B.2060408@...1856...>
Date: Wed, 30 Jul 2014 00:47:07 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1406667144-17674-1-git-send-email-steffan@...1856...>
	<20140729212054.GB1118@...1296...>
In-Reply-To: <20140729212054.GB1118@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix frame size calculation for non-CBC
 modes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 29-07-14 23:20, Gert Doering wrote:
> On Tue, Jul 29, 2014 at 10:52:24PM +0200, Steffan Karger wrote:
>> CBC mode is the only mode that OpenVPN supports that needs padding. So,
>> only include the worst case padding size in the frame size calculation when
>> using CBC mode.
>>
>> While doing so, rewrite crypto_adjust_frame_parameters() to be better
>> readable, and provide debug output (for high debug levels).
> 
> Is this a bugfix or performance/packet size optimization?  I assume 
> "master only"?

More a bug than a packet size optimization, but neither really. It's
just something that was not correct.

Too-large frame parameters don't really seem to have an influence on the
actual connection. At least, for as far as I grasp the networking
code... (Please correct me if I'm wrong.) The calculated values are
reported to the user and peer. By default the tun-mtu is set to 1500,
and the link-mtu to 1500 + calculated overhead. If that calculated
overhead is too large, too large buffers are allocated, but the packets
actually sent are still limited by their real payload+overhead. If peers
don't agree on their link-mtu's they will issue a warning, but - as long
as the buffers are large enough - will still happily connect. Since
OFB/CFB has been fixed (very recently) in both master and release/2.3,
I'd say this fix should go into both.

-Steffan

