Date: Wed, 2 Feb 2022 12:27:10 +0100 (CET)
Message-Id: <202202021127.212BRAD7022744@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220101162532.2251835-3-arne@...1227...>
References: <20220101162532.2251835-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix mssfix and frame
 calculation in CBC mode
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

This came out of discussions on the "last" mssfix patch (d4458eed0c3,
"Decouple MSS fix calculation") where I discovered that sometimes we'd 
still see too-big payloads for BF-CBC - this was a rounding issue, and 
also an interpretation issue on "which parts of the frame are considered 
'plaintext' or 'header', depending on CBC vs. AEAD mode".  See this:

https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23481.html

Stared at code, scratched my head, tested client and server side
("normal packet tests" - everything passes) and explicitly tested 
combinations for resulting packet size.

Thus, tested:

 - BF-CBC, LZ4 (pushed), --mssfix 1000, over IPv4
     v4 TCP -> MSS 923, resulting UDP payload <= 1008 bytes
     v6 TCP -> MSS 903, resulting UDP payload <= 1008 bytes
 - BF-CBC, LZ4 (pushed), --mssfix 1000, over IPv6
     v4 TCP -> MSS 923, resulting UDP payload <= 1008 bytes
     v6 TCP -> MSS 903, resulting UDP payload <= 1008 bytes
     [so this is clearly wrong, but see below]

 - BF-CBC, comp no, --mssfix 1000, over IPv4
     v4 TCP -> MSS 923, resulting UDP payload <= 1000 bytes
     [OK]

 - AES256GCM, LZ4, --mssfix 1000, over IPv4
     v4 TCP -> MSS 935, resulting UDP payload <= 1000 bytes
     v6 TCP -> MSS 915, resulting UDP payload <= 1000 bytes
 - AES256GCM, LZ4, --mssfix 1000, over IPv6
     v4 TCP -> MSS 935, resulting UDP payload <= 1000 bytes
     v6 TCP -> MSS 915, resulting UDP payload <= 1000 bytes

 - AES256GCM, comp no, --mssfix 1000, over IPv4
     v4 TCP -> MSS 936, resulting UDP payload <= 1000 bytes

--> so it looks as if the CBC code is not handling the compression
framing and then rounding up and down and sideways correctly...

I've discussed this with Arne, and the result of that was "it's due
to option recalculation wackiness if cipher does not change, but
other options do".

So, the failing test above has no compression setting in the client
config *but* permits pushed LZ4.  If I change that towards
"client has compress lz4", the result changes:

 - BF-CBC, LZ4 (config), --mssfix 1000, over IPv4
     v4 TCP -> MSS 922 (from 923), resulting UDP payload <= 1000 bytes
     v6 TCP -> MSS 902 (from 903), resulting UDP payload <= 1000 bytes

so the resulting packets are correct.  The fix for the underlying issue
comes later in the patch series.


Given that these corner cases have been wrong all the time, it makes
sense to merge this patch as it is (nothing is getting worse), and 
re-test when the dewackyfying patch is in.


I have fixed one comment in mss.c

Your patch has been applied to the master branch.

commit 5b3c8ca869766de2c94eb7dd4450b0d9ab1c75fc
Author: Arne Schwabe
Date:   Sat Jan 1 17:25:20 2022 +0100

     Fix mssfix and frame calculation in CBC mode

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220101162532.2251835-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23494.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


