MIME-Version: 1.0
In-Reply-To: <4FAD2F8C.6000709@...515...>
References: <4FAD2F8C.6000709@...515...>
Date: Fri, 11 May 2012 18:33:04 +0300
Message-ID: <CAOazyz2CTnp1po+kzFqVZ53StC6dbbjDOAOfNyU17R7r01QajA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] First partially-working snapshot build for
 Windows now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Samuli,

This is great!
I don't have any issue with building the openvpn-gui... can you please
send me what wrong with that?
I use that[1] patched one that should be downloaded during build process.

Alon.

[1] https://github.com/alonbl/openvpn-gui/downloads

On Fri, May 11, 2012 at 6:26 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi all,
>
> I finally managed to generate fairly crude OpenVPN Windows installers
> using Alon's new openvpn-build buildsystem. Due to a build issue
> "openvpn-gui" is not included, and the tap-driver is seems to be
> unsigned. Regardless, here are the results nevertheless:
>
> <http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master-=
I000_master-i686.exe>
> <http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master-=
I000_master-x86_64.exe>
>
> All of the libraries and executables have been signed with a self-signed
> test key. This includes openssl libraries and such. If you want Windows
> to trust these executables, you need to download this certificate:
>
> <http://build.openvpn.net/downloads/openvpntestca-cert.cer>
>
> Then you need to import it to your "Trusted CA" key store, e.g. with
>
>> certutil -user -addstore Root openvpntestca-cert.cer
>
> After this Windows should not complain about an unknown publisher. I'll
> try to come up with really usable installer next week.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

