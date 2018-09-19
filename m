Date: Wed, 19 Sep 2018 22:42:03 +0200 (CEST)
Message-Id: <201809192042.w8JKg3rK060770@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1537374009-11133-1-git-send-email-steffan.karger@...1435...>
References: <1537374009-11133-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused
 void_ptr_hash_function and void_ptr_compare_function
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Because it's dead code.  Looking again, it actually seems correct
after all :-) (void_ptr_hash_function() is passed in a pointer *value*,
which is then stored locally, and the address of this local store is
handed to hash_func() - so it compares "memory addresses".  Misread the
code before.  It's James code so it must be correct.  But unused still!

Your patch has been applied to the master branch.

commit 01f7bb52ce510f0fc915c9aa6a14f79b2779a7f8
Author: Steffan Karger
Date:   Wed Sep 19 18:20:09 2018 +0200

     Remove unused void_ptr_hash_function and void_ptr_compare_function

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1537374009-11133-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17473.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


