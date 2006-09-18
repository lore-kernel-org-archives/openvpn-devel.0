Message-ID: <450E9BD1.9030703@...277...>
Date: Mon, 18 Sep 2006 15:14:57 +0200
From: Albert Siersema <asiersema@...277...>
MIME-Version: 1.0
References: <450C6060.6060605@...777...>	<9e0cf0bf0609161341n286986d8i4a39a8cab4d59a5c@...278...>
	<450C6B2E.9040107@...777...>
In-Reply-To: <450C6B2E.9040107@...777...>
Subject: Re: [Openvpn-devel] request for input re: OpenVPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Mike Martin <Mike.Martin@...777...>
Cc: OpenVPN Developers <openvpn-devel@lists.sourceforge.net>

First of all: i'm not an OpenVPN developer.
I am, however, a programmer :)

There's LOTS of formal reading material to be found regarding APIs
and the definition of what can be called an API. Especially in
the academic CS field.
To be predictable, i'll insert a link to wikipedia here :)
http://en.wikipedia.org/wiki/API
(not that i'll call a wikipedia article "formal" but it's a start).

The OpenVPN management interface is what it says: an interface.
I wouldn't call it a full blown API. Then again, it "exports"
function(ality)/"methods".

I think you'll find you're better off stating in a short and concise
manner what it is you're looking for. As lots of open source people
work on FOSS projects in their spare time or at least have an allotted
amount of time for a project they won't have to luxury to spend hours
wading through a paper or to sieve academic language for the bare facts.

When talking to programmers it's better to describe your problem
in let's say one shortish paragraph, then list the seperate issues/
challenges. I say list because formatting it like a bulleted list
works well, especially when discussing issues. It's better to be
able to quote easily human-parsable statements than to have to
describe it in lush amounts of text.
(and thats skipping over the issue that not everyone speaks/reads
 English as their first language)

Programming/design... when you can't describe your challenges,
design goals and pitfalls in an orderly concise fashion you
need to rethink and rephrase.

You obviously want something with to incorporate VPN functionality
into a "Grid" of sorts.
In what sense do you mean "grid" ?
What makes deploying openvpn in such an environment special ?
What do you need the API for ?
It's all none to clear from your previous messages really.

Albert

