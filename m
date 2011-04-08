MIME-Version: 1.0
In-Reply-To: <0A8F79E22F384F3C9C2431348D66C11E@...139...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<1302262805-23686-1-git-send-email-davids@...1347...>
	<1302262805-23686-3-git-send-email-davids@...1347...>
	<0A8F79E22F384F3C9C2431348D66C11E@...139...>
Date: Fri, 8 Apr 2011 19:32:47 +0300
Message-ID: <BANLkTi=E-7JGgTD0WTTn_jysYFsr2_LuTg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Use %SystemRoot% instead of
 hard-codedC:\WINDOWS for temp directory path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gisle Vanem <gvanem@...139...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, Apr 8, 2011 at 7:03 PM, Gisle Vanem <gvanem@...139...> wrote:
> Why not a bit simpler; GetTempPath() (kernel32.dll) already does these tests.
> Ref: http://msdn.microsoft.com/en-us/library/aa364992(v=vs.85).aspx :

Good catch.

Alon.

