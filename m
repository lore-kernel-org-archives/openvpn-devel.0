Date: Thu, 30 Dec 2021 17:38:14 +0100 (CET)
Message-Id: <202112301638.1BUGcEMp081228@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211214150901.4118886-1-arne@...1227...>
References: <20211214150901.4118886-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Decouple MSS fix calculation
 from frame calculation
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

I've stared at the code (nice, things get simpler :-) ) and done
a few tests (v4 over v4, v4 over v6, ...) with "--mssfix 1000" and
looked at the resulting MSS values.  These are way different from
"master without this" - but arguably, closer to reality than what
we had before.

Old: BF-CBC,    --mssfix 1000 -> MSS 804 / 784
     AES256GCM, --mssfix 1000 -> MSS 856 / 876
New: BF-CBC,    --mssfix 1000 -> MSS 892 / 872
     AES256GCM, --mssfix 1000 -> MSS 904 / 884 

I have not done more sophisticated counting on whether the new values
are *correct*, but tcpdump claims they are:

- "AES256GCM, mssfix 1000", "ssh -4 $remote ls -lR"

16:55:40.171255 IP 194.97.140.11.51194 > 193.149.48.178.50377: UDP, length 1000
16:55:40.171267 IP 194.97.140.11.51194 > 193.149.48.178.50377: UDP, length 1000
16:55:40.171270 IP 194.97.140.11.51194 > 193.149.48.178.50377: UDP, length 1000

- "AES256GCM, mssfix 1000", "ssh -6 $remote ls -lR"

16:57:04.871238 IP 194.97.140.11.51194 > 193.149.48.178.50377: UDP, length 1000

- IPv6 transport is a also correct (which surprises me a bit, I have
  not seen a reference to the underlying protocol, which changes 
  the "headroom" we have).  At least, sometimes... with AES256GCM:

16:58:31.681280 IP6 2001:608:0:814::f000:11.51194 > 2001:608:4::ce:c0f.65297: UDP, length 1000
16:58:31.681289 IP6 2001:608:0:814::f000:11.51194 > 2001:608:4::ce:c0f.65297: UDP, length 1000

- over IPv6 transport, with BF, max packets are off by 8 bytes

17:13:54.561605 IP6 2001:608:0:814::f000:11.51194 > 2001:608:4::ce:c0f.28958: UDP, length 1008
17:13:54.561760 IP6 2001:608:0:814::f000:11.51194 > 2001:608:4::ce:c0f.28958: UDP, length 1008

  (which is closer to what I'd expect, but still weird, why not 1020?
   ... my machines do weird stuff here...)


That said, the code has been subjected to t_client tests as well, which were
uneventful (there is nothing that excercises TCP in there), as expected.


The new frame_calculate_mssfix() looks a bit confused regarding
"do we declare + initialize variables in one or two steps", and
"do we call it 'unsigned' or 'unsigned int'".  But this can be 
fixed in a followup cleanup patch ;-)

Not sure I understand what the old code does here, looking at
"tun_mtu_dynamic" - this looks like "adjust to discovered MTU",
but the documentation of --mssfix does not speak about this ... so
it will be interesting to revisit this (documentation + option)
eventually and see if/how we want to consider MTU discovery.

Your patch has been applied to the master branch.

commit d4458eed0c3cf582f787893f033a19cb4629cd76
Author: Arne Schwabe
Date:   Tue Dec 14 16:09:01 2021 +0100

     Decouple MSS fix calculation from frame calculation

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20211214150901.4118886-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23423.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


