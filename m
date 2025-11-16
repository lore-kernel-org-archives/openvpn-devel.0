Date: Sun, 16 Nov 2025 13:26:03 +0100 (CET)
Message-Id: <202511161226.5AGCQ3oR039532@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251116121146.4067-1-gert@...1296...>
References: <20251116121146.4067-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tapctl: refactor 'create'
 command
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

Stared at the code, commented on a few things I could not test or that
look a bit unelegant.  (Side note: changing back and forth between
pAdapterList and adapter_list in the patch series didn't help review).

Decided to go on nevertheless, as this was all minor and the overall 
change is useful & looks correct.

Tested the mingw-compiled binary on Win11 24H2 ARM, and all the variants
(create, delete, named, names with ** in them, auto-names) worked for me.

Your patch has been applied to the master branch.

commit 8487dbf1606c4c5f787dcf015228f1a05378da17
Author: Lev Stipakov
Date:   Sun Nov 16 13:11:40 2025 +0100

     tapctl: refactor 'create' command

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1374
     Message-Id: <20251116121146.4067-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34455.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


