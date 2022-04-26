Date: Tue, 26 Apr 2022 12:19:09 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <89933784.416729.1650968349518@...2642...>
In-Reply-To: <20220422142953.3805364-6-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-6-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 15/28] Remove pointless indentation from
 tls_process.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-by: Frank Lichtenheld <frank@...2641...>

Trivial.

The commit message is a bit garbled though. Changing the
first "add" to "and" makes it better, I think. "decleration"
should be "declaration". Also remove the full stop from the
summary line and move it at the end of the body.

$ git show -w
commit fdbf34d2e4e28c334e18a677b670b8ade9f87ded
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Apr 22 16:29:40 2022 +0200

    Remove pointless indentation from tls_process.

    This is probably a result from earlier code that still needed to be
    C89 compatible add probably added this to allow variable decleration

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 15af5894..097be8c0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2774,7 +2774,6 @@ tls_process(struct tls_multi *multi,
     }

     /* When should we wake up again? */
-    {
     if (ks->state >= S_INITIAL)
     {
         compute_earliest_wakeup(wakeup,
@@ -2813,7 +2812,6 @@ tls_process(struct tls_multi *multi,

     return false;
 }
-}

 /*
  * Called by the top-level event loop.

Regards,
--
Frank Lichtenheld

