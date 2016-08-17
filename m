Message-ID: <57B47C87.3000101@...1147...>
Date: Wed, 17 Aug 2016 17:02:31 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] AES-GCM & gigabit networks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi all,

just wanted to share some results with you:

AES-GCM has a *very* nice impact on openvpn's performance over gigabit 
networks. I'm now capable of saturating a gigabit ethernet link with 
full AES-256-GCM encryption (Linux on both ends).

Raw iperf results:
- ethernet:  935 Mbps
- plaintext tunnel: 920 Mbps
- openvpn aes-256-cbc + sha256: 640 - 670 Mbps
- openvpn aes-256-gcm:  900 - 907 Mbps

that's the saturation point for an OpenVPN tunnel: it's quite hard to 
squeeze more than 90 Mbps out of an OpenVPN tunnel on a 100 Megabit 
network - and now , similarly for gigabit.

Hardware used:
   client = i7 4810 ; max turbo = 3.8 GHz
   server = Xeon E5 2697A v4; max turbo = 3.6 GHz

but on all Intel AES-NI capable hardware you get a similar performance 
improvement.
And as always, clockspeed is king :)


Performance on Windows, however, is quite crappy - if someone can 
enlighten me how to improve performance on Windows then please contact 
me. For example, same network, same Linux, same client now running 
Windows 7: performance does not even reach 80 Mbps using iperf.

share and enjoy,

JJK


