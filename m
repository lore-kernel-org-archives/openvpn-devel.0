Date: Thu, 25 Aug 2022 10:19:09 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YwcwfaG7sulOVp4+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20220824165718.102002-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220824165718.102002-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix delcarion of pubkeys in
 test_provider.c in MSVC builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Typo "delcarion" in summary line

On Wed, Aug 24, 2022 at 06:57:18PM +0200, Arne Schwabe wrote:
>   Error: test_provider.c(74): error C2099: initializer is not a constant
> 
> Fix this issue by making the const char* to const char[]. This is probably
> of one the weird array decay corner cases
> 
> I could not find another/better way around this issue. Godbolt link to try:
> 
> https://godbolt.org/z/s3aPb9q8q

Do we really need that link here?

> This error only occurs when building unit tests with windows which our

Probably better MSVC instead of Windows. Or "MSVC on Windows".

> normal build system does not do but my out of tree cmake build script
> tries and fails

Actual change is trivial so

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

