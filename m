Date: Wed, 12 Jul 2023 13:10:53 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZK6KPdXCI6pesssQ@...2685...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230712095529.570306-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230712095529.570306-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/4] Check if the -wrap argument is
 actually supported by the platform's ld
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

On Wed, Jul 12, 2023 at 11:55:29AM +0200, Arne Schwabe wrote:
> This avoids build errors on macOS. Also the test_tls_crypt command works
> just fine on FreeBSD with its linkers, so do not make that test Linux only.
> 
> Patch v2: allow running with old cmake version (cmake 3 on RHEL7 with EPEL
>           is only 3.17)
> Patch v3: add OPTIONAL keyword to Incldue required by some cmake versions

Yeah, I also have no idea why you didn't need that for your CMake. Anyway,
it is correct according to the documentation. And it is definitely required
on Ubuntu 20.04.

Tested on Ubuntu 20.04 (cmake 3.16.3), Ubuntu 22.04 (cmake 3.22.1), and
checked build results for GHA.

Acked-by: Frank Lichtenheld <frank@...2641...>

> Change-Id: Id26676bdc576c7d3d6726afa43fe6c7a397c579b
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  CMakeLists.txt | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

-- 
  Frank Lichtenheld

