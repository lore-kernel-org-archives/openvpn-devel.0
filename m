MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz1+mcBLnt7Uqd5_h75VmcLvWjXz1==u_-FW6wNOzcW+mQ@...278...>
References: <4F632647.30603@...515...>
	<CAOazyz1+mcBLnt7Uqd5_h75VmcLvWjXz1==u_-FW6wNOzcW+mQ@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Fri, 16 Mar 2012 14:29:22 +0100
Message-ID: <CAP+U6tJySV=3tDipKtym7sS+M0jy1ZBFjc6sEVRs_2wQ=vYrrA@...278...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

2012/3/16 Alon Bar-Lev <alon.barlev@...277...>:
> If we do not want to do auto detection, enabling optional components
> may lead to configure failure, and force the user to explicitly
> disable this feature.
>
> It is possible, and I don't mind so much, however, I prefer configure
> to use the minimum absolutely needed components by default, and in
> majority of valid cases succeed.
>
> Disabling by default does not effect users nor building via build
> script nor building via package management (rpmbuild, deb). It only
> effects people who build manually from sources.

In my opinion, the build defaults should reflect what the project
considers as the recommended defaults - the features we want to see in
every typical OpenVPN server and client. Apart from the
Windows-binaries, the _source_ is the relevant artefact that gets
released as official "OpenVPN" and therefore the defaults in the build
system are important.

If we want to avoid confusing compile-time errors, we should present
useful and informative warnings to the user at configure-time: "Could
not find library X, if you want to compile without support for X, pass
--disable-X" or something similar. No need to hide this from the user.
(I haven't looked at the build system, so this type of error message
might already be present.)

While building a piece of software I often notice additional
dependencies based on what configure tells me. This then causes me to
install additional dev-packages / libraries before continuing
compilation. If we simply cut down the dependencies I'd probably
notice a missing feature much later, e.g. while debugging connection
problems...

The usual

  $ ./configure
  $ make
  $ make install

... should hold as few surprises as possible, IMHO.

Cheers
Fabian

