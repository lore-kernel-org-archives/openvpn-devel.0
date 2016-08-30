References: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
	<0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
	<1472510288.61594.720.camel@...1866...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <792a45a7-118c-34f8-cbec-ae0bff99a748@...515...>
Date: Tue, 30 Aug 2016 11:11:59 +0300
MIME-Version: 1.0
In-Reply-To: <1472510288.61594.720.camel@...1866...>
Subject: Re: [Openvpn-devel] Fixing non-standard PKCS#11 serialization
 format using a patched pkcs11-helper?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>, David Sommerseth <openvpn@...2080...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> With that in mind, if shipping a patched pkcs11-helper in Windows
>> makes your life easier I'd consider doing this.  But step carefully,
>> avoid getting in a situation where you suddenly have to maintain these
>> patches yourself.  Rather try to see what Fedora does and see if that
>> can be re-used as much as possible.
>
> The Fedora patch for adding RFC7512 support is precisely the same as in
> the open pull request at https://github.com/OpenSC/pkcs11-helper/pull/4
>
> It shouldn't need much ongoing maintenance. But I do definitely think
> it would be good to move away from pkcs11-helper completely. I'd
> actually like to remove it from Fedora entirely. There are only a small
> handful of projects which use it, and they can all be fixed.

Given the state of 2.4 ("almost there") I think we should, at most,=20
apply Fedora's patch to pkcs11-helper in Windows 2.4 installers. The=20
long-term fix should (imho) wait until 2.5.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

