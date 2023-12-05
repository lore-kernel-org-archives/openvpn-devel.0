Date: Tue, 5 Dec 2023 15:03:36 +0100 (CET)
Message-Id: <202312051403.3B5E3aNs021898@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231204153345.1146-1-marc.becker@...2704...>
References: <20231204153345.1146-1-marc.becker@...2704...>
Subject: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports/pkcs11-helper: bump
 to version 1.30
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

Your patch has been applied to the master and release/2.6 branch 
(less local patches and up-to-date build requirements).

Test built 2.6 with GHA

I was wondering why there is no "Makefile.in" change to un-bundle these
two patches to "make dist" - but that's because we just bundle everything
in contrib/ without explicitly listing files.  "make dist" still works.

commit a78b0e45dff3a0f0332de47c55aadd76c5919370 (master)
commit 77b2e940fd3980f9dbfa62f84fb135ea2f1effaf (release/2.6)
Author: Marc Becker
Date:   Mon Dec 4 16:33:45 2023 +0100

     vcpkg-ports/pkcs11-helper: bump to version 1.30

     Signed-off-by: Marc Becker <marc.becker@...2704...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231204153345.1146-1-marc.becker@...2704...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27678.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


