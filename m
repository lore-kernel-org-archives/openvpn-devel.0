Date: Sun, 23 Nov 2025 14:37:37 +0100 (CET)
Message-Id: <202511231337.5ANDbbFW084248@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251123120029.19736-1-gert@...1296...>
References: <20251123120029.19736-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: check for NULL pointer
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Trivial enough.  Stared-at-code, and buildbot did the compile tests.

I don't think this can ever happen in our context - search_domains
comes from a single call chain, and is initialized here

        PWSTR wide_search_domains;
        wide_search_domains = utf8to16(search_domains);
        if (!wide_search_domains)
        {
            return ERROR_OUTOFMEMORY;
        }  
        SetNrptExcludeRules(nrpt_key, ovpn_pid, wide_search_domains);
        free(wide_search_domains);

.. but this change does not hurt, and "if (NULL) return FALSE" matches
the function description "is 'domain' in 'list'? FALSE = no" just fine.

Your patch has been applied to the master branch.

commit 2e2ac94e9cf3d0bdb28339594c8236fa98784967
Author: Heiko Hund
Date:   Sun Nov 23 13:00:23 2025 +0100

     iservice: check for NULL pointer

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1393
     Message-Id: <20251123120029.19736-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34611.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


