References: <1448707105-10753-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <565987F8.1050409@...1227...>
Date: Sat, 28 Nov 2015 11:54:48 +0100
MIME-Version: 1.0
In-Reply-To: <1448707105-10753-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] openssl: properly check return
 value of RAND_bytes()
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
> value of RAND_bytes() correctly.
> 
> The RAND_bytes() man page first says "RAND_bytes() returns 1 on success,
> 0 otherwise.", but then a bit later "Both functions return -1 if they are
> not supported by the current RAND method.".  This second case was not
> covered by our return value checking.
> 
> Note that if RAND_bytes() would return -1, it would *always* return -1 and
> fail to generate random.
> 
> Also note that if RAND_bytes() would return -1, it would do so too in the
> openssl internal ssl funtions.  The openssl internal function do check the
> return value properly, and connection setup would fail all together.  If
> that would be at least somewhat common, we would have received a *lot* of
> bug reports.  In other words, the error affects static key setups only,
> and seems highly unlikely to occur in actual setups.
> 
> Only builds using OpenSSL as the crypto backend are affected.
> 
> This patch:
> 1. Changes the behaviour of rand_bytes() in openssl builds to match what
>    the doxygen claims (and polarssl builds already do).
> 2. Adds error reporting for RAND_bytes() failures.
>

ACK. Reasonable change. You cannot be too careful with crypto/RNG.

Arne


