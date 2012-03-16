MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz11zNQO+5whPA=-LD-mXqfcNCEvqy2iF-vY-NChivB2kg@...278...>
References: <4F632647.30603@...515...>
	<CAOazyz1+mcBLnt7Uqd5_h75VmcLvWjXz1==u_-FW6wNOzcW+mQ@...278...>
	<CAP+U6tJySV=3tDipKtym7sS+M0jy1ZBFjc6sEVRs_2wQ=vYrrA@...278...>
	<CAOazyz11zNQO+5whPA=-LD-mXqfcNCEvqy2iF-vY-NChivB2kg@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Fri, 16 Mar 2012 15:23:12 +0100
Message-ID: <CAP+U6tL57Fv=hqEGN3HAG4Pp0uiOacanNcVyS+qDinKmfjvUvw@...278...>
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

Hi Alon,

2012/3/16 Alon Bar-Lev <alon.barlev@...277...>:
> On Fri, Mar 16, 2012 at 3:29 PM, Fabian Knittel
> <fabian.knittel@...1547...> wrote:
>> In my opinion, the build defaults should reflect what the project
>> considers as the recommended defaults - the features we want to see in
>> every typical OpenVPN server and client.
>
> I strongly against that approach.
> This is a common mix up between distribution and software project.
>
> A software project provides the possibility of using the software in
> different configurations.
> A distribution is in charge of the "typical" configuration.

A typical free software project distributes the source as the primary
artefact, correct.  IMHO it also communicates a set of defaults,
especially for software that needs to interact across platforms and
architectures.  Part of communicating what those defaults are, is done
by providing a default build configuration.

A dedicated distribution project (like Gentoo or Debian) is in charge
of allowing a set of software to properly run (binary distribution) or
compile (source distribution) in combination with all the other
available software.
Whether the program is built on a 64 bit processor, where the
libraries are to be found, which SSL library is to be used, etc. are
questions a distribution may answer for you. Whether to enable
encryption or a specific compression mode would be something that the
distribution should only fiddle with in special cases (for example if
it's an embedded distribution).

I don't want to be able to connect to an OpenVPN server depending on
what distribution it was built on.


> Your comment is true for rhel packager, people expect that yum install
> openvpn will be a "typical" rhel configuration, what exactly this
> configuration is depends on distribution procedures.

OpenVPN provides a source distribution. People expect configure, make,
make install to provide a "typical" OpenVPN configuration.

> Why is lzo different than PKCS#11 or selinux? Which are "typical"?
> Mind "typical" is probably different between server and client.

It's not. I'm just saying that what we set as a default in the build
system is meaningful and should match what we document as the default
in the rest of the documentation.

> The software project should not make any assumption of its usage, nor
> enable/disable features for the sake of best practices instead of
> proper documentation.

Setting build defaults is a communication device which should be used
_in addition_ to other documentation.

Cheers
Fabian

