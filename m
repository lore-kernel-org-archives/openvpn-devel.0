Message-ID: <559110DC.5010305@...515...>
Date: Mon, 29 Jun 2015 12:33:16 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <558AD438.9050105@...515...> <20150628182415.GA17713@...1281...>
In-Reply-To: <20150628182415.GA17713@...1281...>
Subject: Re: [Openvpn-devel] Writing an OpenVPN-specific NSSM configuration
 frontend?
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
To: =?windows-1252?Q?Pasi_K=E4rkk=E4inen?= <pasik@...124...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On Wed, Jun 24, 2015 at 07:00:56PM +0300, Samuli Sepp=E4nen wrote:
>> Hi,
>>
>> There is a question at the end, so scroll down if you're impatient :).
>> Anyways, some of you may know I've been looking into NSSM:
>>
>> <http://nssm.cc>
>>
>> The idea is to use NSSM to replace the OpenVPN Service Wrapper
>> ("openvpnserv.exe") which is buggy, unmaintained, causes all sorts of
>> issues and seems disintegrate more and more with every new Windows relea=
se.
>>
>> NSSM on is actively maintained[1] general purpose service manager which
>> can launch an arbitrary program and restart it if it crashes. NSSM
>> registers itself as a Windows service and manages a set of services,
>> which can be arbitrary programs. In our case nssm.exe would run a
>> command such as this:
>>
>> ..\bin\openvpn.exe --config default.ovpn
>>
>> The working directory would be set to C:\Program Files\OpenVPN\config.
>>
> If changing the OpenVPN Windows stuff, please also support having config =
files under user's profile directory,
> not only in the system-wide config-directory.
>
> -- Pasi
>
Hi,

Nssm.exe does not seem to care at all where the configuration files are=20
located. It just launches processes and monitors them.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


