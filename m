References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<20161017085010.qipujrn3lddggsjb@...1152...>
	<3e00be3e-94be-f461-60f5-ab35e640dba6@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <2fe9dfd9-9151-e4d7-d5ff-9e678f96811a@...515...>
Date: Tue, 25 Oct 2016 15:02:47 +0300
MIME-Version: 1.0
In-Reply-To: <3e00be3e-94be-f461-60f5-ab35e640dba6@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Separate apt repositories for
 2.4-alpha/beta/rc releases?
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
To: Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>, openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 17/10/2016 13:58, Samuli Sepp=C3=A4nen ha scritto:
> Il 17/10/2016 11:50, Ralf Hildebrandt ha scritto:
>> * Samuli Sepp=C3=A4nen <samuli@...515...>:
>>> Hi,
>>>
>>> Should we have a separate apt repository for "unstable" apt packages?
>>
>> Yes please. Do have a look at how dovecot does it:
>> http://wiki2.dovecot.org/PrebuiltBinaries#Debian
>>
>> there is "stable" and "testing"
>>
>
> Thanks to all for the feedback. Based on it the most flexible approach
> would probably be to have four different repositories:
>
> "testing": tracks latest release, including all alphas/beta/rcs
> "stable": tracks latest stable release (2.3.x/2.4.x)
> "release/2.3": tracks latest 2.3.x release
> "release/2.4": tracks latest 2.4 release (including alphas/beta/rcs)
>
> The current apt repository would become "release/2.3" to minimize
> surprises. In all cases the package name would be "openvpn". A user
> could have several of these repositories enabled at the same time - apt
> would then just default to the latest version.
>
> Right now Debian package building is not fully automated, but when it
> is, having a "snapshots" repository would make sense.
>
> I'd rather not allow several different OpenVPN packages to co-exist on a
> single computer (e.g. "openvpn-2.3" and "openvpn-2.4"): that tends to
> complicate packaging without any significant benefits. I believe this
> approach is mostly used in cases where different application versions
> are (protocol)incompatible, and users need to be able to use both
> simultaneously.
>

Hi all,

The four new apt repositories described above are now available.=20
Instructions for setting them up are here:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

OpenVPN 2.4_alpha2 is available in "release/2.4" and "testing"
OpenVPN 2.3.12     is available in "release/2.3" and "stable

Once the new repos have been online for a while and are proven to work,=20
I will look into redirecting requests to the old swupdate repository to=20
the new "release/2.3" repository.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

