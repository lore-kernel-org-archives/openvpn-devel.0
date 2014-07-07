Message-ID: <53BA6954.6060107@...1227...>
Date: Mon, 07 Jul 2014 11:33:08 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1403983176-27674-1-git-send-email-steffan@...1856...>
	<53B1BDD8.8020705@...1856...>
In-Reply-To: <53B1BDD8.8020705@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Do not upcase x509-username-field for
 mixed-case arguments.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 30.06.14 21:43, schrieb Steffan Karger:
> Hi,
>
> The patch below is extracted from Andris Kalnozols' version 2 patch in
> trac ticket #402, annotated with some comments from me.
>
> The functionality this patch provides makes sense to me, and fixes
> faulty behaviour in both the release/2.3 and master branches. I think a
> final version of this patch should be applied to both branches.
>
> The options parsing code contains some magic, so I guessed it would be
> the easiest for everyone if I just proposed a new version myself that
> takes care of my comments. You'll find that attached. That version skips
> the string copy at the expense of the reported error, which now only
> reports the upcased x509-username-field, instead of both the original
> and upcased value.
>
> Andris, could you maybe test this patch and reports whether it indeed
> works as expected for you?
>
> On 28-06-14 21:19, Andris Kalnozols wrote:
>
ACK. Looks sane.

Arne

