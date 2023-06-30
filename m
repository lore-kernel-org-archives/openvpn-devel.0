Date: Fri, 30 Jun 2023 10:48:50 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZJ6W8gq6ymYIgpqH@...2685...>
References: <20230629215611.3292788-1-arne@...1227...>
 <20230629215611.3292788-5-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230629215611.3292788-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Check if the -wrap argument is
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

On Thu, Jun 29, 2023 at 11:56:10PM +0200, Arne Schwabe wrote:
> This avoids build errors on macOS. Also the test_tls_crypt command works
> just fine on FreeBSD with its linkers, so do not make that test Linux only.

NAK. Breaks build on mingw. Will investigate why.

Regards,
-- 
  Frank Lichtenheld

