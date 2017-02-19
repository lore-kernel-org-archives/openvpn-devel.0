MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
References: <cover.1487368114.git.logout@...260...>
	<3b87d588-aad7-433d-f802-ea9f9f7a0a63@...1856...>
From: Emmanuel Deloget <logout@...260...>
Date: Sun, 19 Feb 2017 16:01:00 +0100
Message-ID: <CAKh=nwHvjVXyRYe4rCMaWmf6L=0DnVfYnzbpiKSeK3HBAi7WbA@...278...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL
	1.1.x
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

On Sun, Feb 19, 2017 at 1:03 PM, Steffan Karger <steffan@...1856...> wrote:
>
> Hi Emmanuel,
>
> Thank you very much.  You approach looks good to me, and quite closely
> matches what I had in mind for when I would find the time to tackle
> this.  (Which might have taken me a while, so really happy to see these
> patches!)
>

Thanks Steffan,

> As discussed in other threads, we do want to support building on RHEL6,
> which is why we would prefer to be compatible with (patched) OpenSSL
> 0.9.8.  I haven't tested anything yet, but looking at the patches this
> might very well just work, or otherwise just needs some minor tweaking.

I haven't tested compilation with 0.9.8 but unless some massive
changes in the interface occured, this should not be a problem. I'd do
that at the beginning of next week.

> Also very good that this is split up into small and independently
> reviewable patches.  I'll start review soon.
>
> -Steffan

For the record, most of the patches deal with changing how the code
access to one selected OpenSSL type. I hope it will ease review -- in
the sense that people who are accustomed to the code might be able to
see if something is missing.

BR,

-- Emmanuel Deloget

