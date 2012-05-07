MIME-Version: 1.0
In-Reply-To: <c0aca6be1ae29a0fe176829a83dd827f@...1717...>
References: <c0aca6be1ae29a0fe176829a83dd827f@...1717...>
Date: Mon, 7 May 2012 16:51:56 +0300
Message-ID: <CAOazyz2ZO7VMzrNBMFO6Eczi858+Y0FnmrGVUmKbw=9-nrN0LA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] A few questions related to the management
	interface
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
To: Adrien Bustany <adrien@...1716...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, May 7, 2012 at 2:58 PM, Adrien Bustany <adrien@...1716...> wrote:
> Hi,
>
> I was toying with the management interface of openvpn (on server side),
> to monitor the connections/disconnections of my clients. The clients
> are authenticated with TLS certificates, without a password. I needed to
> patch two things in order to get things working as I wanted, but since
> I'm new to the code base, I'm not sure at all that those patches make
> sense, especially the second one. I still attach them to this email,
> in the hope that people here will point where I'm wrong :)
>
> Cheers
>
> Adrien
>

Hello,

Yes, they are making sense.
But please next time submit them using git send-email and separately,
so we can discuss each.

Regarding 001 - As far as I can see, the code does exactly that... if
not DAF_CONNECTION_CLOSED, issue disconnect message and turn
DAF_CONNECTION_CLOSED, otherwise do nothing. So what is the problem?

Regarding 002 - I think this is correct, but then we need to modify
management_learn_addr as well, no? Or the mdac->cid is not initialized
all the time and the flag marks that this is client session... Did not
test.

Alon.

