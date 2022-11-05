Date: Sat, 5 Nov 2022 18:53:46 +0100 (CET)
Message-Id: <202211051753.2A5Hrkql074587@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221104125655.656150-1-arne@...1227...>
References: <20221104125655.656150-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Refactor/optimise code sending
 TLS control channel messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is a slightly complicated ACK - this is a respin of 1/3 v4 with
the "Ensure that control channel packet are respecting maximum packet size"
patch, which has an ACK from Frank Lichtenheld.  During testing of v4
I noticed that it it brings a regression for "very small packets"
(--link-mtu 440 and below) - not that these are overly useful, but if
it worked before, why shouldn't it stop afterwards?  So I started a
discussion on IRC which ended here.

Most of this patch is identical to "1/3 v4", except for a typo fix :-),
avoiding an integer underrun ("tmp.len > 0" now), removing the 2 byte
TCP length from "overhead", using the actual AF_ instead of always
going for AF_INET, and most important, the "maxlen < TLS_CHANNEL_BUF_SIZE"
that broke "very small packets" in v4 got changed to "for really really
small packets, we might exceed the MTU", but this is in the order of
"16 bytes payload".  Better die trying than not try at all...


The "if (maxlen < 16)" bit looks a bit strange, setting maxlen to 16
(okay) and max_pkt_len to TLS_CHANNEL_BUF_SIZE - if we get there with
maxlen = 16, max_pkt_len will also be something like "16" (assuming
rel_avail == 1 and no WKC) or maybe "32", but nowhere near 1250...
OTOH it is of no real significance, as "maxlen" controls how many
bytes we'll ever request as payload - so, 16+WKC, well below 1250.

I am a bit concerned that the inner loop in write_outgoing_tls_ciphertext()
could end up as an endless loop, if "max_pkt_len" ends up being <= 
"buf_len(session->tls_wrap.tls_crypt_v2_wkc))", so the max_int() 
ends up with "len == 0", buf_copy_n() copying nothing, and the loop
repeating "send packets with a WKC and nothing else", forever.

OTOH, this needs a very small MTU to start with, which is not possible
to trigger with this patch alone (--link-mtu below 125 is refused
with "TUN MTU value (nn) must be at least 100" error).  But I'd still
like either confirmation that I have overlooked something, or maybe
adjust the max_int() to "1, ..." so it's clear we'll always handle
1 byte per loop, whatever happens...


Another observation: getting rid of all the "if (maxlen<len)" checks
in the BIO path leads to extra alloc_buf_gc() calls to convey the
"maxlen" by means of the "tmp" buf.  Not sure if this is a good 
tradeoff... more alloc()/free() against a few less integer compares...
(but then, this is control channel, which is not the most critical
fast path).


There are a few other bits in here that need work, like a comment
talking about "frame->mtu_mtu" and "TLS_CHANNEL_BUF_SIZE" while the 
code does "1250" magic numbers - but these get fixed in 2/2.


This all said, I did my best to break master + this patch, and couldn't
find a way - so, merged.  I tested server side (without any special
MTU settings) and client side with --link-mtu $various, comparing the
UDP output I saw in tcpdump.  We're still exceeding the --link-mtu
value for some cases (--link-mtu 125 -> UDP payload 121 bytes for a
few packets, and "72" for very many of them, both not really "125"
- and I wonder where the 72 is coming from, leaving lots of space
unused.  With --link-mtu 200, the maximum I saw is 171 bytes, so 
at least this patch tends to underflow available MTU (and same thing
for 300/271, 400/371).  Will come back to this with 2/2 v6 :-)


Your patch has been applied to the master branch.

commit 4e9e25a9e547ab6e1f71003947a2d186dc231cb6
Author: Arne Schwabe
Date:   Fri Nov 4 13:56:54 2022 +0100

     Refactor/optimise code sending TLS control channel messages

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221104125655.656150-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25478.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


