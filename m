Date: Thu, 15 Dec 2022 10:07:37 +0100 (CET)
Message-Id: <202212150907.2BF97bse054683@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221214143325.2604-1-marc.becker@...2704...>
References: <20221214143325.2604-1-marc.becker@...2704...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper:
 support loader flags
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

Lev warned me that there are whitespace errors in the "inside" patch,
so had to apply this with "git am --whitespace=nowarn"...

Pushed to my github instance, had GHA build something, and it claims
"success"...

  https://github.com/cron2/openvpn/actions/runs/3702355587 
  https://github.com/cron2/openvpn/actions/runs/3702357052

so whatever it does, it does not *break* anything right away :-)

As per the discussion on v2, we need to remember to remove that patch
again when upstream is merged and we bump openvpn-build to a new
pkcs11-helper release - in which case, the build is likely going to
fail anyway ("there is a patch that does not apply") so we'll notice.


Your patch has been applied to the master and release/2.6 branch.

commit 2f9c56e2cb0ce0f8d7a2a30f89831d1ddc0f2bbb (master)
commit 0b18e23b67ac3c8e64ed44c8e907c53a15cf96d0 (release/2.6)
Author: Marc Becker
Date:   Wed Dec 14 15:33:25 2022 +0100

     vcpkg-ports/pkcs11-helper: support loader flags

     Signed-off-by: Marc Becker <marc.becker@...2704...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20221214143325.2604-1-marc.becker@...2704...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25691.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


