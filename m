References: <1475491887-740-1-git-send-email-samuli@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <88327304-036d-1ee5-524f-8f0d875e33a1@...1227...>
Date: Tue, 4 Oct 2016 10:54:39 +0200
MIME-Version: 1.0
In-Reply-To: <1475491887-740-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Automatically cache expected IPs for
 t_client.sh on the first run
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: samuli@...515..., openvpn-devel@lists.sourceforge.net



Am 03.10.16 um 12:51 schrieb samuli@...515...:
> From: Samuli Seppänen <samuli@...515...>
>
> Previously one had to manually define correct values for the EXPECT_IFCONFIG*
> variables based on what IPv4 and IPv6 addresses the test VPN server handed out.
> This was a tedious process especially with large number of tests, as the IPs
> changed for every test client and for every test. With this patch t_client.sh
> figures out the correct IP addresses using an --up script and caches them to a
> separate file for later use.
>
>
I removed all EXPECT_IFCONFIG for test 1-6 from my config and it worked.
Also the code looks fine, so ack from me.

(If we later add a test with --up we can figure that out later.
Currently the added comfort is great)

Arne

