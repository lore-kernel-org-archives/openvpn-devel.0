Message-ID: <4D2E139D.8020809@...1147...>
Date: Wed, 12 Jan 2011 21:48:29 +0100
From: Jan Just Keijser <janjust@...1147...>
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: OpenVPN developers <openvpn-devel@lists.sourceforge.net>, OpenVPN List <openvpn-users@lists.sourceforge.net>

Hi David,

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
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
>
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
>
>   - openvpn server options
>       Describes only the options which are relevant for openvpn servers
>
>   - openvpn client options
>       Describes only options useful for openvpn clients
>
>   - openvpn plug-ins
>       Describes the different script plug-in hooks and environment
>       variables available to scripts and plug-ins written in C
>
> * Review the contents of all the documentation, check their accuracy
>   - Make sure no options are not available in OpenVPN 2.2 or later
>   - Make sure no options are missing in the documentation, which is
>     available in the source code  (options.c is a good reference)
>
> * Review and check if all external references
>   - Make sure all references to external sources, like web-sites, are
>     still available, valid and relevant in the document context
>   - Find other external resources which are worth including.
>
> (These points are not carved into stone, but is more like a guideline of
> what needs to be considered)
>
> This task should hopefully not require too much in-depth development
> knowledge.  It should be user-focused, so that we avoid using terms and
> details which is not so easy to understand.  What I'm saying is that
> this documentation can be more useful and readable if users are involved
> in this process.
>
> If someone are willing to step up and take a lead, that would be great!
>  Further, discussions and reviews of the document changes should
> probably happen on the openvpn-users mailing list.  That way, it might
> be easier for users to review the documentation and provide feedback.
>
> We don't want this to just be a solo-project from someone in our OpenVPN
> community, so we hope more people can help out and contribute, also if
> you don't consider yourself a developer.
>   
I'd be willing to contribute but I don't see myself leading this effort 
right now (due to other obligations).
As for the document format: if we want users to contribute then we 
should not opt for a too-difficult format that users would have to learn 
before being able to contribute. Docbook and/or texinfo are nice for 
Linux users but you'd scare away most Windows/Mac users.
What about plain simple OpenDoc (odf) ?

cheers,

JJK


