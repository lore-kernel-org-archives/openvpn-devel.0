MIME-version: 1.0
Message-id: <0A1A73D8E6B540BBB35560F4AECB240F@...139...>
From: Gisle Vanem <gvanem@...139...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<BANLkTik3QGpmced2mqhxDv6cmNJDZcxFMw@...278...>
	<4D9DB2AE.2080907@...1347...>
	<BANLkTin837cp5Z1vUYTak_Wx3MDUbEHJrw@...278...>
Date: Thu, 07 Apr 2011 16:50:43 +0200
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a
 more suitable path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

"Alon Bar-Lev" <alon.barlev@...277...> wrote:

> On Thu, Apr 7, 2011 at 3:48 PM, David Sommerseth <davids@...1347...> wrote:
>> Good idea! I wasn't aware of that one. I'll fix this. I will anyway
>> choose to fallback to C:\WINDOWS\Temp if %SystemRoot% is not found, even
>> though I believe this is most likely not something which should happen.
> 
> Can't happen, Windows will not boot.

But a user can still do "set SystemRoot=" after boot. But a lot of problems will 
arise though. A quick test; notepad.exe doesn't start for instance.

--gv


