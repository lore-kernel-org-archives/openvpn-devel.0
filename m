Date: Tue, 15 Jun 2021 11:02:45 +0200 (CEST)
Message-Id: <202106150902.15F92jYH025067@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210514045704.686-1-lstipakov@...277...>
References: <20210514045704.686-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: standalone building
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I have no idea about all this MSVC building but Samuli has tested this,
so it's supposedly working :-) - but it does not touch actual OpenVPN
Code and "generally looks reasonable".

Your patch has been applied to the master and release/2.5 branch
(we want this in release/2.5 to be able to do a 2.5.3 release with
arm64 support).

There is one bit that warrants looking twice - removal of 
compat-inet_pton.c/ntop.c from compat.vcxproj.filters - in master,
these files are gone, while they still exist in 2.5.  We do not *use*
them in 2.5 on windows either, as all supported windows versions have 
these functions now.  So this is good.

commit 56f775fe9dacab7804109e305d652057b0c7fd3c (master)
commit 206d9665a80de997b0b74707ec880879617cba9a (release/2.5)
Author: Lev Stipakov
Date:   Fri May 14 07:57:04 2021 +0300

     msvc: standalone building

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210514045704.686-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22389.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


