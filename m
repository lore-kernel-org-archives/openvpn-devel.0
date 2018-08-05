Date: Sun, 5 Aug 2018 22:29:45 +0200 (CEST)
Message-Id: <201808052029.w75KTjDT091433@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170505214624.11675-1-davids@...515...>
References: <20170505214624.11675-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: plugin: Export base64 encode
 and decode functions
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch, with
the comment fixes (BAS64 -> BASE64, and encode->decode on the 2nd comment).

release/2.4, because the "secure_memzero" also is in 2.4 (went into 2.4.3),
and everything else creates needless pain for plugin authors.  The code
change on the openvpn side is very small, and it's fully in the "long
term compatibility" category.

commit 6690769f78bbfb889fef2a54088d979896c87d51 (master)
commit 6c26116759ddf1e9327a9239e14f8c94c98ec638 (release/2.4)
Author: David Sommerseth
Date:   Fri May 5 23:46:23 2017 +0200

     plugin: Export base64 encode and decode functions

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20170505214624.11675-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14558.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


