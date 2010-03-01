Message-ID: <4B8C4401.1060506@...376...>
Date: Mon, 01 Mar 2010 23:47:29 +0100
From: Bernhard Schmidt <berni@...376...>
MIME-Version: 1.0
References: <20100228150546.GO9556@...1296...>	<540A56F3-EBC5-4872-83C7-D49A1BBD28E0@...1286...>	<4B8A8DC9.3020502@...1114...>	<20100228221425.GT9556@...1296...>	<4B8AF4AD.8060402@...1114...>
	<hmhae1$p5k$1@...1312...> <4B8C30A2.5020200@...1114...>
	<4B8C3496.6000206@...376...>
	<4B8C38AD.8030607@...1114...>
In-Reply-To: <4B8C38AD.8030607@...1114...>
Subject: Re: [Openvpn-devel] FreeBSD funny in the code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

On 01.03.2010 22:59, David Sommerseth wrote:

>> Could you please have a look at git://git.birkenwald.de/openvpn.git
>> test-rebase branch? The history of gert-ipv6 was starting to look a bit
>> weird (duplicate commits with the same content), to I rebased it on your
>> bugfix2.1 branch (and dropped the duplicate commits in the process). No
>> difference in the content whatsoever and the history looks much better,
>> but I'm not exactly sure whether this is the right thing to do.
>>
>
> I tried to both merge and rebase both your gert-ipv6 branch and the
> test-rebase branch from the allmerged branch.  That was quite an
> interesting experience.
>
> The test-rebase branch gave most problems.  Both rebase and merge got
> painful.  While with the gert-ipv6 gave only (expected, though) issues
> with rebase.  Merging in gert-ipv6 was more or less painless.

Yeah ... I'm still having a hard time to wrap my head around the gory 
git details, but I think rebasing was a bad idea to begin with. 
Especially in the other direction (you rebasing on gerts tree) :-)

As far as I understand it rebasing works by rolling back your local tree 
to the point you branched from the upstream tree (recording all changes 
in the progress), fast-forwarding to the HEAD of the upstream (at this 
point local = upstream) and then reapplying all your local changes. This 
fits perfectly in a model where you maintain a feature branch upstream 
has not yet seen. By doing that you guarantee that your feature branch 
is always a set of patches on top of the current upstream HEAD 
(guaranteed to merge without conflicts when pulled into upstream), thus 
making any conflicts that evolve during continued upstream development 
entirely the feature branch's problem to solve.

When I rebased gert-ipv6 on bugfix2.1 I essentially dropped the old 
changesets and recreated new ones (with different ids). So when you try 
to merge that rebased tree your git sees new commits and tries to merge 
them on the tree already containing the changes. Which is something git 
can only detect (already applied and so on) if that part of the code has 
not been touched with subsequent changesets.

As far as I can see it, the only point where rebasing would be useful is 
to rebase allmerged on bugfix2.1 and bugfix2.1 on master. But I don't 
know how much this will break. :-)

Bernhard

