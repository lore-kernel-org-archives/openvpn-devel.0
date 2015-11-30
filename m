MIME-Version: 1.0
In-Reply-To: <CAKuzo_gvAwmnT5jzgSgqgr30uM-eNpfrMtD=YOPsy+Uu2NMowQ@...278...>
References: <1447807884-3734-1-git-send-email-fukawi2@...277...>
	<CAKuzo_gvAwmnT5jzgSgqgr30uM-eNpfrMtD=YOPsy+Uu2NMowQ@...278...>
From: Phillip Smith <fukawi2@...277...>
Date: Mon, 30 Nov 2015 13:38:15 +1100
Message-ID: <CAKAE9iQ+4FubZHJ8SzgAzmAKa9rnrig6h0pNC04he6hPmrsX+A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
	documentation
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 27 November 2015 at 13:35, Selva Nair <selva.nair@...277...> wrote:
>
> Replacing references to "june.kg" etc., which could one day become someone's private domain, is not a bad move. Though, not sure
> why choose example.com over example.net or example.org, or even tlds like .example, .test etc. which are also reserved for docs.

Thanks for your feedback. I guess there's no real reason for
'example.com' over the others you list, except I had to choose one,
and personally I find `whatever.example.com` easier to read and
process as a hostname than `whatever.example` or `something.test`

>
> That apart, this is not a carefully constructed patch. It misses several occurrences of "may" and "june" -- even the patch context shows some:

You're right, I was a little hasty. I will clean up and resubmit.

> Finally,  the AUTHORS section in manpage is a place to document the principal AUTHOR(S) of the program that it describes. Traditionally the original author goes there, sometimes with a pointer to full credits.

Duly noted; I was not sure as I thought it strange there was only 1
name listed to date. I will not include my name in revision 2.

