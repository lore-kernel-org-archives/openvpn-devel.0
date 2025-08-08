Message-ID: <ad04ec91-f397-4048-b65c-a96a3b48000c@...1227...>
Date: Fri, 8 Aug 2025 11:53:22 +0200
MIME-Version: 1.0
References: <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA.ref@...278...>
 <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA@...278...>
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
 [updated]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Jon Chiappetta <root@...2904...>, openvpn-devel@lists.sourceforge.net

Am 07.08.25 um 20:29 schrieb Jon Chiappetta via Openvpn-devel:
> Thanks to Gert's help on this, I was able to finally configure and 
> compile and run and test the bulk mode changes against the latest git 
> source code to ensure everything still works correctly.
> 
> I also fixed up some other issues like properly freeing the extra buffer 
> allocations and removing the unneeded batched data prefixes and 
> converting a remaining while loop to a max limited for loop and properly 
> resetting the outgoing tun buffer pointer at the end of the write method 
> when finished.


It would still good to explain what you are trying to achieve here and 
what the idea behind the patch is to be able to review and understand 
your patch.

The patch itself basically has no comments at all, so it is very hard to 
decipher for me from the patch what it is trying to to do. Eg there is a 
variable flag_ciph that fiddles with encryption of packets.

You are talking and describing this bulk mode as if it was obvious but 
it is not. The description on your blog says:

 > [...] read 8192 bytes off of the client’s TCP sockets directly and
 > proxy them in one write call over TCP directly to the VPN server
 > without needing a tunnel interface with a small sized MTU which
 > bottlenecks reads+writes to <1500 bytes per function call.

It also not helping as you talking about TCP write/reads, where I can 
see some improvement by cutting down the number of reads/writes. But the 
second part then talks about not using a tunnel with a small sized MTU.
But if you use a larger sized TUN interface with a larger MTU, then you 
already have larger reads/writes to the TCP socket.

Also your speedtest showing 562 is meaningless without having any 
comparison without your patch.

Arne

