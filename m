Date: Mon, 4 Dec 2023 18:31:45 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZW4NASDboM9fxvL1@...2685...>
References: <20231204153345.1146-1-marc.becker@...2704...>
MIME-Version: 1.0
In-Reply-To: <20231204153345.1146-1-marc.becker@...2704...>
Subject: Re: [Openvpn-devel] [Openvpn-Devel] [PATCH]
 vcpkg-ports/pkcs11-helper: bump to version 1.30
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
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Dec 04, 2023 at 04:33:45PM +0100, Marc Becker via Openvpn-devel wrote:
> update metadata references for pkcs11-helper v1.30
> remove local patches incorporated in new upstream
> ---
>  .../Fix-build-with-disable-shared.patch       |  48 --------
>  ...cs11-helper-002-dynamic_loader_flags.patch | 104 ------------------
>  .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   6 +-
>  contrib/vcpkg-ports/pkcs11-helper/vcpkg.json  |   2 +-
>  4 files changed, 3 insertions(+), 157 deletions(-)
>  delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
>  delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
> 

Changes look reasonable. Build succeeds.

Acked-By: Frank Lichtenheld <frank@...2641...>

-- 
  Frank Lichtenheld

