Date: Tue, 8 Nov 2022 14:33:37 +0100 (CET)
Message-Id: <202211081333.2A8DXbWH038779@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221104090247.167-1-lstipakov@...277...>
References: <20221104090247.167-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: win32: detect arm64
 architecture and emulations
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

The tester's echo was really overwhelming here... so I've stared-at-code
and fed this to my github instance for test building with msvc & mingw
(builds fine).

Compareing the patch to MS documentation (IsWow64Process2() etc.) - the
code seems to be reasonable, and matches the intent.

Regarding feature-ACK - yes, printing specific "what compile on what
type of windows" is a useful feature when looking at log files and
trying to figure out the environment where something happened, to be
able to easier reproduce it.

Your patch has been applied to the master branch.

commit 99af056fad3cd0aef4af68d0eacc1fb9ef9b50c7
Author: Lev Stipakov
Date:   Fri Nov 4 11:02:47 2022 +0200

     win32: detect arm64 architecture and emulations

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221104090247.167-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25476.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


