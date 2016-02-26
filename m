References: <1456171763-44172-1-git-send-email-fish.thss@...277...>
	<20160225122928.GC24952@...1296...>
	<56CEF9E5.3090508@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56CFFC9F.2010506@...515...>
Date: Fri, 26 Feb 2016 09:19:59 +0200
MIME-Version: 1.0
In-Reply-To: <56CEF9E5.3090508@...2080...>
Subject: Re: [Openvpn-devel] The puprose of the Signed-off-by: line
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, Fish <fish.thss@...277...>


> The reason of adding the Signed-off-by is to have a better understanding
> of whom have been involved in particular commits/patches.  While the
> "Author field" in the git log (git log --pretty=3Dfuller) can only have
> one name, more people can have been involved in the patch.  Using the
> Signed-off-by is a way to credit them as well.
>
> And when everyone is consistent using the Signed-off-by line, writing
> tools which parses our git log is also far more easier.
>
> The other aspect of the Signed-off-by: line has to do with juridical
> stuff, to protect the OpenVPN project.  By adding the Signed-off-by:
> line you basically sign-off to "Yes, I am the author of these changes
> and I am permitted to share them with the project".  For more
> information, these pages explains it even better (same info, two
> different sources):
> <https://git.eclipse.org/r/Documentation/user-signedoffby.html>
> <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/SubmittingPatches#n409>

Hi David,

Looks like the rationale for Signed-off-by by is not properly documented=20
in Trac:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>

David: do you want to integrate above explanation to Trac or shall I?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

