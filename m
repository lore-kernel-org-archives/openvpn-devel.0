References: <1448707105-10753-1-git-send-email-steffan@...1856...>
	<1448707105-10753-2-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <565987C5.7020305@...1227...>
Date: Sat, 28 Nov 2015 11:53:57 +0100
MIME-Version: 1.0
In-Reply-To: <1448707105-10753-2-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix rand_bytes return value checking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 28.11.15 um 11:38 schrieb Steffan Karger:
> This patch is in response to an off-list report by Sebastian Krahmer of
> the SuSE security team.  Sebastian noticed we do not check the return
> value of rand_bytes() in prng_bytes(), which we really should.

ACK. Asserting on failed random seem reasonable.

Arne


