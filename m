Date: Wed, 13 May 2020 15:57:54 +0200 (CEST)
Message-Id: <202005131357.04DDvse1080882@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1582254028-7763-1-git-send-email-selva.nair@...277...>
References: <1582254028-7763-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Persist management-query-remote
 and proxy prompts
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

Acked-by: Gert Doering <gert@...1296...>

I won't claim to understand management, but the patch does what it
says, and it does so in the same way as querying for >PASSWORD is
done.  Selva understands management way better than I do, so if he
says this is needed, and the code is in line with what we currently
have (manage.c, management_query_user_pass(), management_hold(),
management_query_multiline()...) and does not look like "mem leak" 
or "overflow" - which it doesn't - good enough for me.

The code *looks* as if a reference to "out" is going out of scope,
but that one is allocated in &gc, so it's fine.  Just hard to read.

These functions could do with a bit of C99 modernizing, getting 
rid of extra nesting levels that are just there to enable local
variables... but that's for a different round of refactoring.


Your patch has been applied to the master branch.

commit 93ba6ccddafcc87f336f50dadde144ea4f6178ad
Author: Selva Nair
Date:   Thu Feb 20 22:00:28 2020 -0500

     Persist management-query-remote and proxy prompts

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1582254028-7763-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19497.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


