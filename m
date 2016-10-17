References: <294517a1-1e4d-023d-1b86-75d06387ac15@...515...>
	<20161017085010.qipujrn3lddggsjb@...1152...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <3e00be3e-94be-f461-60f5-ab35e640dba6@...515...>
Date: Mon, 17 Oct 2016 13:58:20 +0300
MIME-Version: 1.0
In-Reply-To: <20161017085010.qipujrn3lddggsjb@...1152...>
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

Il 17/10/2016 11:50, Ralf Hildebrandt ha scritto:
> * Samuli Sepp=C3=A4nen <samuli@...515...>:
>> Hi,
>>
>> Should we have a separate apt repository for "unstable" apt packages?
>
> Yes please. Do have a look at how dovecot does it:
> http://wiki2.dovecot.org/PrebuiltBinaries#Debian
>
> there is "stable" and "testing"
>

Thanks to all for the feedback. Based on it the most flexible approach=20
would probably be to have four different repositories:

"testing": tracks latest release, including all alphas/beta/rcs
"stable": tracks latest stable release (2.3.x/2.4.x)
"release/2.3": tracks latest 2.3.x release
"release/2.4": tracks latest 2.4 release (including alphas/beta/rcs)

The current apt repository would become "release/2.3" to minimize=20
surprises. In all cases the package name would be "openvpn". A user=20
could have several of these repositories enabled at the same time - apt=20
would then just default to the latest version.

Right now Debian package building is not fully automated, but when it=20
is, having a "snapshots" repository would make sense.

I'd rather not allow several different OpenVPN packages to co-exist on a=20
single computer (e.g. "openvpn-2.3" and "openvpn-2.4"): that tends to=20
complicate packaging without any significant benefits. I believe this=20
approach is mostly used in cases where different application versions=20
are (protocol)incompatible, and users need to be able to use both=20
simultaneously.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

