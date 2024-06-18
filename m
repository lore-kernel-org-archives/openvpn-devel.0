Date: Tue, 18 Jun 2024 22:51:06 +0200 (CEST)
Message-Id: <202406182051.45IKp6Dt007665@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240613081422.139493-1-frank@...2641...>
References: <20240613081422.139493-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add t_server_null test suite
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

I have not tested this yet, just looked at a few details - we've
discussed using @SHELL@ to get a known-working shell, which is 
more likely to succeed than assuming "#!/usr/bin/env" will exist,
or that the "sh" it finds will be useful (Solaris, I'm looking at
you...).  Also, documenting that scripts do not properly get waited
for does not make it a feature...

But anyway.  Let's move onwards, and improve iteratively.

Your patch has been applied to the master branch.

commit 06c7ce5d1fc3b17e0da731d22002e58b9e2d4994
Author: Samuli Seppänen
Date:   Thu Jun 13 10:14:22 2024 +0200

     Add t_server_null test suite

     Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240613081422.139493-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28750.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


