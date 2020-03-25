Date: Wed, 25 Mar 2020 19:35:45 +0100
From: Michael Kress <lists@...1660...>
Message-ID: <20200325193545.59c59983@...1661...>
In-Reply-To: <efc9cf7f-7b20-bb92-08a1-8364490c579f@...1227...>
References: <20200323171156.295122f1@...1661...>
 <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
 <20200324143702.21f24651@...1265...>
 <efc9cf7f-7b20-bb92-08a1-8364490c579f@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Arne,

Am Wed, 25 Mar 2020 12:50:34 +0100
schrieb Arne Schwabe <arne@...1227...>:
> > 1) Do you run automated tests of the OpenVPN code on any build
> > server? 
> > 
> > 2) If that is the case, is there any test with a version, where 
> >    -DVERIFY_ALIGNMENT is enabled?
> > 
> 
> I never heard of this option and Google does not want to spit
> something out for me for that.

That's a #define in the OpenVPN code, for example in
src/openvpn/buffer.h line 943 ;-)
 
> Compression adds a one byte header in the packet making it all
> unaligned. The newer lz4 with swap, or v2 compression methods try to
> avoid this misaligned, mainly for speed on platforms where unaligned
> access comes with a penality.

Yes, so I think, that the size of the payload of the sent ICMP-Pings
over the Tunnel changes, if the LZO compression kicks in for this
packet or not.
 
> I think there might still be unaligned access that are in the code
> but I am not sure how to debug them. Is there an easy way to
> reproduce them? Can a RPI configured to throw those warnings?

Yes, just compile OpenVPN with the additional 
CFLAGS="${CFLAGS} -DVERIFY_ALIGNMENT"

Then increase verbositiy of the logs to 14 and grep the log for "ERROR"
Of course you have to enable --comp-lzo

RPI? You mean Raspberry PI?
Maybe on this machine the problem is not a problem. We also use OpenVPN
2.4.7 on a ARMv7, and there is no obvious problem, just on the old
ARMv4.

Finding all problematic places in the code will still be difficult.

-- 
Servus
  Michael

