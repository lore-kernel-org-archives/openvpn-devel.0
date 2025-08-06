Message-ID: <ebe735de-ee37-4cc2-aa41-1ac10f8744b4@...1227...>
Date: Wed, 6 Aug 2025 07:34:03 +0200
MIME-Version: 1.0
References: <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ.ref@...278...>
 <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAOh3LPOwuAO84y7kUcWNQFVes8rwRg6WZ9dAUBTAqLTrDMtaLQ@...278...>
Subject: Re: [Openvpn-devel] Modifying OpenVPN Source Code to Allow for
 Bulk-Reads, Max-MTU, and Jumbo-TCP
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

Am 06.08.25 um 05:46 schrieb Jon Chiappetta via Openvpn-devel:
> Hi,
> 
> This is my first time posting to a mailing list. I worked on a possible 
> performance proof-of-concept modification to the OpenVPN source code. 
> The code is in rough shape as I just wrote it this long weekend but I 
> wanted to see if anyone had any interesting feedback for such work.
> 
> Blog Post: https://fossjon.com/2025/08/05/modifying-openvpn-source-code- 
> to-allow-for-bulk-reads-max-mtu-and-jumbo-tcp-for-highly-improved- 
> performance/ <https://fossjon.com/2025/08/05/modifying-openvpn-source- 
> code-to-allow-for-bulk-reads-max-mtu-and-jumbo-tcp-for-highly-improved- 
> performance/>
> 


 > Max MTU which now matches the rest of your network clients (1500 bytes)

I have no idea what this means. OpenVPN always supported different MTU 
sizes and MTU 1500 is standard.

 > Bulk reads from the tun interface (6 reads)
 > TCP connection protocol only (single jumbo write transfers)
 > Performance improvements now allows for (6 reads x 1500 bytes == 9000 
bytes)


So basically, from your explanation the main thing is to try to 
write/read multiple packets in one batch on the TCP socket instead of 
just reading/writing a single packet.  I can see that this improves 
performance.

Do you have any idea how much this actually improves performance? Your 
blog post shows a speedtest with 500 MBit/s but that is not actually 
saying much. In my own test setup, the current OpenVPN is capable over a 
Gigabit, a before/after from your test setup would nice to see.

> POC Diff: https://github.com/stoops/openvpn/compare/main <https:// 
> github.com/stoops/openvpn/compare/main>…mods

Might be good enough for a POC but from quick glance it looks like there 
needs to cleanup make this an actual commit.
> 
> If this is the wrong place I apologize in advance,
> Thanks for your time,

No, this is the right place.

Arne

