Date: Tue, 25 Nov 2025 09:58:12 +0100 (CET)
Message-Id: <202511250858.5AP8wCQD072549@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251124183839.24803-1-gert@...1296...>
References: <20251124183839.24803-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Harden interactive service pipe
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

Thanks for the 2.6 backport.

This is basically identical to commit 05d0808ee65 in master, except
that the 2.6 code is dealing with text strings differently (TEXT() vs.
L(), and I felt that this is beyond what I should touch on cherrypicking
bugfixes).

Compile-tested by BB and on MinGW/Ubuntu 24.04.

Your patch has been applied to the release/2.6 branch.

commit a8fb9f6443cd4ce3b76b1a31738ede2db5bc45ea (release/2.6)
Author: Selva Nair
Date:   Mon Nov 24 19:38:34 2025 +0100

     Harden interactive service pipe

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1401
     Message-Id: <20251124183839.24803-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34654.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


