Date: Sun, 22 May 2022 15:55:51 +0200 (CEST)
Message-Id: <202205221355.24MDtpq2005064@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <2735E502-7F1F-48E9-8011-6740251E81DE@...2674...>
References: <20220518183715.931-1-frank@...2641...>,
 <2735E502-7F1F-48E9-8011-6740251E81DE@...2674...>
Subject: [Openvpn-devel] [PATCH applied] Re: cipher-negotiation.rst missing
 from doc/Makefile.am
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
To: Jan Mikkelsen <janm@...2674...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for spotting this & reporting, and sorry for not picking up
the trac ticket.  Sometimes we're too busy and only pay attention
to the openvpn-devel list & our IRC channel.

Tested with master and 2.5 "make dist".

Your patch has been applied to the master and release/2.5 branch.

commit 7c8dd98ec10f61c3b014b64c24090717cd6ebf05 (master)
commit 1294064e142d43b49df66296f8cd92de0698616d (release/2.5)
Author: Jan Mikkelsen
Date:   Wed May 18 20:37:15 2022 +0200

     cipher-negotiation.rst missing from doc/Makefile.am

     Signed-off-by: Jan Mikkelsen <janm@...2674...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220518183715.931-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24394.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


