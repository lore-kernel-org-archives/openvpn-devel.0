From: Charles Duffy <cduffy@...294...>
Date: Mon, 02 Oct 2006 11:40:14 -0500
Message-ID: <efrfdj$va5$1@...165...>
References: <20060926025847.43950.qmail@...790...>
Mime-Version: 1.0
In-Reply-To: <20060926025847.43950.qmail@...790...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] Find OpenVPN source code document
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Dong Thao Le Dinh wrote:
> Hi all,
> I'm doing a research about OpenVPN activities through its source code. I 
> do a lot of Googling but still can't find any document about OpenVPN 
> source code. How it organizes, how it work? For example, what are the 
> functions it use for creating a tunnel? Can you give me a suggestion?

You shouldn't find it excessively difficult to figure most of this out 
by reading the source yourself; it's generally well-written and 
organized, and thus reasonably self-documenting to someone familiar with 
C. I've certainly not had trouble in the past figuring out how any 
individual component works in under 20 minutes of effort. Given that the 
source is this clean and well-organized, writing additional 
documentation for it would arguably be superfluous -- it would add a 
point of failure (as if not maintained or if written incorrectly it 
could lead readers to inaccurate conclusions) but not much value.

If, after making a serious attempt to do this research yourself, you 
have specific questions which reflect such prior research -- feel free 
to ask them. However, I strongly urge you to attempt to do this work 
yourself.


If your problem is a lack of good methodology, let me guide you through 
the process for finding the code related to tunnel creation.

Since we know the "mktun" directive can be used to force tunnel creation 
via the command line, that's a good place to start. We grep for "mktun" 
through the source and find it referenced in init.c and options.c. In 
init.c, we find some sanity checking followed by a call to tuncfg() -- 
which provides or calls through to the meat of the method.

Even this was a bit excessive, though. Since it's tunnel devices you 
care about, tun.c is *on its face* the obvious place to start looking 
based on nothing but naming conventions. Common sense and a bit of 
effort should help you find what you need.


