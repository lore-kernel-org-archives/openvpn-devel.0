Date: Wed, 25 Feb 2026 09:42:24 +0100 (CET)
Message-Id: <202602250842.61P8gOQC000102@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260224213036.31845-1-gert@...1296...>
References: <20260224213036.31845-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fixup version command on
 management interface
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

Thanks for that.  As discussed, we keep full compatibility ("lack of
SUCCESS response") for up to v3, and document this.

I'm looking forward to a followup patch that documents v1, v2, v3 and v4...

Your patch has been applied to the master and release/2.7 branch.

I do not foresee new mgmt features being added to 2.6.x, so I don't
think we need this in release/2.6 (but if it is needed, we can always
cherrypick it "on demand")

commit adc0febaeac0d83246dbd2cc77b2a5d80e41741e (master)
commit d88e9023930a74cebb8ceab2b91587221675846c (release/2.7)
Author: Selva Nair
Date:   Tue Feb 24 22:30:30 2026 +0100

     Fixup version command on management interface

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1528
     Message-Id: <20260224213036.31845-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35782.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


