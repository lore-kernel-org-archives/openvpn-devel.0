Message-ID: <53BAFFD3.2070207@...1856...>
Date: Mon, 07 Jul 2014 22:15:15 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1402244175-31462-5-git-send-email-steffan@...1856...>
	<201407072009.s67K9YQ0010531@...1295...>
In-Reply-To: <201407072009.s67K9YQ0010531@...1295...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Extend t_lpback tests to
 test all ciphers reported by --show-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 07-07-14 22:09, Gert Doering wrote:
> Your patch has been applied to the master branch.

Thanks. These are actually bugfixes for stuff that should just work in
2.3 too, so I suggest to apply these patches, including the preceding
OFB/CFB fix by Heiko (be46a2c083a6bd77754bc1674249eab583d25dac) to the
release/2.3 branch too. That will close trac ticket #89.

-Steffan

