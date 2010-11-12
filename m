Message-ID: <4CDD7559.5000604@...515...>
Date: Fri, 12 Nov 2010 19:11:53 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...>
In-Reply-To: <4CDD7309.3030808@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool	dependency
 from win/build_all.py
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On 12/11/10 17:55, Peter Stuge wrote:
> > David Sommerseth wrote:
> >>>> Modified win/build_all.py so that build does not fail even if
> >>>> the optional signtool python class is not available.
> >>> What is it needed for? Is it really *always* optional?
> >> If I've understood it correctly, this is related to signing the Windows
> >> TUN/TAP driver.
> > Right.
>
>
> >> So if you don't have a signing key/tool available, it is still
> >> possible to build the rest of OpenVPN.
> > Fine, but this is not really acceptable when James&co builds OpenVPN,
> > so I am requesting a solution that allows them to specify to the
> > build process that they want a fatal error if signing is not
> > possible.
>
> That's a good point!  I didn't think about this one.
>
> What about that the build script stops up and asks if it should continue
> without signing?  And in addition having a command line argument
> accepting building without signing?  This latter one is more useful for
> automated community builds of the allmerged branch from
> openvpn-testing.git.
>
>
> kind regards,
>
> David Sommerseth
What if build_all.py did this:

- Check if SIGNTOOL is enabled in settings.in:
  - Yes: fail if can't import "sign" module
  - No: don't fail if can't import "sign" module

I think existence of the SIGNTOOL variable gives a good clue of user's
intentions. Note that the build will also fail if SIGNTOOL is defined
and signtool.exe is not copied to the correct place
(../signtool/signtool.exe).

Samuli



