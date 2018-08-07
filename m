Date: Tue, 7 Aug 2018 21:01:37 +0200 (CEST)
Message-Id: <201808071901.w77J1bEd015348@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1532486093-24793-1-git-send-email-selva.nair@...277...>
References: <1532486093-24793-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Parse static challenge response
 in auth-pam plugin
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

(I'm a bit undecided about release/2.4 - this is in "new feature!" land,
and all the challenge stuff is "master" territory.  OTOH, it's not openvpn
main code, and the code is sane enough - so if folks think it should be
in release/2.4, tell me)

commit 7369d01bf360bcfa02f26c05b86dde5496d120f6 (master)
Author: Selva Nair
Date:   Tue Jul 24 22:34:53 2018 -0400

     Parse static challenge response in auth-pam plugin

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1532486093-24793-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17307.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


