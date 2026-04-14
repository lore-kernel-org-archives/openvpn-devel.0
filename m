Date: Tue, 14 Apr 2026 18:31:06 +0200 (CEST)
Message-Id: <202604141631.63EGV6ea032386@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260414055721.16857-1-gert@...1296...>
References: <20260414055721.16857-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log when writing
 username/password to TLS buffer fails
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

Thanks, this makes sense - if we fail, we want to tell the user what
happened (even if we then continue to run in silly circles).

I have not tested it - I guess one needs a GUI with "long password"
support to trigger it :-) - but since the code path is clear enough
and the patch only adds msg() calls, I guess a compile test is fine.

Your patch has been applied to the master and release/2.7 branch
(I put this into "documentation improvement").

commit fd1fd077ea7781be8be6e05f2a2b657619c7e437 (master)
commit 784ba7a2019539db028cd98beaa42e8921394cdf (release/2.7)
Author: Selva Nair
Date:   Tue Apr 14 07:57:14 2026 +0200

     Log when writing username/password to TLS buffer fails

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1600
     Message-Id: <20260414055721.16857-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36604.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


