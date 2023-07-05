Date: Wed, 5 Jul 2023 14:51:28 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZKVnUJIUfjafbBhP@...2685...>
References: <ZKVVvtdv4Ul88ABE@...2685...>
 <20230705122528.1625-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20230705122528.1625-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] openvpnmsica: link C runtime
 statically
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On Wed, Jul 05, 2023 at 03:25:28PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> By default CMake links C runtime dynamically,
> which doesn't work on Windows 7, for example.
> 
> This is not an issue with other openvpn binaries,
> since we bundle C runtime, but it is not yet available
> during installation.

Acked-by: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

