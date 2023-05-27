Date: Sat, 27 May 2023 18:37:00 +0200 (CEST)
Message-Id: <202305271637.34RGb0rT000877@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230527095504.17915-1-frank@...2641...>
References: <20230527095504.17915-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc-generate: include
 version.m4.in in tarball
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Trivial, but me and automake...  tested by building a 2.6
tarball, and comparing tarball contents vs. 2.6.4 ("as expected", it
just adds the version.m4.in), and pushing to GHA "just to see that
it won't do something unexpected" (doesn't).

Your patch has been applied to the master and release/2.6 branch.

commit 72d70b5d8a9d6ac01134df006a03607a79e76294 (master)
commit cfcc20ff2bf184edb06e2d918d697f0ef81a0e82 (release/2.6)
Author: Frank Lichtenheld
Date:   Sat May 27 11:55:04 2023 +0200

     msvc-generate: include version.m4.in in tarball

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230527095504.17915-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26732.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


