References: <1482079255-15159-1-git-send-email-steffan@...1856...>
	<20161218212659.GY78624@...1296...>
	<965a4c27-5e16-59a8-db9c-930f1216f22c@...1856...>
	<CAEsd45SxHOVk1PpsU-W8MUti1TmzYa7_BR1cAbUZ+mHxqfYEpg@...278...>
	<CAA1AbxJRoaBmdEbfkvCkarz99Rxq16DJz41a-k+fHUiHXMoNtQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c498c7b8-43af-80ba-1858-4228cdaa1d07@...1227...>
Date: Mon, 26 Dec 2016 09:39:05 +0000
MIME-Version: 1.0
In-Reply-To: <CAA1AbxJRoaBmdEbfkvCkarz99Rxq16DJz41a-k+fHUiHXMoNtQ@...278...>
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
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 26.12.16 um 09:14 schrieb Steffan Karger:
> openssl dgst -sha256

works for me

[9:37]{SIGINT}arne@...2220...:~% openssl version
OpenSSL 0.9.8zh 14 Jan 2016
[9:37]arne@...2220...:~% openssl dgst -sha256
abcd^D
fc4b5fd6816f75a7c81fc8eaa9499d6a299bd803397166e8c4cf9280b801d62c
[9:37]arne@...2220...:~%

But anyway. I do not think supporting this ancient OpenSSL version is
wise idea. Even OpenSSH under OS X links against its own LibreSSL version.

Arne

