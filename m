Date: Mon, 13 Feb 2023 20:05:18 +0100 (CET)
Message-Id: <202302131905.31DJ5IAp002611@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230131125448.1913-1-lstipakov@...277...>
References: <20230131125448.1913-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: use proper calling
 convention on x86
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

I'm no windows expert, but googling says "this is what you do for
windows function calls".  MinGW compiles without complaints, as
does GHA.

The GetOverlappedResultEx() can be cleaned up as soon as we drop
Windows 7 support, not sure about the IsWow64Process2() thing.

Can we add windows/x64 tests to the GHA automated windows build/test
thing?  Or do we even have some, the errors just do not make it back?

Your patch has been applied to the master and release/2.6 branch.

commit b78360875cfe2f3ffc0d0aa0785ba3070b597da6 (master)
commit 3c02417c95567dcbc3eafe25c28451fb39005f43 (release/2.6)
Author: Lev Stipakov
Date:   Tue Jan 31 14:54:48 2023 +0200

     dco-win: use proper calling convention on x86

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230131125448.1913-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26113.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


