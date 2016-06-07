References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<20160607075659.GM53051@...1296...>
	<448a7afe-aece-b97b-a6ea-afb8f1b8526e@...515...>
	<20160607082014.GQ53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c9f169cd-6b2d-292c-eef0-2204d778a85e@...515...>
Date: Tue, 7 Jun 2016 13:39:22 +0300
MIME-Version: 1.0
In-Reply-To: <20160607082014.GQ53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
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


>> It seems that a summary of how Vagrant operates is in order here.
>>
>> Vagrant uses pre-built images as a starting point. These images do not
>> (and should not) be built by OpenVPN developers. The only things _we_
>> have to maintain are the Vagrant files, which are basically recipies for
>> configuring the base boxes into an OpenVPN test VMs.
>>
>> So, when a developer wants to run the integration tests this is what
>> happens:
>>
>> - Vagrant fetches the pre-built VM images from a remote source
>> - The image is launched into Virtualbox (or other virtualization system)
>> - Vagrant runs the initialization scripts in the Vagrantfile
>> - The system is ready to use and stored for future use
>
> So what VM images are available today, especially regarding *BSD, Solaris,
> MacOS?  Who would be maintaining them, like, adding OS updates, installing
> the tools needed to build OpenVPN (on a fresh Solaris system, you can't
> build *anything*, for example)...

Take a look here:

<https://atlas.hashicorp.com/boxes/search?vagrantcloud=3D1>

All the *BSD and Solaris seem to be covered. There are probably other=20
sources of Vagrant boxes, but that is the usual place to look for.

>> Summary: very little maintenance is required for Vagrant. It is not like
>> buildbot, where we actually have to build the VMs from scratch.
>
> This sounds great but I have a hard time actually believing it...

This is because you are a non-believer. And that in turn is because you=20
have not tried Vagrant :). But seriously, Vagrant is an excellent tool=20
for managing testing environments, and in our case for reproducing=20
OS-specific problems. If you choose to not use the default (Virtualbox)=20
then you will have more trouble, but it's still doable.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

