MIME-Version: 1.0
In-Reply-To: <0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
From: Olivier W <olivierw.ml@...277...>
Date: Mon, 13 Feb 2017 00:02:45 +0100
Message-ID: <CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
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

Hello Steffan,

2017-02-10 22:20 GMT+01:00 Steffan Karger <steffan@...1856...>:
>
> The code change looks good to me, so ACK to that.

Thanks!

> The commit does need a better commit message though, and somewhere in
> the process the newlines got mangled.  I think the commit message of
> your initial patch is okay, it just missed the Signed-off-by line.  To
> smoothen the patch application process, could you create a commit with
> the above change, and send it to the list using git send-email?  The
> command line would be something like:
>
> git send-email --to=openvpn-devel@lists.sourceforge.net HEAD~1
>
> Otherwise, Gert or David will have to wrestle a commit together from you
> various messages, and that will likely take more time before it gets
> applied.

Sure, I'm sorry the patch got messed up and seems GMail also added the
message I was responding to at the bottom :-/
I'll be sending the patch with "git format-patch" + "git send-email"
as I have three commits and I'm not sure how to send a single patch
with only "git send-email"

Best Regards,
Olivier

