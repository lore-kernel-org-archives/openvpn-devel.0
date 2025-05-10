Date: Sat, 10 May 2025 20:29:53 +0200 (CEST)
Message-Id: <202505101829.54AITrKa063275@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250510181937.2993-1-gert@...1296...>
References: <20250510181937.2993-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: create adapter on demand
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

We have discussed this at the Community IRC meeting, and decided that
"we do want this feature" (there was a bit of confusion as I thought we
did not implement this previously for some good reason, but since nobody
remembered anything we decided the reason wasn't so good, after all :-) ).

I have lightly stared at the code, tested to build on mingw64, and did
not run the resulting binary.  Selva did and +2'ed, so that's covered.

Your patch has been applied to the master branch.

commit c1c330b6d53bd78e2fd1731e886863c6fe099192
Author: Lev Stipakov
Date:   Sat May 10 20:19:30 2025 +0200

     win: create adapter on demand

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20250510181937.2993-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31617.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


