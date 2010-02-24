Message-ID: <4B855916.9080702@...1114...>
Date: Wed, 24 Feb 2010 17:51:34 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <201002241424.39312.mailinglists@...1145...>
In-Reply-To: <201002241424.39312.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] Gentoo Git-Live-Ebuild
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?TWFyY2VsIFBlbm5ld2nDnw==?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/02/10 14:24, Marcel Pennewiß wrote:
> Hi,
> 
> following the discussions and new patches i adapted the current Gentoo Ebuild 
> to use the allmerged-testing-tree (openvpn-9999.ebuild). 
> 
> I'll try to keep it working and also i'll try to support the ebuilds on the 
> openvpn-devel mailinglist ;) The Ebuilds and all associated files can be found
> in our Gentoo-FeM-Overlay which can be accessed
> 
> via HTTP / Subversion:
> http://subversion.fem.tu-ilmenau.de/repository/fem-overlay/trunk/net-
> misc/openvpn/

Perfect!  Thanks a lot for this!

I looked through the ebuild, and I see you apply two patches.  Are they
Gentoo specific, or is it something we should consider pulling into the
the testing tree?

Please have a look here for some extra details, especially pay attention
to the "Configure and compile" section.

<http://www.secure-computing.net/wiki/index.php/OpenVPN/Documentation_for_testers>

> This is a slotted Ebuild so that a normal openvpn version can be installed 
> parallel to the dev-ebuild where the bin, init-script and manpage are renamed 
> to openvpn-dev. with the init script you can reuse the existing configs which 
> will be nice for testing on productive systems. For a better bugreporting the 
> ebuild append the commit ID  (e.g. "OpenVPN 2.1.1b-
> git-6f53b4bf5f9b40dd96aecfcf325b0095f9ef3285").

Very good!  And having that commit ID is crucial for debugging.  Even
though, you can shorten the commit ID down to the first ~12 bytes.  Even
shorter can work as well, but it might not be that unique any more.
10-14 bytes should be safe enough, though.

> In march i'll try to setup a full ipv6-setup using Gert's payload-patch. This 
> setup could be tested by our members during daily use. 

Wonderful!  Please keep us updated, as this is really interesting to get

>Maybe some livebuilds 
> for ubuntu/debian will be available then?

Yes, this will happen as well.  Not sure about the timeline for it yet,
but there has been discussions with the Debian maintainer about this.
Regarding Ubuntu, they just pick the Debian work.

> best regards and big thx for spending your valuable time 

And thank you for getting this into Gentoo!  I will even enable this one
on one of my Gentoo servers where OpenVPN is already running! :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuFWRMACgkQDC186MBRfrr6XQCbB/FEokgQERygcevzYiwEzH07
OygAn39oyf+dAe7UI22GwJIo2lUybY4F
=Z8t3
-----END PGP SIGNATURE-----

