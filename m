Message-ID: <4D2D68E0.9080702@...68...>
Date: Wed, 12 Jan 2011 09:40:00 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D2C3D0A.2060607@...1114...>
In-Reply-To: <4D2C3D0A.2060607@...1114...>
Subject: Re: [Openvpn-devel] OpenVPN documentation (man page) review
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
To: openvpn-devel@lists.sourceforge.net

Am 11.01.2011 12:20, schrieb David Sommerseth:
> 
> Hi folks!
> 
> This is a little cry for help from us playing with the OpenVPN code.
> 
> We have a quite good man page today with a lot of information.  But
> maintaining it and to make sure it is up-to-date with all the features
> OpenVPN supports is often not high up on the priority list.  In
> addition, the current format (one single file, in pure man page format)
> is getting harder and harder to maintain as well.
> 
> So, we're hoping some people with some English skills is interested to
> help out improving this situation.  What we immediately would like to
> see is something along these lines:
> 
> * Move the man page to a better format than the pure man page format.
>   Are there some good tools/formats like ascii2man or DocBookXML which
>   could help easing the maintenance of our documentation?

Docbook XML for sure is a lot more verbose than asciidoc or roff.  I would tend
to avoid Docbook, the toolchains are lacking a bit -- still :-( although xmlto +
fop can yield reasonable PDF results.

However, we should make sure that there still is something that works with "man".

> * Split up the documentation into more focused sections, like
>   - main openvpn page (kind of like openvpn.8 today)
>       Gives an executive overview over OpenVPN, features and references
>       to the other documentation pages.  A bonus would be if it easily
>       can produce other formats in addition, like HTML, PS/PDF, ePub.
> 
>   - openvpn common options
>       Gives information about the common options openvpn has, which is
>       useful on both server and client instances.  F.ex. --keepalive,
>       --tls-auth, --cert, --key, --ca, etc

Should be part of the main page.

>   - openvpn server options
>       Describes only the options which are relevant for openvpn servers
> 
>   - openvpn client options
>       Describes only options useful for openvpn clients

Not sure if that's useful and actually reduces confusion this way.

Basically what you want is more (a) a concise HOWTO (more or less in place on
the website), and (b) an exhaustive reference, no?

-- 
Matthias Andree

