From: Bernhard Schmidt <berni@...376...>
Date: Mon, 1 Mar 2010 21:09:21 +0000 (UTC)
Message-ID: <hmhae1$p5k$1@...1312...>
References: <20100228150546.GO9556@...1296...>
	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>
	<4B8A8DC9.3020502@...1114...>
	<20100228221425.GT9556@...1296...>
	<4B8AF4AD.8060402@...1114...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

David Sommerseth <openvpn.list@...1114...> wrote:

Hi David,

>> David, could you please pull my branch from Berni, and move that patch
>> to wherever bugfixes/code cleanups go?  It should merge easily into 
>> all branches.
>
> Pushed and pulled.  I've only put your extra commit into the bugfix2.1
> branch (as a cherry-pick), and merged it into allmerged.
>
> At some point, you might consider to pull in the bugfix2.1 branch into
> your feat_ipv6_payload branch, just to get in those bug fixes.

Hm, I thought we (Gert :-) ) were supposed to develop on top of master?
I don't have any preference either way, but as soon as we merge
bugfix2.1 into feat_ipv6_payload all those commits are there.

It doesn't make a difference at the moment (since the patch came from
feat_ipv6_payload in the first place), but what's the general wish for
the future? What to rebase on?

Bernhard


