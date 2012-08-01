MIME-Version: 1.0
In-Reply-To: <2185000.9QTBQQtQLA@...1526...>
References: <1343821058-11456-3-git-send-email-heiko.hund@...1489...>
	<1343822222-11978-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz3uAxHh0ttBKu4uEckhEudkfx__L8ge4SxKOekBLaXQng@...278...>
	<2185000.9QTBQQtQLA@...1526...>
Date: Wed, 1 Aug 2012 15:51:34 +0300
Message-ID: <CAOazyz3AGU0m-RnCppJkKhXy=XsZrGGDj8aOECfhc7U=VSBdqA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2 fixed] add plugin_log() API to write
 to openvpn log
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Aug 1, 2012 at 3:48 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Wednesday 01 August 2012 15:27:01 Alon Bar-Lev wrote:
>> How will it work on Windows?
>
> Good question. Can't it work on Windows? According to objdump openvpn.exe
> exports all the symbols statically on Windows. Is that a limitation of the PE
> format?
>
> If not, the alternative would be to pass the function pointer in one (all?) of
> the v3 plug-in structs.

Must use the callback struct.

Alon

