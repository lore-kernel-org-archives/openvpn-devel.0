References: <3dbe8ad1-b62e-3802-06a9-920c46616451@...515...>
	<20160907093100.GF78279@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <745fdc9c-9091-9263-c25a-6f2b52236d00@...515...>
Date: Wed, 7 Sep 2016 13:40:43 +0300
MIME-Version: 1.0
In-Reply-To: <20160907093100.GF78279@...1296...>
Subject: Re: [Openvpn-devel] Dropping Windows Vista / XP support?
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> Hi,
>
> On Wed, Sep 07, 2016 at 12:18:17PM +0300, Samuli Sepp=E4nen wrote:
>> We have already dropped XP support from OpenVPN Git "master". I think
>> now is the time to drop official XP support altogether, but to maintain
>> Vista support util the next tap-windows6 release.
>
> As long as XP is in widespread use, I think we should provide up-to-date
> and secure 2.3.x builds.  Worst thing we can do is "not provide updates"
> in case a new openssl (or openvpn) bug shows up, and leave users out
> in the cold.  So this means about 2-3 more years, I think...  (do you
> have numbers how many people still download the XP installers?)

I can probably get download numbers for I00x (openvpn+tap-windows)=20
installers.

> Note that the microsoft guidelines do not say "no more SHA1" but
> "no SHA1 *unless* targeting Vista", which we do - so there must be a
> way to get updated SHA1 certificates...

This probably depends greatly on the CA. In our case (Digicert) SHA1 is=20
no longer an option (or so I'm told).

> What we should do, though, is declare and document a strict "end of XP
> support" policy, like "January 1st, 2018", make this very obvious in the
> installer (maybe even "add a separate acknowledgment popup"), AND refuse
> to actually start the GUI after that date (or so)...

That makes sense. I also think that "January 1st, 2018" is as good a=20
deadline as any.

The next 2.3.x I00x installer should implement the warning box. I think=20
we should also let XP users know on the website and in the release=20
announcement that seeing the "Unknown publisher" box is normal and is=20
because XP does not support SHA1.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

