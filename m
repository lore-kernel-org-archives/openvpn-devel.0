MIME-Version: 1.0
In-Reply-To: <CAEsd45SxHOVk1PpsU-W8MUti1TmzYa7_BR1cAbUZ+mHxqfYEpg@...278...>
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
	<CAEsd45SxHOVk1PpsU-W8MUti1TmzYa7_BR1cAbUZ+mHxqfYEpg@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 26 Dec 2016 10:14:58 +0100
Message-ID: <CAA1AbxJRoaBmdEbfkvCkarz99Rxq16DJz41a-k+fHUiHXMoNtQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 26 December 2016 at 04:18, Jonathan K. Bullard <jkbullard@...277...> wrote:
> The OpenSSL included in macOS  (was OS X) 10.11 and 10.12 (the two
> most recent versions) is 0.9.8zh (an Apple-patched version) and as far
> as I can tell, it does not seem to include SHA256 (i.e., "openssl sha1
> foo" works but "openssl sha256 foo" doesn't).

Try "openssl dgst -sha256".

-Steffan

