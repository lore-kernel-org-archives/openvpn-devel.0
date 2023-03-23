Date: Thu, 23 Mar 2023 10:54:31 +0100 (CET)
Message-Id: <202303230954.32N9sVVV036717@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230322113249.2039-1-lstipakov@...277...>
References: <20230322113249.2039-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Print DCO client stats on
 SIGUSR2
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

I have listened to the discussion, and I think we all agree that we
need to revisit this "DCO counter" business:
  - definition of c2 structure elements
  - do we need extra fields for "dco counters"?
    - do we need more counters?  Windows currently has 
      "TransportBytes*" and "TunBytes*", while FreeBSD only has "bytes"
      (which are what, exactly?)
      -> *I* definitely need a better understanding of these
  - when and where do we query the kernel for counters (timer, signal, ...?)

This said, we want the functionality now :-) - so, I have tested this
(on FreeBSD), and it does what it says, and the code looks reasonable
according to "it will not access undefined pointers, will not leak
memory" etc.

Your patch has been applied to the master and release/2.6 branch.

commit d5238627e4fab93a6c09816c60eb90e237b626c3 (master)
commit d598871ca9fb7b4814ee8d8edfb26d20479bb6ed (release/2.6)
Author: Lev Stipakov
Date:   Wed Mar 22 13:32:49 2023 +0200

     Print DCO client stats on SIGUSR2

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230322113249.2039-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26471.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


