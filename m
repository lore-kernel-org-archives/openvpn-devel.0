Date: Mon, 18 Sep 2006 14:48:08 -0400
From: Mike Martin <Mike.Martin@...777...>
In-reply-to: <450E9BD1.9030703@...277...>
Message-id: <450EE9E8.6020000@...777...>
MIME-version: 1.0
References: <450C6060.6060605@...777...>
	<9e0cf0bf0609161341n286986d8i4a39a8cab4d59a5c@...278...>
	<450C6B2E.9040107@...777...> <450E9BD1.9030703@...277...>
Subject: Re: [Openvpn-devel] request for input re: OpenVPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVPN Developers <openvpn-devel@lists.sourceforge.net>

Hi Albert,

Thanks,

I have responded with in-line comments below:

Albert Siersema wrote:
>
> I think you'll find you're better off stating in a short and concise
> manner what it is you're looking for. As lots of open source people
> work on FOSS projects in their spare time or at least have an allotted
> amount of time for a project they won't have to luxury to spend hours
> wading through a paper or to sieve academic language for the bare facts.
>   
Good point!
> When talking to programmers it's better to describe your problem
> in let's say one shortish paragraph, then list the seperate issues/
> challenges. I say list because formatting it like a bulleted list
> works well, especially when discussing issues. It's better to be
> able to quote easily human-parsable statements than to have to
> describe it in lush amounts of text.
> (and thats skipping over the issue that not everyone speaks/reads
>  English as their first language)
>   
Good point again.
Lush amounts of text! Is that a polite way of saying "a bunch of B.S.?"  
:-) 
> Programming/design... when you can't describe your challenges,
> design goals and pitfalls in an orderly concise fashion you
> need to rethink and rephrase.
>   
Yes. I agree.
> You obviously want something with to incorporate VPN functionality
> into a "Grid" of sorts.
> In what sense do you mean "grid" ?
>   
Impossible to answer here given the criteria for communication you so 
eloquently outlined above.
However, if you really want to know, here are some links:

http://www.globus.org/
http://www.ogf.org/

> What makes deploying openvpn in such an environment special ?
>   
> What do you need the API for ?
>   
I will answer both questions at once:

It would need to last indefinitely, and be managed by a remote client, 
using Web Services, with minimal human intervention

If parameters change over time, messages outlining changes must be 
passed to the remote client in specific Web Services format. e.g. I f a 
certificate expires, or is not found because if a change in directory 
structure,  the remote client must be made aware of the cause of the 
failure, so steps can be taken to correct it without having to dig down 
for the information. We may be talking about a large number of 
connections spread over a huge distributed computing environment, so 
human intervention may not be an option.

There may be long periods without traffic. The hold command would likely 
be used here.

The API would be for a local Web Service which would act as an 
intermediary between the VPN server and the remote client. However, I 
think it best if APIs are developed without a specific goal in mind, but 
to serve as an interface to any application which might want to control 
the VPN in the future. So maybe we shouldn't consider the environment 
special at all. That's an argument I make in my paper. But maybe I'm wrong.
> It's all none to clear from your previous messages really.
>   
I think it's easier now that my head is out of my paper, and into 
discussion with people.
> Albert
>   
Thanks again,
Mike


