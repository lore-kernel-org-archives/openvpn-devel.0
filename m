Date: Thu, 21 Apr 2022 10:00:09 +0200 (CEST)
Message-Id: <202204210800.23L809Es053990@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220420143050.52790-1-openvpn@...2080...>
References: <20220420143050.52790-1-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: The Great Reformatting of 2022
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

Acked-by: Gert Doering <gert@...1296...>

We've, indeed, not been very thorough in following our own formatting
rules... seems a few tabs-vs-spaces snuck in, and there were some
misunderstanding on certain constructs (like, function return types).

As discussed on IRC, we do a Great Reformatting now, and then require
all core contributors to send clean patches only, aka "use the pre-commit
hook that Heiko has developed".  Which only works if the underlying tree
is clean - which this achieves.

I've gone through the changes with "git show -w" - this is mainly
"function return on separate line", "C++ comment", "#else with comment",
but no actual code changes.

Without "-w", it's a number of space-vs-tab, "char *foo" vs. "char* foo",
all minor things, but uncrustify has no mercy there (I do not find all
changes aesthetically "better" than before, especially the msg() stuff,
but unless someone finds an uncrustify option to do these differently,
consistency trumps personal aesthetics).

I have also compile + t_client tested, for good measure (all OK).

Your patch has been applied to the master branch.

commit abe49856d81f51136d543539202a0bf8fb946474
Author: David Sommerseth
Date:   Wed Apr 20 16:30:50 2022 +0200

     The Great Reformatting of 2022

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220420143050.52790-1-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24123.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


