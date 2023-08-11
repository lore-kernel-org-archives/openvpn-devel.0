Date: Fri, 11 Aug 2023 19:04:15 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZNZqD2EbdhBgJQkX@...2685...>
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-5-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230130172936.3444840-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/5] Add undefined and abort on error to
 clang sanaitize builds
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

On Mon, Jan 30, 2023 at 06:29:36PM +0100, Arne Schwabe wrote:
> The -fno-sanitize-recover=all flag ensures that for all errors we actually
> abort the tests in the automated testing and not just print some errors in red
> that nobody sess. Also add the undefined tests to catch more bugs.
> 
> For libreSSL we do not add the udefined behaviour as we have (even with the
> latest LibreSSL version) an undefined behaviour in LibreSSL itself.

Generally looks good to me. Needs rebase on current master.

Please while touching the ASAN stuff also change the ASAN build to use
Ubuntu 22.04 instead of Ubuntu 20.04. Getting a newer clang shouldn't hurt.
I tested it and it seems to work fine.

Note this need Patch 2/5 otherwise macOS GHA ASAN build fails. So can't be merged
before that.

Regards,
-- 
  Frank Lichtenheld

