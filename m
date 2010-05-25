Message-ID: <20100525124923.16039.qmail@...1287...>
Date: Tue, 25 May 2010 14:49:23 +0200
From: Peter Stuge <peter@...1287...>
References: <4BF63BBE.4030603@...515...> <4BFB8D77.4050501@...1114...>
	<4BFBB58F.4050301@...1338...> <4BFBBCF7.4080502@...515...>
	<E8A6CAC3-DD52-47EA-A78C-5D93DC21CD9E@...1286...>
	<4BF63BBE.4030603@...515...> <4BFB8D77.4050501@...1114...>
MIME-Version: 1.0
In-Reply-To: <E8A6CAC3-DD52-47EA-A78C-5D93DC21CD9E@...1286...>
	<4BFB8D77.4050501@...1114...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (20th May 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> You can argue that it's a company specific change and that the software
> is not distributed - but the employees in that company do get this
> software somehow - most often as verbatim copy, and these employees can
> then internally request the source code according to the GPL license.

I believe that's not so. The company with all employees is seen as
one legal entity and internally can be more restrictive. It is when
the company distributes binaries to another legal entity that the GPL
kicks in.

That said, I like GPLv2 too.


Eric F Crist wrote:
> Restricting bounty development to the small handful of developers
> who've already done work on OpenVPN is a bad idea.  It doesn't
> entice new, talented, developers to participate.

This is a really tough issue.

Having a new developer join the team to create some significant
amount of work as the very first interaction will create a lot of
problems when that person isn't already familiar with the exact modus
operandi of the project. Worst case it will simply lead to code that
bitrots. Imagine you not being able to review and give immediate
feedback on a wave of patches that are coming in, the author hears
nothing and continues working, and in the end there's a huge pile of
commits that just don't make sense, even though the final product
works kinda ok.. Nightmare.


//Peter

