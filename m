Date: Mon, 5 May 2025 18:26:42 +0200 (CEST)
Message-Id: <202505051626.545GQgEV020390@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250505122712.5214-1-gert@...1296...>
References: <20250505122712.5214-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: win: refactor
 get_windows_version()
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

I have mildly tested this (mingw-compiled 32/64 bit binaries and tried
to find VMs to run them on, but most of this failed due to this or that or
windows in general).  I did test Win7/i386 (32bit binaries on 7/64),
Win10/amd64, Win11/amd64, and the result was what I expected.

Now, with Microsoft being as silly as they are, we could just hardcode
the first two digits - all versions are "10.0" now, with a build number
3rd...  but hey, maybe KI will make them return to useful versioning one
day, and then our use of the API stands ready!

Your patch has been applied to the master branch.

commit 45a4f4e5f6c3552a27a8064ab6a857c465efc2f0
Author: Lev Stipakov
Date:   Mon May 5 14:27:06 2025 +0200

     win: refactor get_windows_version()

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250505122712.5214-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31566.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


