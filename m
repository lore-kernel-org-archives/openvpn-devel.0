MIME-Version: 1.0
In-Reply-To: <20120217215816.GW7024@...1296...>
References: <1329512690-18831-1-git-send-email-debrabander@...277...>
	<20120217215816.GW7024@...1296...>
Date: Sat, 18 Feb 2012 07:37:15 +0100
Message-ID: <CAOBzU4Pr3JuycDY_RuhXs5tDArVAiMSu6wwyaXBA+XbLFUiBjg@...278...>
From: Frank de Brabander <debrabander@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Bogus check for negative values on an
 unsigned number.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I totally agree on not ACKing the patch and your solution description
;-) I tried to start a discussion on IRC about the preferred solution
before sending this patch, but that didn't get very far.

Op 17 februari 2012 22:58 heeft Gert Doering <gert@...1296...> het
volgende geschreven:
> Hi,
>
> On Fri, Feb 17, 2012 at 10:04:50PM +0100, Frank de Brabander wrote:
>> This causes compiler warnings when using Clang instead of default GCC.
>
> I'm not particularily interested in source code fixes "just to silence
> a compiler warning" - but Clang is right, of course, that this variable
> cannot ever be negative, and thus it should be cleaned up :-)
>
> I'm not ACKing this patch anyway, because I think the issue is bigger - I
> want to look at the IPv4 code paths and see whether the IPv4 "netbits"
> structure element can ever be negative - and if yes, figure out whether
> this should be possible for IPv6, and if not, convert the IPv4 netbits
> to "unsigned int" as well, and get rid of the if() statement there as
> well.
>
> Thanks for reporting this. =A0I'll look into it.
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 gert@...1296...
> fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gert@=
...1297...

