MIME-Version: 1.0
References: <20221211200108.1402-1-marc.becker@...2704...>
 <20221214143325.2604-1-marc.becker@...2704...>
In-Reply-To: <20221214143325.2604-1-marc.becker@...2704...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 15 Dec 2022 09:46:54 +0200
Message-ID: <CAGyAFMV=5Gxr9f8RY5Acmqk_rzRc1WzJ3urxZxY6VRA+WVpLYQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] vcpkg-ports/pkcs11-helper: support
 loader flags
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

I applied this pach locally, cleared vcpkg_installed directory and
verified that vcpkg indeed applied this patch:

  2>-- Installing port from location:
C:\Users\lev\Projects\openvpn\contrib\vcpkg-ports\pkcs11-helper
  2>-- Using cached pkcs11-helper-1.29.0.tar.bz2.
  2>-- Extracting source
C:/Users/lev/Projects/vcpkg/downloads/pkcs11-helper-1.29.0.tar.bz2
  2>-- Applying patch 0001-nmake-compatibility-with-vcpkg-nmake.patch
  2>-- Applying patch 0002-config-w32-vc.h.in-indicate-OpenSSL.patch
  2>-- Applying patch pkcs11-helper-001-RFC7512.patch
  2>-- Applying patch pkcs11-helper-002-dynamic_loader_flags.patch

I also checked that the "inside" patch is identical to the one from
pkcs11 repo (https://github.com/OpenSC/pkcs11-helper/pull/59/commits/934197611dd1260d17ae0f11ae81c1d2e85612d2).

Everything compiles, no changes to the "actual" code of openvpn in
this patch. I haven't tested actual pkcs11 functionality.

Note that while applying "outside" patch "git am" complains about
whitespace errors, but "this is fine" - those are from the "inside"
patch.

Acked-by: Lev Stipakov <lstipakov@...277...>

