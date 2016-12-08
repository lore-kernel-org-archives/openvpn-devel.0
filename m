References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <8000a47e-979c-3afc-1a7a-5f8afab85634@...1856...>
Date: Thu, 8 Dec 2016 22:50:48 +0100
MIME-Version: 1.0
In-Reply-To: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


On 08-12-16 22:15, David Sommerseth wrote:
> This is fairly inline with the initial agreement from the 2014 Munich
> hackathon [3] and the summarized CodeStyle wiki page [4].

Thanks!  The consistency of the reformatted examples is an amazing
contrast to our current code base.

> This proposal allows for the "open bracing" question, which allows
> '} else {'  and '} else if () {'.
> 
> So now the bike shed debate opens up ... Is this something we can get
> consensus around?

Even though I asked for this on the CodeStyle page, I have to agree with
Gert's argument on IRC:  we settled for Allman in Munich, so we should
not re-open the bikeshed (even more ;) ).  So, even though it's not my
personal preference, I argue we should not allow this.  Apologies for
the noise...

-Steffan

