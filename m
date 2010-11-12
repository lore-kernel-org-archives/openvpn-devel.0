Message-ID: <4CDD7D32.2050401@...515...>
Date: Fri, 12 Nov 2010 19:45:22 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4CDD641F.30408@...515...>
	<20101112163620.27677.qmail@...1287...>	<4CDD704B.7080505@...1114...>
	<20101112165541.29963.qmail@...1287...>
	<4CDD7309.3030808@...1114...> <4CDD7559.5000604@...515...>
	<4CDD77B9.8050606@...1114...>
In-Reply-To: <4CDD77B9.8050606@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool dependency
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


> > What if build_all.py did this:
>
> > - Check if SIGNTOOL is enabled in settings.in:
> >   - Yes: fail if can't import "sign" module
> >   - No: don't fail if can't import "sign" module
>
> > I think existence of the SIGNTOOL variable gives a good clue of user's
> > intentions. Note that the build will also fail if SIGNTOOL is defined
> > and signtool.exe is not copied to the correct place
> > (../signtool/signtool.exe).
>
>
> That's fine ... but what Peter raises as a concern, which I do agree to,
> is that if James' build system is changed and the driver is not signed,
> earlier this would cause to a halt in the building process.  With your
> patch, OpenVPN + the driver will be built and not signed.
>
> So it's just to catch that "yes, we want to do a build without signing
> the driver" and to really sign-off that explicitly when doing the build.
>  As James' should never do a release build without signing the driver.
Peter: settings.in is stored in git.

I agree that there should be no way one could make an unsigned build by
mistake. I think dazo's suggestion about having a command-line switch
("force unsigned build") is a good one. The SIGNTOOL variable could then
be used to just locate signtool.exe and nothing else. This would make it
behave the same way as most other variables in "settings.in" and allow
making signed and unsigned builds using the same configuration file.

Samuli

